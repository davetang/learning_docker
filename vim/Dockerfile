FROM thinca/vim:v9.0.1946-full-ubuntu

MAINTAINER Dave Tang <me@davetang.org>
LABEL source="https://github.com/davetang/learning_docker/blob/main/vim/Dockerfile"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get clean all && \
   apt-get update && \
   apt-get upgrade -y && \
   apt-get install -y \
      curl \
      git-core \
   && apt-get clean all && \
   apt-get purge && \
   rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY .vimrc /root

# install Rust
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y

# https://github.com/junegunn/vim-plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# https://github.com/junegunn/vim-plug/issues/675
RUN vim +'PlugInstall --sync' +qall

# install Node.js
RUN curl -sL install-node.vercel.app/lts | bash -s -- -y

# https://github.com/fannheyward/coc-rust-analyzer
RUN vim +'CocInstall -sync coc-rust-analyzer' +qall

ARG rust_ver=2023-09-25
# no interpolation, type version manually
RUN printf '{\n  "coc-rust-analyzer|global": {\n    "release": "2023-09-25"\n  }\n}' > /root/.config/coc/memos.json

# install rust-analyzer
RUN cd /tmp && \
   curl -L -o rust-analyzer.gz https://github.com/rust-lang/rust-analyzer/releases/download/${rust_ver}/rust-analyzer-x86_64-unknown-linux-gnu.gz && \
   gunzip rust-analyzer.gz && \
   chmod 755 rust-analyzer && \
   mkdir -p /root/.config/coc/extensions/coc-rust-analyzer-data/ && \
   mv rust-analyzer /root/.config/coc/extensions/coc-rust-analyzer-data/

WORKDIR /work
ENTRYPOINT ["/bin/bash"]
