#!/usr/bin/env bash

set -euo pipefail

script_dir=$(realpath $(dirname $0))
ver=$(cat ${script_dir}/Dockerfile | grep "ARG samtools_ver=" | cut -f2 -d'=')

if [[ ! -e ${script_dir}/ERR188273_chrX.bam ]]; then
   wget https://github.com/davetang/learning_bam_file/raw/main/eg/ERR188273_chrX.bam
fi
docker run --rm -v $(pwd):/data davetang/samtools:${ver} flagstat /data/ERR188273_chrX.bam

if [[ $? == 0 ]]; then
   >&2 echo Done
   exit 0
else
   >&2 echo docker run error
   exit 1
fi
