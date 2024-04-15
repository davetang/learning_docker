#!/usr/bin/env bash

set -euo pipefail

version=4.3.3
rstudio_image=davetang/rstudio:${version}
container_name=rstudio_server_${version}
port=8889
package_dir=${HOME}/r_packages_${version}

if [[ ! -d ${package_dir} ]]; then
   mkdir ${package_dir}
fi

docker run \
   --name ${container_name} \
   -d \
   --restart always \
   -p ${port}:8787 \
   -v ${package_dir}:/packages \
   -v ${HOME}/github/:/home/rstudio/work \
   -v ${HOME}/gitlab/:/home/rstudio/gitlab \
   -v ${HOME}/analysis/:/analysis \
   -e PASSWORD=password \
   -e USERID=$(id -u) \
   -e GROUPID=$(id -g) \
   ${rstudio_image}

>&2 echo ${container_name} listening on port ${port}

exit 0
