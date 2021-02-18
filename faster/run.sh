#!/bin/bash

set -euo pipefail

ver=$(cat .version)

docker run --rm -it -v $(pwd):/data/ davetang/faster:${ver} /bin/bash

