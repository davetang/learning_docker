## Ubuntu

![Build Dockerfile](https://github.com/davetang/learning_docker/actions/workflows/build_ubuntu.yml/badge.svg)

An Ubuntu 24.04 base image with many of the tools and libraries needed for
building bioinformatics and other software from source (compilers, `autoconf`,
`cmake`, `pkg-config`, common `-dev` libraries) plus a
[Miniforge](https://github.com/conda-forge/miniforge) (conda) installation.

The image is published to Docker Hub as
[`davetang/build`](https://hub.docker.com/r/davetang/build). The tag tracks the
Ubuntu base version from the `FROM` line (currently `24.04`), and `latest`
always points at the most recent build. Images are built for both `linux/amd64`
and `linux/arm64`, so a pull resolves to your machine's architecture
automatically.

### Pulling and running

```bash
# Pin a version for reproducibility
image=davetang/build:24.04
docker pull $image

# Confirm the base OS
docker run --rm $image cat /etc/os-release

# Mount the current directory to /work (the image's WORKDIR) and get a shell.
# -u matches the container user to the host user so new files aren't owned by root.
docker run --rm -it \
           -v $(pwd):/work \
           -u $(stat -c "%u:%g" $HOME) \
           $image bash
```

Miniforge is installed under `/opt/conda` and is on the `PATH`, so `conda` and
`mamba` are available:

```bash
docker run --rm $image conda --version
```

### Building locally

```bash
cd ubuntu && ./build.sh
```

`build.sh` derives the tag from the `FROM` line (so it stays in sync with CI)
and tags both `davetang/build:<version>` and `davetang/build:latest`. It prints
the `docker push` commands to run if you want to publish the image.

To build for a specific architecture on a multi-arch capable host:

```bash
docker buildx build --platform linux/amd64 -t davetang/build:24.04 ubuntu
```

The Miniforge version is pinned via the `MINIFORGE_VERSION` build argument and
can be overridden at build time:

```bash
docker build --build-arg MINIFORGE_VERSION=26.3.2-3 -t davetang/build:24.04 ubuntu
```

### Continuous integration

The [`build_ubuntu.yml`](../.github/workflows/build_ubuntu.yml) workflow builds
the multi-architecture image and pushes it to Docker Hub whenever
`ubuntu/Dockerfile` changes on `main` (or when triggered manually). The `arm64`
image is built under QEMU emulation, so CI runs take longer than a native build.
