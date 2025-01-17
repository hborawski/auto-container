FROM ubuntu:18.04
SHELL ["/bin/bash", "-l", "-c"]

ARG NODE_VERSION=16.13.1
ARG RUBY_VERSION=2.7.2
ARG COCOAPODS_VERSION=1.11.2
ARG AUTO_VERSION=10.32.5

# Install NodeJS

RUN apt-get update
RUN apt-get install -y curl git bzip2 gcc build-essential

RUN curl https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz -o node.tar.xz
RUN tar xvf node.tar.xz && rm node.tar.xz

ENV PATH=$PATH:/node-v$NODE_VERSION-linux-x64/bin

# Install rbenv
RUN apt-get update && apt-get install rbenv -y

RUN useradd -ms /bin/bash cocoapods
USER cocoapods

RUN mkdir -p "$(rbenv root)"/plugins
RUN git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
RUN echo 'eval "$(rbenv init -)"' > ~/.bashrc
ENV PATH=$PATH:/home/cocoapods/.rbenv/shims
RUN rbenv install $RUBY_VERSION
RUN rbenv global $RUBY_VERSION
RUN gem install -v $COCOAPODS_VERSION cocoapods

RUN curl -vkL -o - https://github.com/intuit/auto/releases/download/v$AUTO_VERSION/auto-linux.gz | gunzip > ~/auto
RUN chmod a+x ~/auto
ENV PATH=$PATH:~/