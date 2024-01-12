#!/usr/bin/env bash

set -euo pipefail

# set project/directory name
proj=test

ver=0.0.3
docker_image=davetang/mkdocs:${ver}
container_name=mkdocs_dtang
port=5555

dir=$(pwd)/${proj}/site
if [[ ! -x $(command -v docker) ]]; then
   >&2 echo Could not find docker
   exit 1
fi

check_image=$(docker image inspect ${docker_image})

if [[ ! -d ${proj} ]]; then
   >&2 echo Creating ${proj}
   docker run \
     --rm \
     -u $(stat -c "%u:%g" README.md) \
     -v $(pwd):/work \
     ${docker_image} \
     mkdocs new ${proj}
fi

if [[ ! -d ${proj}/site ]]; then
   >&2 echo Building ${proj}
   docker run \
     --rm \
     -u $(stat -c "%u:%g" README.md) \
     -v $(pwd)/${proj}:/work \
     ${docker_image} \
     mkdocs build
fi

docker run \
   --rm \
   -d \
   -p ${port}:${port} \
   --name ${container_name} \
   -v ${dir}:/work \
   ${docker_image} \
   python -m http.server ${port}

>&2 echo ${container_name} listening on port $port
>&2 echo Copy and paste http://localhost:$port into your browser
>&2 echo To stop container run: docker stop ${container_name}
>&2 echo Done

exit 0
