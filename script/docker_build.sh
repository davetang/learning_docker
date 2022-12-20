#!/usr/bin/env bash

set -euo pipefail

usage(){
   echo "Usage: $0 Dockerfile image_name [ver]"
   exit 1
}
[[ $# -lt 2 ]] && usage

infile=$1
iname=$2

if [[ $# -eq 3 ]]; then
   ver=$3
else
   ver=$(cat ${infile} | grep "^FROM" | cut -f2 -d':' || true)
   if [[ -z ${ver} ]]; then
      >&2 echo Could not get version from ${infile}
      >&2 echo Please re-run script with the version number
      exit 1
   fi
fi

docker build -t ${iname}:${ver} ${infile}

>&2 cat <<EOF

Optional steps:

docker login
docker push ${iname}:${ver}

Finished
EOF
