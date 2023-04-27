FROM ubuntu:23.04

MAINTAINER Dave Tang <me@davetang.org>
LABEL source="https://github.com/davetang/learning_docker/blob/main/ubuntu/Dockerfile"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      autoconf \
      build-essential \
      default-jre \
      gettext \
      git-core \
      libhdf5-dev \
      libcurl4-gnutls-dev \
      libssl-dev \
      libxml2-dev \
      libpng-dev \
      libbz2-dev \
      liblzma-dev \
      libncurses-dev \
      ncurses-term \
      time \
      unzip \
      vim \
      pigz \
      wget \
      python3 \
      python3-pip \
      zlib1g-dev \
      libboost-all-dev \
      pkg-config \
      libgit2-dev \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# CMake
RUN cmake_ver=3.24.2 && cd /tmp/ && \
   wget https://github.com/Kitware/CMake/releases/download/v${cmake_ver}/cmake-${cmake_ver}.tar.gz && \
   tar -zxf cmake-${cmake_ver}.tar.gz && \
   cd cmake-${cmake_ver} && \
   ./bootstrap && \
   make && \
   make install && \
   rm -rf /tmp/*

# commonly used bioinfo packages
RUN pip install pandas pysam pyvcf

WORKDIR /work
