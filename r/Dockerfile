FROM rocker/r-ver:4.1.3

MAINTAINER Dave Tang <me@davetang.org>

LABEL source="https://github.com/davetang/learning_docker/r"

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
      wget \
      curl \
      zlib1g-dev \
      python3-pip \
      pandoc \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cmake_ver=3.23.1 && \
   cd /tmp/ && \
   wget https://github.com/Kitware/CMake/releases/download/v${cmake_ver}/cmake-${cmake_ver}.tar.gz && \
   tar -zxf cmake-${cmake_ver}.tar.gz && \
   cd cmake-${cmake_ver} && \
   ./bootstrap && \
   make && \
   make install && \
   rm -rf /tmp/*

RUN Rscript -e "install.packages(c('rmarkdown', 'tidyverse'));"
RUN pip install --upgrade pip && pip install mkdocs

WORKDIR /work

CMD ["R", "--version"]

