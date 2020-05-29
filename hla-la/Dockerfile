FROM ubuntu:18.04

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      autotools-dev \
      build-essential \
      cmake \
      g++ \
      git \
      libbz2-dev \
      libboost-all-dev \
      libcurl4-gnutls-dev \
      libhdf5-dev \
      libicu-dev \
      libjsoncpp-dev \
      libpng-dev \
      libssl-dev \
      libxml2-dev \
      openjdk-8-jre \
      python-dev \
      tree \
      unzip \
      vim \
      wget \
      zlib1g-dev \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Boost
RUN cd /tmp && \
	wget https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.gz/download -O boost_1_72_0.tar.gz && \
	tar -xzf boost_1_72_0.tar.gz && cd boost_1_72_0 && \
	./bootstrap.sh --prefix=/usr/ && \
	./b2 && ./b2 install

# BamTools
RUN cd /tmp && mkdir tool && \
	git clone https://github.com/pezmaster31/bamtools && \
	cd bamtools && mkdir build && cd build && \
	cmake -DCMAKE_INSTALL_PREFIX=/tmp/tool/ -DBUILD_SHARED_LIBS=ON .. && \
	make && make install && \
	cd /tmp/tool/ && ln -s lib lib64

# Miniconda and dependencies
RUN cd /tmp/ && \
	wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
	bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3 && \
	/root/miniconda3/condabin/conda install -y -c bioconda bwa samtools picard mummer minimap2
ENV PATH=$PATH:/root/miniconda3/bin

# Picard
RUN cd /tmp/ && \
	wget https://sourceforge.net/projects/picard/files/picard-tools/1.119/picard-tools-1.119.zip/download -O picard-tools-1.119.zip && \
	unzip picard-tools-1.119.zip

# HLA-LA
RUN cd /tmp/ && \
	mkdir HLA-LA HLA-LA/bin HLA-LA/src HLA-LA/obj HLA-LA/temp HLA-LA/working HLA-LA/graphs && \
	cd HLA-LA/src && git clone https://github.com/DiltheyLab/HLA-LA.git . && \
	make all BOOST_PATH=/usr/ BAMTOOLS_PATH=/tmp/tool/
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/tmp/tool/lib64

COPY paths.ini /tmp/HLA-LA/src/

