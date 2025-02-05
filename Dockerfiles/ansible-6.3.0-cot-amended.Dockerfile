# syntax=docker/dockerfile:1
FROM registry-1.docker.io/wtout/ansible:6.3.0

USER root

RUN sed -i -e 's/mirrorlist=/#mirrorlist=/g' /etc/yum.repos.d/CentOS-* && \
	sed -i -e 's/mirrorlist=/#mirrorlist=/g' /etc/yum.conf && \
	sed -E -i -e 's/#baseurl=http:\/\/mirror.centos.org\/centos\/\$releasever\/([[:alnum:]_-]*)\/\$basearch\//baseurl=https:\/\/vault.centos.org\/7.7.1908\/\1\/\$basearch\//g' /etc/yum.repos.d/CentOS-* && \
	sed -E -i -e 's/#baseurl=http:\/\/mirror.centos.org\/centos\/\$releasever\/([[:alnum:]_-]*)\/\$basearch\//baseurl=https:\/\/vault.centos.org\/7.7.1908\/\1\/\$basearch\//g' /etc/yum.conf

RUN echo -e "proxy=http://proxy.esl.cisco.com:8080" >> /etc/yum.conf && \
	yum install -y genisoimage && \
	yum install -y xorriso && \
	sed -i '/^proxy=.*$/,+d' /etc/yum.conf

USER ansible

ENV HOME /home/ansible
ENV PATH $PATH:$HOME/.local/bin

RUN	export https_proxy="http://proxy.esl.cisco.com:8080" && \
	python3.9 -m pip install --user cot[tab-completion] && \
	unset https_proxy
