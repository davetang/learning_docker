#!/usr/bin/env sh

whoami

if [[ -z ${MY_EXPORT} ]]; then
   echo \$MY_EXPORT is not defined
else
   echo MY_EXPORT is ${MY_EXPORT}
fi
