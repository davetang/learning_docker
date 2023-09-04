FROM ubuntu:22.10

ARG user=voltaire
RUN useradd --create-home --shell /bin/bash ${user} && \
    echo "${user}:freedom" | chpasswd

USER ${user}

# need to use --chown
COPY ./test.txt /
RUN id && ls -al /test.txt

ENTRYPOINT ["whoami"]
