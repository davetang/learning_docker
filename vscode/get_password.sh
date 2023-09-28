#!/usr/bin/env bash

config=${HOME}/.config/code-server/config.yaml

if [[ -f ${config} ]]; then
   cat ${HOME}/.config/code-server/config.yaml | grep ^password | awk '{print $2}'
   exit 0
else
   >&2 echo ${config} not found
   exit 1
fi
