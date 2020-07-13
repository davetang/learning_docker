## README

Run [Firefox](https://hub.docker.com/r/jlesage/firefox) in a Docker container. Why? Easier to port forward than X11 forwarding through several hosts.

```bash
docker pull jlesage/firefox
```

Run Docker; add more [environment variables](https://github.com/jlesage/docker-firefox#environment-variables) as you see fit.

```bash
image=jlesage/firefox
width=1920
height=1200

docker run -d \
           --rm \
           --name=firefox \
           -p 5800:5800 \
           --shm-size 8g \
           -e DISPLAY_WIDTH=$width \
           -e DISPLAY_HEIGHT=$height \
           $image
```

Now head to http://localhost:5800/ and that's it!

When you're done, stop the container.

```bash
docker stop firefox
```

