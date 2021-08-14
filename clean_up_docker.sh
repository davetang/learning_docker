#!/usr/bin/env bash

set -euo pipefail

exited=`docker ps -a -q -f status=exited`

if [[ ! -z ${exited} ]]; then
   docker rm -v $(docker ps -a -q -f status=exited)
fi

exit 0

