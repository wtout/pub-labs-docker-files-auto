# syntax=docker/dockerfile:1
FROM registry-1.docker.io/wtout/python:3.11.8

ENV ANSVERSION=9.6.1

RUN useradd -m -d /home/ansible -s /bin/bash ansible && \
    echo "\n%ansible        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

USER ansible

ENV HOME /home/ansible
ENV PATH $PATH:$HOME/.local/bin

RUN export PYCMD=$(ls /usr/local/bin/|grep python|grep -v config) && \
    echo "alias python3=\"/usr/local/bin/${PYCMD}\"" >> ~/.bash_aliases

RUN packer plugins install github.com/hashicorp/vsphere

RUN PYCMD=$(ls /usr/local/bin/|grep python|grep -v config) && \
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
    ${PYCMD} -m pip install --user --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git && \
    ${PYCMD} -m pip install --user --no-cache-dir -I ansible==${ANSVERSION} && \
    ${PYCMD} -m pip install --user --upgrade pyopenssl
