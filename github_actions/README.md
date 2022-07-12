## README

Automatically build and push Docker images using [Build and push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images). The following works and the image is pushed to [Docker Hub](https://hub.docker.com/repository/docker/davetang/from_github).

```
name: Build and push test

on:
  push:
    paths:
      - 'github_actions/Dockerfile'

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      -
        name: Checkout
        uses: actions/checkout@v3
      -
        name: Set up QEMU
        uses: docker/setup-qemu-action@v2
      -
        name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2
      -
        name: Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_TOKEN }}
      -
        name: Build and push
        uses: docker/build-push-action@v3
        with:
          context: github_actions
          push: true
          tags: davetang/from_github:latest
```

## TODO

- [ ] find out how to set version tag with [metadata-action](https://github.com/docker/metadata-action)
- [ ] create workflow for my `rstudio` Dockerfile
- [ ] create workflow for my `r` Dockerfile
- [ ] create workflow for my `ubuntu` Dockerfile

