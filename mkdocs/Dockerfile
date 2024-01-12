FROM python:3.10.1

MAINTAINER Dave Tang <me@davetang.org>

LABEL source="https://github.com/davetang/learning_docker/mkdocs"

COPY requirements.txt /tmp/requirements.txt

RUN python -m pip install --upgrade pip && pip install -r /tmp/requirements.txt

RUN rm -rf /tmp/*

WORKDIR /work

CMD ["mkdocs", "--version"]
