#!/usr/bin/env bash

ver=$(cat Dockerfile | grep "^FROM" | cut -f2 -d':')

rstudio_image=davetang/rstudio:${ver}
container_name=rstudio_dtang
port=9999

>&2 echo $container_name listening on port $port

docker run --rm \
           -p $port:8787 \
           -d \
           --name $container_name \
           -v ~/packages:/packages \
           -v ~/github/learning_docker/rstudio:/data \
           -e PASSWORD=password \
           -e USERID=$(id -u) \
           -e GROUPID=$(id -g) \
           $rstudio_image

