#!/usr/bin/env bash

set -euo pipefail

image=user
ver=22.10

docker build -f Dockerfile_user -t davetang/${image}:${ver} .
docker run --rm -u 1004:1006 davetang/${image}:${ver} env | grep PATH
docker rmi davetang/${image}:${ver} > /dev/null 2> /dev/null

exit 0
