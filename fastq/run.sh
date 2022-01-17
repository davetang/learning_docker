#!/usr/bin/env bash

set -euo pipefail

ver=$(cat .version)

docker run --rm -it -v $(pwd):$(pwd) -w $(pwd) davetang/fastq:${ver}

