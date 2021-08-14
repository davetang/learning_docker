#!/usr/bin/env bash

set -euo pipefail

ver=0.7.17

docker build -t davetang/bwa:${ver} .

