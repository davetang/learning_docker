FROM ubuntu:24.04

# OCI standard image labels (org.opencontainers.image.*); registry-agnostic
# metadata readable via `docker inspect`. Replaces the deprecated LABEL maintainer.
LABEL org.opencontainers.image.authors="Dave Tang <me@davetang.org>" \
      org.opencontainers.image.source="https://github.com/davetang/learning_docker/blob/main/ubuntu/Dockerfile" \
      org.opencontainers.image.description="Ubuntu base image with common build tools/libraries and Miniforge" \
      org.opencontainers.image.title="build" \
      org.opencontainers.image.base.name="ubuntu:24.04"

# Build-time only; not persisted as ENV so containers stay interactive-friendly.
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y --no-install-recommends \
      autoconf \
      build-essential \
      default-jre \
      gettext \
      git \
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
   && apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV CONDA_DIR=/opt/conda
# Pin for reproducible builds; bump deliberately.
ARG MINIFORGE_VERSION=26.3.2-3
ARG TARGETARCH
RUN case "${TARGETARCH}" in \
        amd64)  arch=x86_64  ;; \
        arm64)  arch=aarch64 ;; \
        *) echo "unsupported arch: ${TARGETARCH}" >&2; exit 1 ;; \
    esac && \
    wget --quiet "https://github.com/conda-forge/miniforge/releases/download/${MINIFORGE_VERSION}/Miniforge3-Linux-${arch}.sh" -O /tmp/miniforge.sh && \
    bash /tmp/miniforge.sh -b -p $CONDA_DIR && \
    rm /tmp/miniforge.sh && \
    $CONDA_DIR/bin/conda clean -afy

# Put conda in PATH for all users (including root)
ENV PATH=$CONDA_DIR/bin:$PATH

WORKDIR /work
