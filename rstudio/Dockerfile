FROM rocker/rstudio:4.6.0

# OCI standard image labels (org.opencontainers.image.*); registry-agnostic
# metadata readable via `docker inspect`. Replaces the deprecated LABEL maintainer.
LABEL org.opencontainers.image.authors="Dave Tang <me@davetang.org>" \
      org.opencontainers.image.source="https://github.com/davetang/learning_docker/blob/main/rstudio/Dockerfile" \
      org.opencontainers.image.description="Rocker-based RStudio Server with common libraries and R packages" \
      org.opencontainers.image.title="rstudio" \
      org.opencontainers.image.base.name="rocker/rstudio:4.6.0"

ARG bioc_ver=3.23

# Install system libraries needed to build common R/Bioconductor packages.
# Note: no `apt-get upgrade` on purpose — keep the package set pinned to the
# rocker base image for reproducible builds; upgrade by bumping the base tag.
RUN apt-get update && \
   # DEBIAN_FRONTEND=noninteractive avoids interactive prompts (e.g. tzdata)
   # hanging the build; scoped to this command so it doesn't leak at runtime.
   DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
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
   # Drop the apt package lists to keep the image layer small (the base image
   # auto-cleans the download cache via /etc/apt/apt.conf.d/docker-clean).
   && rm -rf /var/lib/apt/lists/*

RUN Rscript -e "install.packages(c('rmarkdown','tidyverse','tidymodels','workflowr','BiocManager','quarto','crew','targets','renv'))" \
    -e "BiocManager::install(version = '${bioc_ver}')"

# the rstudio/ path is set for building with GitHub Actions
COPY --chown=rstudio:rstudio rstudio/rstudio-prefs.json /home/rstudio/.config/rstudio
COPY --chown=rstudio:rstudio rstudio/.Rprofile /home/rstudio/

WORKDIR /home/rstudio
