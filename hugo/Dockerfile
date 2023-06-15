FROM ubuntu:23.04

MAINTAINER Dave Tang <me@davetang.org>
LABEL source="https://github.com/davetang/learning_docker/blob/main/hugo/Dockerfile"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      wget \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG hugo_ver=0.113.0

RUN cd /tmp && \
   wget --quiet https://github.com/gohugoio/hugo/releases/download/v${hugo_ver}/hugo_extended_${hugo_ver}_linux-amd64.tar.gz && \
   tar -xzf hugo_extended_${hugo_ver}_linux-amd64.tar.gz && \
   mv hugo /usr/local/bin && \
   rm -rf /tmp/*

ENTRYPOINT ["hugo"]
