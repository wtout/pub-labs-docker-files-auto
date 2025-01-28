# syntax=docker/dockerfile:1
FROM centos:7.7.1908

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV CENTOS_FRONTEND=noninteractive

RUN echo -e "proxy=http://proxy.esl.cisco.com:8080" >> /etc/yum.conf && \
	yum groupinstall -y "Development Tools" --setopt=group_package_types=mandatory,default,optional && \
	yum install -y bind-utils && \
	yum install -y which && \
	yum install -y sudo && \
	yum install -y sshpass && \
	yum install -y iproute && \
	yum install -y yum-utils && \
	yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo && \
	yum install -y packer && \
	yum install -y epel-release && \
	yum install -y wget && \
	yum install -y gcc && \
	yum install -y openssl-devel && \
	yum install -y bzip2-devel && \
	yum install -y libffi-devel && \
	yum install -y libselinux-python3 && \
	sed -i '/^proxy=.*$/,+d' /etc/yum.conf

RUN	export https_proxy="http://proxy.esl.cisco.com:8080" && \
	wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz && \
	tar xzf Python-3.9.6.tgz && \
	cd Python-3.9.6 && \
	./configure --enable-optimizations && \
	make altinstall && \
	unset https_proxy
