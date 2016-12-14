From ubuntu
MAINTAINER Dave Tang <me@davetang.org>
RUN apt-get update
RUN apt-get install -y git build-essential zlib1g-dev

RUN mkdir /src
RUN cd /src && git clone https://github.com/atks/vt.git && cd vt && make && ln -s /src/vt/vt /usr/local/bin

CMD vt

