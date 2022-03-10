FROM rocker/shiny:4.1.2

LABEL source="https://github.com/davetang/learning_docker/blob/master/shiny/Dockerfile"

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		libhdf5-dev \
		libcurl4-gnutls-dev \
		libssl-dev \
		libxml2-dev \
		libpng-dev \
		libxt-dev \
		zlib1g-dev \
		libbz2-dev \
		liblzma-dev \
		libglpk40 \
		libgit2-28 \
		locales \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# from https://leimao.github.io/blog/Docker-Locale/
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN Rscript -e "install.packages(c('tidyverse', 'circlize', 'shinydashboard', 'DT', 'GetoptLong', 'BiocManager'));"
RUN Rscript -e "BiocManager::install(c('airway', 'DESeq2', 'ComplexHeatmap', 'InteractiveComplexHeatmap'), version = '3.14')"

WORKDIR /home/shiny

