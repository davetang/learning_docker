FROM ubuntu:22.10

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      openssh-client \
      wget && \
    apt-get clean all && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN useradd --create-home --shell /bin/bash parasite && \
    echo 'parasite:password' | chpasswd

ARG aspera_ver=4.2.5.306
RUN su - parasite -c "cd /tmp && \
    wget https://d3gcli72yxqn2z.cloudfront.net/downloads/connect/latest/bin/ibm-aspera-connect_${aspera_ver}_linux.tar.gz && \
    tar -xzf ibm-aspera-connect_${aspera_ver}_linux.tar.gz && \
    ./ibm-aspera-connect_${aspera_ver}_linux.sh && \
    rm /tmp/ibm-aspera*"

ARG home=/home/parasite
# manually copy files as they are missing from 4.2.5.306
COPY --chown=parasite:parasite asperaweb_id_dsa.openssh ${home}
COPY --chown=parasite:parasite asperaweb_id_dsa.openssh.pub ${home}

RUN echo "export PATH=$PATH:${home}/.aspera/connect/bin/" >> ${home}/.bashrc
