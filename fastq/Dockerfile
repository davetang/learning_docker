FROM davetang/build:1.1

MAINTAINER Dave Tang <me@davetang.org>

LABEL source="https://github.com/davetang/learning_docker/fastq"

RUN wget https://github.com/angelovangel/faster/releases/download/v0.1.4/x86_64_linux_faster -O /usr/local/bin/faster && chmod 755 /usr/local/bin/faster

RUN fq_ver=0.8.0 && cd /tmp && \
  wget https://github.com/stjude-rust-labs/fq/releases/download/v${fq_ver}/fq-${fq_ver}-x86_64-unknown-linux-gnu.tar.gz && \
  tar xzf fq-${fq_ver}-x86_64-unknown-linux-gnu.tar.gz && \
  mv fq-${fq_ver}-x86_64-unknown-linux-gnu/fq /usr/local/bin

RUN seqkit_ver=2.1.0 && cd /tmp && \
  wget https://github.com/shenwei356/seqkit/releases/download/v${seqkit_ver}/seqkit_linux_amd64.tar.gz && \
  tar xzf seqkit_linux_amd64.tar.gz && \
  mv seqkit /usr/local/bin

RUN rm -rf /tmp/*

CMD seqkit

