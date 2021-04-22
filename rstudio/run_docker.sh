#!/usr/bin/env bash

set -euo pipefail

if [[ ! -x $(command -v docker) ]]; then
   >&2 echo Could not find docker
   exit 1
fi

usage() {
   >&2 echo "Usage: $0 [ -v image version ] < dirs >"
   exit 1
}

while getopts ":v:" options; do
   case "${options}" in
      v)
         ver=${OPTARG}
         ;;
      :)
         echo "Error: -${OPTARG} requires an argument."
         exit 1
         ;;
      *)
      usage ;;
   esac
done

if [[ ${OPTIND} -lt 3 ]]; then
   usage
fi

rstudio_image=davetang/rstudio:${ver}
check_image=$(docker image inspect ${rstudio_image})
container_name=rstudio_dtang
port=9999

to_mount=
if [[ $#-2 -gt 0 ]]; then
   for ((i=0; i<$#-2; i++)); do
      d=${@:$OPTIND+$i:1}
      full_d=$(readlink -f ${d})
      if [[ ! -d ${full_d} ]]; then
         >&2 echo Directory ${full_d} does not exist
         exit 1
      fi
      base_d=$(basename ${d})
      to_mount+="-v ${full_d}:/data/${base_d} "
      >&2 echo ${full_d} will be mounted to /data/${base_d}
   done
fi

r_package_dir=${HOME}/r_${ver}_packages
if [[ ! -d ${r_package_dir} ]]; then
   >&2 echo Creating ${r_package_dir}
   mkdir ${r_package_dir}
fi

>&2 echo $container_name listening on port $port

docker run --rm \
           -p $port:8787 \
           -d \
           --name $container_name \
           -v ${r_package_dir}:/packages \
	   ${to_mount} \
           -e PASSWORD=password \
           -e USERID=$(id -u) \
           -e GROUPID=$(id -g) \
           $rstudio_image

>&2 echo To stop container run: docker stop ${container_name}
>&2 echo Done

