From ubuntu:16.04
MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get update
RUN apt-get install -y wget liblzma-dev build-essential zlib1g-dev libbz2-dev libncurses5-dev
RUN mkdir /src && cd /src && wget https://github.com/samtools/htslib/releases/download/1.5/htslib-1.5.tar.bz2 && tar -xjf htslib-1.5.tar.bz2 && cd htslib-1.5 && ./configure && make && make install
RUN cd /src && wget https://github.com/samtools/bcftools/releases/download/1.5/bcftools-1.5.tar.bz2 && tar -xjf bcftools-1.5.tar.bz2 && cd bcftools-1.5 && ./configure && make && make install
RUN cd /src && wget https://github.com/samtools/samtools/releases/download/1.5/samtools-1.5.tar.bz2 && tar -xjf samtools-1.5.tar.bz2 && cd samtools-1.5 && ./configure && make && make install

CMD samtools

