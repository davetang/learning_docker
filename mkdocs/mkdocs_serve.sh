#!/usr/bin/env bash

set -euo pipefail

if [[ ! -x $(command -v docker) ]]; then
   >&2 echo Could not find docker
   exit 1
fi

proj=test

if [[ ! -d ${proj} ]]; then
   >&2 echo Creating ${proj}
   docker run \
     --rm \
     -u $(stat -c "%u:%g" README.md) \
     -v $(pwd):/work \
     davetang/mkdocs:0.0.1 \
     mkdocs new ${proj}
fi

if [[ ! -d ${proj}/site ]]; then
   >&2 echo Building ${proj}
   docker run \
     --rm \
     -u $(stat -c "%u:%g" README.md) \
     -v $(pwd)/${proj}:/work \
     davetang/mkdocs:0.0.1 \
     mkdocs build
fi

ver=0.0.1
docker_image=davetang/mkdocs:${ver}
check_image=$(docker image inspect ${docker_image})
container_name=mkdocs_dtang
port=5555
dir=$(pwd)/${proj}/site

docker run --rm \
   -d \
   -p ${port}:${port} \
   --name $container_name \
   -v ${dir}:/work \
   $docker_image \
   python -m http.server ${port}

>&2 echo $container_name listening on port $port
>&2 echo Copy and paste http://localhost:$port into your browser
>&2 echo To stop container run: docker stop ${container_name}
>&2 echo Done

exit 0

