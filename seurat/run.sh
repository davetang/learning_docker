#!/usr/bin/env bash

set -euo pipefail

version=5.1.0
rstudio_image=davetang/seurat:${version}
container_name=rstudio_server_seurat_${version}
port=8989

docker run \
   --name ${container_name} \
   -d \
   --rm \
   -p ${port}:8787 \
   -v ${HOME}/github/:/home/rstudio/work \
   -v ${HOME}/gitlab/:/home/rstudio/gitlab \
   -v ${HOME}/analysis/:/analysis \
   -e PASSWORD=password \
   -e USERID=$(id -u) \
   -e GROUPID=$(id -g) \
   ${rstudio_image}

>&2 echo ${container_name} listening on port ${port}
exit 0
