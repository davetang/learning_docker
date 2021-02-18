#!/bin/bash

ver=$(cat .version)

docker build -t davetang/faster:${ver} .

# docker login
# docker push davetang/faster:${ver}

