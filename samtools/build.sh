#!/usr/bin/env bash

set -euo pipefail

image=samtools
script_dir=$(realpath $(dirname $0))
ver=$(cat ${script_dir}/Dockerfile | grep "ARG samtools_ver=" | cut -f2 -d'=')

docker build -t davetang/${image}:${ver} .

>&2 echo Build complete
>&2 echo -e "Run the following to push to Docker Hub:\n"
>&2 echo docker login
>&2 echo docker push davetang/${image}:${ver}
