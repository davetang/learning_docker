#!/usr/bin/env bash

set -euo pipefail

image=shiny
ver=$(cat Dockerfile | grep "^FROM" | cut -f2 -d':')

docker build -t davetang/${image}:${ver} .
>&2 echo Done
exit 0

# docker login
# docker push davetang/${image}:${ver}

