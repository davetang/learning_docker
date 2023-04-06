#!/usr/bin/env bash

set -euo pipefail

ver=$(cat Dockerfile | grep "^ARG aspera_ver" | cut -f2 -d'=')
if [[ -z ${ver} ]]; then
   >&2 echo Could not get version
   exit 1
fi
image=aspera_connect

docker build -t davetang/${image}:${ver} .

>&2 echo Build complete
>&2 echo -e "Run the following to push to Docker Hub:\n"
>&2 echo docker login
>&2 echo docker push davetang/${image}:${ver}
