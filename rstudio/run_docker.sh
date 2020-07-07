#!/bin/bash

rstudio_image=davetang/rstudio:4.0.1 

docker run --rm \
           -p 8888:8787 \
           -v ~/github/learning_docker/rstudio/packages:/packages \
           -v ~/github/learning_docker/rstudio/notebooks:/notebooks \
           -v ~/github/learning_docker/rstudio:/data \
           -e PASSWORD=password \
           $rstudio_image

