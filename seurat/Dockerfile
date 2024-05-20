FROM rocker/verse:4.4.0

MAINTAINER Dave Tang <me@davetang.org>

ARG SEURATVER=5.1.0

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
      cmake \
      libssl-dev \
      libclang-dev \
      libxml2-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      libfftw3-dev \
      libtiff-dev \
      libgsl-dev \
      libfontconfig1-dev \
      libharfbuzz-dev \
      libfribidi-dev \
      libproj-dev \
      libboost-all-dev \
      libmagick++-dev \
      libv8-dev \
      libudunits2-dev \
      libgdal-dev \
      libmpfr-dev \
      glpk-utils \
      libglpk-dev \
      libicu-dev \
      libhdf5-dev \
      patch \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN R -q -e 'install.packages(c("BiocManager", "remotes", "optparse"))'
RUN R -q -e 'remotes::install_version("SeuratObject", version = "5.0.2", repos = "https://cran.ism.ac.jp/", quiet = FALSE)'
RUN R -q -e "remotes::install_version('Seurat', version = '${SEURATVER}', repos = 'https://cran.ism.ac.jp/', quiet = FALSE)"
RUN R -q -e 'library(Seurat)'
