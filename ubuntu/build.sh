#!/usr/bin/env bash

set -euo pipefail

# use Ubuntu 20.04
ver=1.1

docker build -t davetang/build:${ver} .

# docker login
# docker push davetang/build:${ver}

