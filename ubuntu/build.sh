#!/usr/bin/env bash

set -euo pipefail

ver=1.0

docker build -t davetang/build:${ver} .

# docker login
# docker push davetang/build:${ver}

