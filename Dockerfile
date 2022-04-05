FROM ubuntu:16.04
SHELL ["/bin/bash", "-l", "-c"]

# ARG NODE_VERSION=16.13.1
ARG AUTO_VERSION=10.32.5

# Install NodeJS

RUN apt-get update
RUN apt-get install -y curl

# RUN curl https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz -o node.tar.xz
# RUN tar xvf node.tar.xz && rm node.tar.xz

# ENV PATH=$PATH:/node-v$NODE_VERSION-linux-x64/bin


RUN curl -vkL -o - https://github.com/intuit/auto/releases/download/v$AUTO_VERSION/auto-linux.gz | gunzip > ~/auto
RUN chmod a+x ~/auto
ENV PATH=$PATH:~/