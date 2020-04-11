FROM ubuntu:18.04

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		build-essential \
		git \
		zlib1g-dev \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /src && \
	cd /src && \
	git clone https://github.com/lh3/bwa.git && \
	cd bwa && \
	make && \
	ln -s /src/bwa/bwa /usr/bin/bwa

# shell form of CMD
CMD bwa

