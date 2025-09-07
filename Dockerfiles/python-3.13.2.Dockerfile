# syntax=docker/dockerfile:1
FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

ARG PYVERSION

LABEL maintainer='Wassim Tout'
LABEL python-version=${PYVERSION}
LABEL description="This is a custom  container image for Python ${PYVERSION} on Ubuntu 24.04 LTS"

# Set up locale
RUN apt-get update && \
	apt-get install -y \
	apt-utils \
	locales && \
	localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install dependencies
RUN apt-get update && \
	apt-get reinstall -y bash && \
	apt-get install -y \
	openssh-server \
	libssh-dev \
	build-essential \
	bind9-dnsutils \
	bash-doc \
	sudo \
	sshpass \
	snmp \
	curl \
	lsb-release \
	software-properties-common && \
	apt-get install -y --only-upgrade python3-cryptography && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
	apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
	apt-get update && \
	apt-get install -y \
	packer \
	wget \
	git \
	inetutils-ping \
	zlib1g-dev \
	libncurses5-dev \
	libgdbm-dev \
	libnss3-dev \
	libssl-dev \
	libreadline-dev \
	libffi-dev \
	libsqlite3-dev \
	libbz2-dev \
	bzip2 \
	p7zip-full \
	xorriso && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python
RUN	wget https://www.python.org/ftp/python/${PYVERSION}/Python-${PYVERSION}.tgz && \
	tar xzf Python-${PYVERSION}.tgz && \
	cd Python-${PYVERSION} && \
	./configure --enable-optimizations && \
	make -j $(nproc) && \
	make altinstall && \
	cd .. && rm -rf Python-${PYVERSION} Python-${PYVERSION}.tgz
