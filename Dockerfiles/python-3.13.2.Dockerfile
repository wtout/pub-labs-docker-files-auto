# syntax=docker/dockerfile:1
FROM ubuntu:noble

ARG DEBIAN_FRONTEND=noninteractive

ARG PYVERSION

LABEL python-version=${PYVERSION}
LABEL description="This is a custom Docker image for Python ${PYVERSION} on Ubuntu 24.04 LTS"

RUN apt-get update && \
	apt-get install -y apt-utils && \
	apt-get install -y locales && rm -rf /var/lib/apt/lists/* && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
	apt-get reinstall -y bash && \
	apt-get install -y openssh-server && \
	apt-get install -y libssh-dev && \
	apt-get install -y build-essential && \
	apt-get install -y bind9-dnsutils && \
	apt-get install -y bash-doc && \
	apt-get install -y sudo && \
	apt-get install -y sshpass && \
	apt-get install -y snmp && \
	apt-get install -y curl && \
	apt-get install -y lsb-release && \
	apt-get install -y software-properties-common

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
	apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
	apt-get update && \
	apt-get install -y packer && \
	apt-get install -y wget && \
	apt-get install -y git && \
	apt-get install -y inetutils-ping && \
	apt-get install -y zlib1g-dev && \
	apt-get install -y libncurses5-dev && \
	apt-get install -y libgdbm-dev && \
	apt-get install -y libnss3-dev && \
	apt-get install -y libssl-dev && \
	apt-get install -y libreadline-dev && \
	apt-get install -y libffi-dev && \
	apt-get install -y libsqlite3-dev && \
	apt-get install -y libbz2-dev && \
	apt-get install -y bzip2 && \
	apt-get install -y p7zip-full && \
	apt-get install -y xorriso

RUN	wget https://www.python.org/ftp/python/${PYVERSION}/Python-${PYVERSION}.tgz && \
	tar xzf Python-${PYVERSION}.tgz && \
	cd Python-${PYVERSION} && \
	./configure --enable-optimizations && \
	make -j $(nproc) && \
	make altinstall

RUN rm -f Python-${PYVERSION}.tgz
