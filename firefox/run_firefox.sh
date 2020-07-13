#!/usr/bin/env bash

image=jlesage/firefox
width=3000
height=2000

docker run -d \
           --rm \
           --name=firefox \
           -p 5800:5800 \
           --shm-size 8g \
           -e DISPLAY_WIDTH=$width \
           -e DISPLAY_HEIGHT=$height \
           $image

