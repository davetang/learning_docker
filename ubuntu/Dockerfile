FROM ubuntu:24.04

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
      cmake \
      bzip2 \
      ca-certificates \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CONDA_DIR=/opt/conda
RUN wget --quiet https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
    && bash Miniforge3-Linux-x86_64.sh -b -p $CONDA_DIR \
    && rm Miniforge3-Linux-x86_64.sh

# Put conda in PATH for all users (including root)
ENV PATH=$CONDA_DIR/bin:$PATH

WORKDIR /work
