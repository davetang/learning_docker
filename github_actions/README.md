## README

GitHub Actions can be used to automatically build and push Docker images to
Docker Hub using [Build and push Docker
images](https://github.com/marketplace/actions/build-and-push-docker-images)
action. This is very nice because you can automatically check whether your
Dockerfile builds and once it finishes building you can upload the image to a
repository such as Docker Hub.

The following workflow works and the image is pushed to [Docker
Hub](https://hub.docker.com/repository/docker/davetang/from_github).

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

However, in order to automatically set a version, i.e. add a tag, for your
Docker image [metadata-action](https://github.com/docker/metadata-action) needs
to be used along with [Git
tags](https://git-scm.com/book/en/v2/Git-Basics-Tagging). The idea is that the
tagged Git commit is associated with the Docker image version. Therefore, when
pushing to Github, include the tag (`git push origin tag`) or else the version
tag will not be populated correctly. This works fine if the GitHub repository
only contains one Docker image to build but not for this repository, which has
multiple Dockerfiles and images to build.

A less elegant solution was to simply run a command to get the version from a
Dockerfile. The following workflow uses the setup of the Build and push Docker
action but runs other commands to build, get the version, and push to Docker
Hub.

```
name: Build RStudio Server and push to Docker Hub

on:
  workflow_dispatch:
  push:
    branches:
      - 'main'
    paths:
      - 'rstudio/Dockerfile'
      - 'script/docker_build.sh'
      - '.github/workflows/build_rstudio.yml'

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
        run: |
          script/docker_build.sh rstudio/Dockerfile davetang/rstudio
          ver=$(cat rstudio/Dockerfile | grep "^FROM" | cut -f2 -d':')
          docker push davetang/rstudio:${ver}
```

It's a bit of a hack but it works.
