FROM rocker/verse:4.4.0

MAINTAINER Dave Tang <me@davetang.org>

LABEL source="https://github.com/davetang/learning_docker/tensorflow"

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
      python-is-python3 \
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

RUN Rscript -e "install.packages(c('rmarkdown', 'tidymodels'));"
RUN pip install --upgrade pip && pip install tensorflow

WORKDIR /work
COPY --chown=rstudio:rstudio rstudio-prefs.json /home/rstudio/.config/rstudio
