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

ARG user=parasite
RUN useradd \
    --create-home \
    --home-dir /home/${user} \
    --base-dir /home/${user} \
    --shell /bin/bash ${user} && \
    echo "${user}:password" | chpasswd && \
    usermod -d /home/${user} ${user}

# get link to tarball from https://www.ibm.com/aspera/connect/
ARG aspera_ver=4.2.6.393
ARG tarball=ibm-aspera-connect_${aspera_ver}_linux_x86_64.tar.gz
ARG script=ibm-aspera-connect_${aspera_ver}_linux_x86_64.sh

USER ${user}
RUN cd /tmp && \
    wget --quiet https://d3gcli72yxqn2z.cloudfront.net/downloads/connect/latest/bin/${tarball} && \
    tar -xzf ${tarball} && \
    ./ibm-aspera-connect_4.2.6.393_linux_x86_64.sh && \
    ./${script} && \
    rm /tmp/${tarball} /tmp/${script}

ARG home=/home/${user}
# manually copy files as they are missing from the tarball
COPY --chown=${user}:${user} asperaweb_id_dsa.openssh ${home}
COPY --chown=${user}:${user} asperaweb_id_dsa.openssh.pub ${home}

RUN echo "export PATH=$PATH:${home}/.aspera/connect/bin/" >> ${home}/.bashrc
RUN chmod -R 777 ${home}
WORKDIR ${home}
ENTRYPOINT ["/home/parasite/.aspera/connect/bin/ascp", "-P33001", "-i", "/home/parasite/asperaweb_id_dsa.openssh"]
CMD ["-QT", "-l 300m"]
