#!/usr/bin/env bash

set -euo pipefail

if [[ ! -x $(command -v docker) ]]; then
   >&2 echo Could not find docker
   exit 1
fi

ver=0.0.1
docker_image=davetang/mkdocs:${ver}
check_image=$(docker image inspect ${docker_image})
container_name=mkdocs_dtang
dir=$(pwd)/test
port=5555

if [[ ! -e ${dir} ]]; then
   >&2 echo ${dir} does not exist
   exit 1
fi

docker run --rm \
   -d \
   -p ${port}:8000 \
   --name $container_name \
   -v ${dir}:/work \
   $docker_image \
   mkdocs serve

>&2 echo $container_name listening on port $port
>&2 echo Copy and paste http://localhost:$port into your browser
>&2 echo To stop container run: docker stop ${container_name}
>&2 echo Done

exit 0

