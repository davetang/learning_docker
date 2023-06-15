#!/usr/bin/env bash

set -euo pipefail

image=hugo
ver=$(cat Dockerfile | grep "^ARG hugo_ver" | cut -f2 -d'=')

docker build -t davetang/${image}:${ver} .

>&2 echo Build complete
>&2 echo -e "Run the following to push to Docker Hub:\n"
>&2 echo docker login
>&2 echo docker push davetang/${image}:${ver}

exit 0
