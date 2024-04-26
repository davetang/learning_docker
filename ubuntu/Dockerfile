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
      curl \
      nodejs \
      zlib1g-dev \
      libboost-all-dev \
      pkg-config \
      libgit2-dev \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# CMake
RUN cmake_ver=3.92.2 && cd /tmp/ && \
   wget https://github.com/Kitware/CMake/releases/download/v${cmake_ver}/cmake-${cmake_ver}.tar.gz && \
   tar -zxf cmake-${cmake_ver}.tar.gz && \
   cd cmake-${cmake_ver} && \
   ./bootstrap && \
   make && \
   make install && \
   rm -rf /tmp/*

# Miniconda3
RUN cd /tmp/ && \
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
   bash Miniconda3-latest-Linux-x86_64.sh -b -p ${HOME}/miniconda3 && \
   ${HOME}/miniconda3/condabin/conda install -y -c conda-forge mamba

# not sure why I cannot use ${HOME} with ENV
ENV PATH=/root/miniconda3/bin:${PATH}
RUN rm /tmp/Miniconda3-latest-Linux-x86_64.sh

WORKDIR /work
