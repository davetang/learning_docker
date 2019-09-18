FROM rocker/rstudio:3.6.1

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
		zlib1g-dev \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages('rmarkdown'); install.packages('tidyverse');"

COPY user-settings /home/rstudio/.rstudio/monitored/user-settings/user-settings
COPY .Rprofile /home/rstudio/

