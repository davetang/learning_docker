FROM ubuntu:18.04

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      autotools-dev \
      build-essential \
      cmake \
      g++ \
      git \
      libbz2-dev \
      libboost-all-dev \
      libcurl4-gnutls-dev \
      libhdf5-dev \
      libicu-dev \
      libjsoncpp-dev \
      libpng-dev \
      libssl-dev \
      libxml2-dev \
      python-dev \
      tree
      unzip \
      vim \
      wget \
      zlib1g-dev \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

