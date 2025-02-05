# syntax=docker/dockerfile:1
FROM centos:7.7.1908

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV CENTOS_FRONTEND=noninteractive
ENV PROXY http://proxy.esl.cisco.com:8080

RUN sed -i -e 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-* && \
	sed -i -e 's/mirrorlist=/#mirrorlist=/g' /etc/yum.conf && \
	sed -E -i -e 's/#baseurl=http:\/\/mirror.centos.org\/centos\/\$releasever\/([[:alnum:]_-]*)\/\$basearch\//baseurl=https:\/\/vault.centos.org\/7.7.1908\/\1\/\$basearch\//g' /etc/yum.repos.d/CentOS-* && \
	sed -E -i -e 's/#baseurl=http:\/\/mirror.centos.org\/centos\/\$releasever\/([[:alnum:]_-]*)\/\$basearch\//baseurl=https:\/\/vault.centos.org\/7.7.1908\/\1\/\$basearch\//g' /etc/yum.conf

RUN echo -e "proxy=${PROXY}" >> /etc/yum.conf && \
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
	yum install -y genisoimage && \
	yum install -y xorriso && \
	sed -i '/^proxy=.*$/,+d' /etc/yum.conf

RUN	export https_proxy="${PROXY}" && \
	wget https://www.python.org/ftp/python/3.9.6/Python-3.9.6.tgz && \
	tar xzf Python-3.9.6.tgz && \
	cd Python-3.9.6 && \
	./configure --enable-optimizations && \
	make altinstall && \
	unset https_proxy
