#!/usr/bin/env bash

set -euo pipefail

source .version
image=codercom/code-server:${version}
container_name=vscode_server
port=8883
config_dir=${HOME}/.config

if [[ ! -d ${config_dir} ]]; then
   mkdir ${config_dir}
fi

docker run \
   --name $container_name \
   --rm \
   -d \
   -p $port:8080 \
   -v "${config_dir}:/home/coder/.config" \
   -v ~/github/:/home/coder/project \
   -u "$(id -u):$(id -g)" \
   -e "DOCKER_USER=$USER" \
   $image

>&2 echo $container_name listening on port $port
exit 0
