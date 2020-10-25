#!/bin/bash

ver=$(cat Dockerfile | grep "^FROM" | cut -f2 -d':')

docker build -t davetang/rstudio:${ver} .

# docker login
# docker push davetang/rstudio:${ver}

