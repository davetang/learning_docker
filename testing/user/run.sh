#!/usr/bin/env bash

set -euo pipefail

image=usertest
ver=22.10

docker build -t davetang/${image}:${ver} .

# docker run --rm davetang/${image}:${ver}
# docker rmi davetang/${image}:${ver} > /dev/null 2> /dev/null

exit 0
