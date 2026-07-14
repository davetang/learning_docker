#!/usr/bin/env bash

set -euo pipefail

image=build
# Tag tracks the Ubuntu base version from the FROM line (e.g. 24.04),
# matching the repo convention and the CI/CD workflow.
ver=$(grep "^FROM" Dockerfile | cut -f2 -d':')

docker build -t davetang/${image}:${ver} -t davetang/${image}:latest .

>&2 echo Build complete
>&2 echo -e "Run the following to push to Docker Hub:\n"
>&2 echo docker login
>&2 echo docker push davetang/${image}:${ver}
>&2 echo docker push davetang/${image}:latest

exit 0

