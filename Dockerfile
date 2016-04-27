From ubuntu
MAINTAINER Dave Tang <dave.tang@telethonkids.org.au>
RUN apt-get update
RUN apt-get install -y git build-essential zlib1g-dev

RUN mkdir /src
RUN cd /src && git clone https://github.com/lh3/bwa.git && cd bwa && make && ln -s /src/bwa/bwa /usr/bin/bwa

# shell form of CMD
CMD bwa
