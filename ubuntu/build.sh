#!/usr/bin/env bash

set -euo pipefail

image=build
ver=1.2.5

docker build -t davetang/${image}:${ver} .

>&2 echo Build complete
>&2 echo -e "Run the following to push to Docker Hub:\n"
>&2 echo docker login
>&2 echo docker push davetang/${image}:${ver}

exit 0

