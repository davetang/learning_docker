#!/usr/bin/env bash

set -euo pipefail

version=4.3.0
me=$(whoami)
tool=shiny
image=davetang/${tool}:${version}
container_name=${tool}_${me}
port=3838
shinyapp=$(pwd)/test_app
# shinyapp=$(pwd)/deseq2_app
shinylog=$(pwd)/shinylog

if [[ ! -d ${shinylog} ]]; then
   mkdir ${shinylog}
fi

docker run -d \
   -p ${port}:3838 \
   --restart always \
   --name ${container_name} \
   -v ${shinyapp}:/srv/shiny-server/ \
   -v ${shinylog}:/var/log/shiny-server/ \
   ${image}

>&2 echo ${container_name} listening on port ${port}
>&2 echo To stop and remove the container run:
>&2 echo "docker stop ${container_name} && docker rm ${container_name}"

exit 0
