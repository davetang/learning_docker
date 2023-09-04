#!/usr/bin/env bash

set -euo pipefail

image=entrypoint
ver=3.18.3

docker build -q -t davetang/${image}:${ver} .

docker run --rm -u 1011:1023 -e MY_EXPORT=1000 davetang/${image}:${ver}

docker rmi davetang/${image}:${ver} > /dev/null 2> /dev/null

exit 0
