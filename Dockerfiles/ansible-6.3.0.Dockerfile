# syntax=docker/dockerfile:1
FROM registry-1.docker.io/wtout/python:3.9.6

ENV ANSVERSION=6.3.0

RUN useradd -d /home/ansible -s /bin/bash ansible && \
	echo -e "\nansible        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER ansible

ENV HOME /home/ansible
ENV PATH $PATH:$HOME/.local/bin

RUN echo -e "alias python3=\"/usr/local/bin/python3.9\"" >> /home/ansible/.bashrc && \
	source /home/ansible/.bashrc

RUN	export https_proxy="http://proxy.esl.cisco.com:8080" && \
	python3.9 -m pip install --user --upgrade pip && \
	python3.9 -m pip install --user --upgrade setuptools && \
	python3.9 -m pip install --user netaddr && \
	python3.9 -m pip install --user wheel && \
	python3.9 -m pip install --user pyvmomi && \
	python3.9 -m pip install --user paramiko && \
	python3.9 -m pip install --user pyjwt && \
	python3.9 -m pip install --user dnspython && \
	python3.9 -m pip install --user pycdlib && \
	python3.9 -m pip install --user ansible-pylibssh && \
	python3.9 -m pip install --user cot[tab-completion] && \
	python3.9 -m pip install --user --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
	python3.9 -m pip install --user --no-cache-dir -I ansible==${ANSVERSION} && \
	unset https_proxy
