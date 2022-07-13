## README

Automatically build and push Docker images using [Build and push Docker images](https://github.com/marketplace/actions/build-and-push-docker-images). The following works and the image is pushed to [Docker Hub](https://hub.docker.com/repository/docker/davetang/from_github).

In order to automatically set a version for your Docker image use [metadata-action](https://github.com/docker/metadata-action) but you will need use [Git tags](https://git-scm.com/book/en/v2/Git-Basics-Tagging). The idea is that tagged Git commit is associated with the Docker image version. This works fine if the GitHub repository contains only one Docker image to build but not this repository, which has multiple Dockerfiles and images to build.

```
name: Build and push test

on:
  workflow_dispatch:
  push:
    paths:
      - 'github_actions/Dockerfile'
      - '.github/workflows/build_and_push.yml'

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      -
        name: Checkout
        uses: actions/checkout@v3
      -
        name: Docker meta
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: davetang/from_github
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
          tags: ${{ steps.meta.outputs.tags }}
```

