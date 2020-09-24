#!/usr/bin/env bash

image=dceoy/igv-webapp

docker run --rm \
           --name=igv-webapp \
           -d \
           -p 8080:8080 \
           $image

