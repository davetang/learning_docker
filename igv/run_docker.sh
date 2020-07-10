#!/usr/bin/env bash

image=dceoy/igv-webapp

docker run --rm \
           -p 8080:8080 \
           $image

