FROM ubuntu:18.04

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      wget \
      parallel \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /usr/local/bin/ && \
        wget https://github.com/angelovangel/faster/releases/download/v0.1.4/x86_64_linux_faster && \
        mv x86_64_linux_faster faster && \
        chmod 755 faster

RUN rm -rf /tmp/*

CMD faster

