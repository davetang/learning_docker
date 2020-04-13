#!/bin/bash

exited=`docker ps -a -q -f status=exited`

if [ ! -z "$exited" ]; then
   docker rm -v $(docker ps -a -q -f status=exited)
fi

