FROM rocker/rstudio:4.2.2

LABEL source="https://github.com/davetang/learning_docker/blob/main/rstudio/Dockerfile"

MAINTAINER Dave Tang <me@davetang.org>

ARG bioc_ver=3.16

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
		libgit2-dev \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages(c('rmarkdown', 'tidyverse', 'workflowr', 'BiocManager'));"
RUN Rscript -e "BiocManager::install(version = '${bioc_ver}')"

# the rstudio/ path is set for building with GitHub Actions
COPY rstudio/user-settings /home/rstudio/.rstudio/monitored/user-settings/user-settings
COPY rstudio/.Rprofile /home/rstudio/

WORKDIR /home/rstudio
