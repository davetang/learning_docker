FROM rocker/rstudio:4.0.5

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
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages(c('rmarkdown', 'tidyverse', 'workflowr', 'BiocManager'));"
RUN Rscript -e "BiocManager::install(version = '3.12')"

COPY user-settings /home/rstudio/.rstudio/monitored/user-settings/user-settings
COPY .Rprofile /home/rstudio/

