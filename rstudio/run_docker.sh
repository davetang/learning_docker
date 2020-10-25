#!/bin/bash

ver=$(cat Dockerfile | grep "^FROM" | cut -f2 -d':')

rstudio_image=davetang/rstudio:${ver}

docker run --rm \
           -p 8888:8787 \
           -v ~/github/learning_docker/rstudio/packages:/packages \
           -v ~/github/learning_docker/rstudio/notebooks:/notebooks \
           -v ~/github/learning_docker/rstudio:/data \
           -e PASSWORD=password \
           $rstudio_image

