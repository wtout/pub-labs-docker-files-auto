# syntax=docker/dockerfile:1
ARG PYVERSION=3.13.2

FROM registry-1.docker.io/wtout/python:${PYVERSION}

ARG ANSVERSION
ARG PYVERSION

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
    ${PYCMD} -m pip install --user --upgrade pip && \
    ${PYCMD} -m pip install --user --upgrade setuptools && \
    ${PYCMD} -m pip install --user netaddr && \
    ${PYCMD} -m pip install --user wheel && \
    ${PYCMD} -m pip install --user pyvmomi && \
    ${PYCMD} -m pip install --user paramiko && \
    ${PYCMD} -m pip install --user pyjwt && \
    ${PYCMD} -m pip install --user dnspython && \
    ${PYCMD} -m pip install --user pycdlib && \
    ${PYCMD} -m pip install --user ansible-pylibssh && \
    ${PYCMD} -m pip install --user passlib && \
    ${PYCMD} -m pip install --user pysnmp && \
    ${PYCMD} -m pip install --user -I pyasn1==0.4.8 && \
    ${PYCMD} -m pip install --user cot[tab-completion] && \
    ${PYCMD} -m pip install --user --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    ${PYCMD} -m pip install --user --no-cache-dir -I ansible==${ANSVERSION} && \
    ${PYCMD} -m pip install --user --upgrade pyopenssl
