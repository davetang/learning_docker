#!/usr/bin/env bash

set -euo pipefail

VER=$(cat Dockerfile | grep "^FROM" | cut -f2 -d':')
IMG=r_tensorflow

docker build -t davetang/${IMG}:${VER} .

>&2 echo Build complete
>&2 echo -e "Run the following to push to Docker Hub:\n"
>&2 echo docker login
>&2 echo docker push davetang/${IMG}:${VER}
