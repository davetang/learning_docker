# syntax=docker/dockerfile:1

# Build
FROM davetang/build:23.04 as build
ARG samtools_ver=1.17
RUN cd /tmp && \
   wget https://github.com/samtools/samtools/releases/download/${samtools_ver}/samtools-${samtools_ver}.tar.bz2 && \
   tar xjf samtools-${samtools_ver}.tar.bz2 && \
   cd samtools-${samtools_ver} && \
   make

# Install
# unable to use samtools_ver below
FROM ubuntu:23.04 as install
COPY --from=build /lib/x86_64-linux-gnu /lib/x86_64-linux-gnu
WORKDIR /root/src
COPY --from=build /tmp/samtools-1.17 ./
RUN apt-get clean all && \
   apt-get update && \
   apt-get install -y \
      make \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
   make install && \
   cd /root/ && rm -rf src/*

ENTRYPOINT ["samtools"]
