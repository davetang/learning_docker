FROM rocker/rstudio:4.5.2

LABEL maintainer="Dave Tang <me@davetang.org>" \
      source="https://github.com/davetang/learning_docker/blob/main/rstudio/Dockerfile" \
      description="Rocker-based RStudio Server with common libraries and R packages"

ARG bioc_ver=3.22

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y --no-install-recommends \
      git \
      cmake \
      libhdf5-dev \
      libcurl4-openssl-dev \
      libssl-dev \
      libxml2-dev \
      libpng-dev \
      libxt-dev \
      zlib1g-dev \
      libbz2-dev \
      liblzma-dev \
      libglpk40 \
      libgit2-dev \
      libgsl-dev \
      patch \
      libmagick++-dev \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN Rscript -e "install.packages(c('rmarkdown','tidyverse','tidymodels','workflowr','BiocManager','quarto','crew','targets','renv'))" \
    -e "BiocManager::install(version = '${bioc_ver}')"

# the rstudio/ path is set for building with GitHub Actions
COPY --chown=rstudio:rstudio rstudio/rstudio-prefs.json /home/rstudio/.config/rstudio
COPY --chown=rstudio:rstudio rstudio/.Rprofile /home/rstudio/

WORKDIR /home/rstudio
