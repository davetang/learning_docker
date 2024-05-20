#!/usr/bin/env bash

set -euo pipefail

SEURATVER=$(cat Dockerfile| grep SEURATVER= | cut -f2 -d'=')

docker build -t davetang/seurat:${SEURATVER} .

cat <<EOF
Push to Docker Hub

docker login
docker push davetang/seurat:${SEURATVER}

EOF
