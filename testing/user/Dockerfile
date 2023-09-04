FROM ubuntu:22.10

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      wget \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG user=voltaire
RUN useradd --create-home --shell /bin/bash ${user} && \
    echo "${user}:freedom" | chpasswd

RUN wget --quiet -O /usr/local/bin/gosu https://github.com/tianon/gosu/releases/download/1.16/gosu-amd64 && \
   chmod 755 /usr/local/bin/gosu

USER ${user}

# COPY does not run as ${user}; need to use --chown
COPY ./test.txt /
RUN id && ls -al /test.txt

USER root
ENTRYPOINT ["gosu"]
