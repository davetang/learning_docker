#!/usr/bin/env bash

set -euo pipefail

RVER=4.5.0
IMAGE=davetang/rstudio:${RVER}
NAME=rstudio_server_${RVER}
PORT=8889
LIB=${HOME}/r_packages_${RVER}

if [[ ! -d ${LIB} ]]; then
   mkdir ${LIB}
fi

docker run \
   --name ${NAME} \
   -d \
   --restart always \
   -p ${PORT}:8787 \
   -v ${LIB}:/packages \
   -v ${HOME}/github/:/home/rstudio/work \
   -v ${HOME}/gitlab/:/home/rstudio/gitlab \
   -v ${HOME}/analysis/:/analysis \
   -v ${HOME}:/data \
   -e PASSWORD=password \
   -e USERID=$(id -u) \
   -e GROUPID=$(id -g) \
   ${IMAGE}

>&2 echo ${NAME} listening on port ${PORT}

exit 0
