FROM python:3

MAINTAINER Dave Tang <me@davetang.org>

LABEL source="https://github.com/davetang/learning_docker/mkdocs"

RUN python -m pip install --upgrade pip && pip install mkdocs

RUN rm -rf /tmp/*

WORKDIR /work

CMD ["mkdocs", "--version"]

