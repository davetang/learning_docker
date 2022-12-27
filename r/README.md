## README

![Build Dockerfile](https://github.com/davetang/learning_docker/actions/workflows/build_r.yml/badge.svg)

[The Rocker Project](https://rocker-project.org/) contains Docker containers
for the R environment, which are available on [Docker
  Hub](https://hub.docker.com/u/rocker). Use
[rocker/r-ver](https://hub.docker.com/r/rocker/r-ver) for reproducible builds
to fixed version of R.

```bash
docker run --rm -it rocker/r-ver:4.2.2 /bin/bash
```

`r-ver:4.2.2` uses Ubuntu:22.04.

```bash
cat /etc/os-release
# PRETTY_NAME="Ubuntu 22.04.1 LTS"
# NAME="Ubuntu"
# VERSION_ID="22.04"
# VERSION="22.04.1 LTS (Jammy Jellyfish)"
# VERSION_CODENAME=jammy
# ID=ubuntu
# ID_LIKE=debian
# HOME_URL="https://www.ubuntu.com/"
# SUPPORT_URL="https://help.ubuntu.com/"
# BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
# PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
# UBUNTU_CODENAME=jammy
```

The installed version of R (4.2.2) matches the Docker tag.

```bash
R --version
# R version 4.2.2 (2022-10-31) -- "Innocent and Trusting"
# Copyright (C) 2022 The R Foundation for Statistical Computing
# Platform: x86_64-pc-linux-gnu (64-bit)
# 
# R is free software and comes with ABSOLUTELY NO WARRANTY.
# You are welcome to redistribute it under the terms of the
# GNU General Public License versions 2 or 3.
# For more information about these matters see
# https://www.gnu.org/licenses/.
```
