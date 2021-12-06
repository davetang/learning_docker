#!/usr/bin/env bash

set -euo pipefail

ver=$(cat Dockerfile | grep "^FROM" | cut -f2 -d':')
image=r_build

docker build -t davetang/${image}:${ver} .

# docker login
# docker push davetang/${image}:${ver}

