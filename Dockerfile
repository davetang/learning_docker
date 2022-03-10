FROM ubuntu:18.04

MAINTAINER Dave Tang <me@davetang.org>

LABEL source="https://github.com/davetang/learning_docker/blob/main/Dockerfile"

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
		build-essential \
		wget \
		zlib1g-dev && \
    apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /src && \
    cd /src && \
    wget https://github.com/lh3/bwa/releases/download/v0.7.17/bwa-0.7.17.tar.bz2 && \
    tar xjf bwa-0.7.17.tar.bz2 && \
    cd bwa-0.7.17 && \
    make && \
    mv bwa /usr/local/bin && \
    cd && rm -rf /src

WORKDIR /work

CMD ["bwa"]

