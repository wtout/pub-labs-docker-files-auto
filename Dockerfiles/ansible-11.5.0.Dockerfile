# syntax=docker/dockerfile:1
ARG PYVERSION=3.13.2

FROM registry-1.docker.io/wtout/python:${PYVERSION}

ARG ANSVERSION
ARG PYVERSION

LABEL maintainer='Wassim Tout'
LABEL ansible-version=${ANSVERSION}
LABEL python-version=${PYVERSION}
LABEL description="This is a custom Docker image for Ansible ${ANSVERSION} on Ubuntu 24.04 LTS using Python ${PYVERSION}"

RUN useradd -m -d /home/ansible -s /bin/bash ansible && \
    echo "\n%ansible        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER ansible

ENV HOME /home/ansible
ENV PATH $PATH:$HOME/.local/bin

RUN export PYCMD=$(ls /usr/local/bin/|grep python|grep -v config) && \
    echo "alias python3=\"/usr/local/bin/${PYCMD}\"" >> ~/.bash_aliases && \
    packer plugins install github.com/hashicorp/vsphere && \
    ${PYCMD} -m pip install --user --no-cache-dir --upgrade pip && \
    ${PYCMD} -m pip install --user --no-cache-dir --upgrade setuptools && \
    ${PYCMD} -m pip install --user --no-cache-dir netaddr && \
    ${PYCMD} -m pip install --user --no-cache-dir wheel && \
    ${PYCMD} -m pip install --user --no-cache-dir pyvmomi && \
    ${PYCMD} -m pip install --user --no-cache-dir paramiko && \
    ${PYCMD} -m pip install --user --no-cache-dir pyjwt && \
    ${PYCMD} -m pip install --user --no-cache-dir dnspython && \
    ${PYCMD} -m pip install --user --no-cache-dir pycdlib && \
    ${PYCMD} -m pip install --user --no-cache-dir ansible-pylibssh && \
    ${PYCMD} -m pip install --user --no-cache-dir passlib && \
    ${PYCMD} -m pip install --user --no-cache-dir pysnmp && \
    ${PYCMD} -m pip install --user --no-cache-dir -I pyasn1==0.4.8 && \
    ${PYCMD} -m pip install --user --no-cache-dir cot[tab-completion] && \
    ${PYCMD} -m pip install --user --no-cache-dir --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    ${PYCMD} -m pip install --user --no-cache-dir -I ansible==${ANSVERSION} && \
    ${PYCMD} -m pip install --user --no-cache-dir --upgrade pyopenssl
