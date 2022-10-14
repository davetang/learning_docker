## README

Run [VS Code](https://github.com/Microsoft/vscode) on any machine anywhere and
access it through the browser using
[Docker](https://hub.docker.com/r/codercom/code-server).

```bash
#!/usr/bin/env bash

set -euo pipefail

version=4.7.1
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
```

Visit `localhost:8883` and check the config file at
`${HOME}/.config/code-server/config.yaml` for the password.

```bash
cat ${HOME}/.config/code-server/config.yaml | grep ^password | awk '{print $2}'
```

