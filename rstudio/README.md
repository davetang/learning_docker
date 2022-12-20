## Running RStudio Server from Docker

![Build Dockerfile](https://github.com/davetang/learning_docker/actions/workflows/build_rstudio.yml/badge.svg)

The [Rocker project](https://www.rocker-project.org/) provides various Docker images for the R environment. Here's one way of using the [RStudio Server image](https://hub.docker.com/r/rocker/rstudio/) to enable reproducibility.

First use `docker` to pull the RStudio Server image; remember to specify a version to promote reproducibility.

```bash
rstudio_image=rocker/rstudio:4.0.1
docker pull $rstudio_image
```

Once you have successfully pulled the image, try running the command below. The output indicates the operating system used to build the image.

```bash
docker run --rm -it $rstudio_image cat /etc/os-release
NAME="Ubuntu"
VERSION="20.04 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

For this example, I have created a `packages` directory for installing R packages into. We will use the `-v` parameter to share the `packages` directory; this directory will be accessible inside the container as `/packages`.

```bash
docker run --rm \
           -p 8888:8787 \
           -v ~/github/learning_docker/rstudio/packages:/packages \
           -e PASSWORD=password \
           -e USERID=$(id -u) \
           -e GROUPID=$(id -g) \
           $rstudio_image
```

NOTE: for the Docker installation on my Linux box (Docker Engine - Community 19.03.11), I had a file persmission problem when using RStudio Server. This was because the `rstudio` user does not have permission to write to the mounted directory. This was [solved](https://github.com/rocker-org/rocker/issues/324#issuecomment-454715753) by setting `USERID` and `GROUPID` to the same ID's.

If all went well, you can access the RStudio Server at http://localhost:8888/ via your favourite web browser. The username is `rstudio` and the password is `password`.

Once logged in, we need to set `.libPaths()` to `/packages`, so that we can save installed packages and don't have to re-install everything again.

```r
# check the default library paths
.libPaths()
[1] "/usr/local/lib/R/site-library" "/usr/local/lib/R/library"

# add a new library path
.libPaths(new = "/packages")

# check to see if the new library path was added
.libPaths()
[1] "/packages"                     "/usr/local/lib/R/site-library" "/usr/local/lib/R/library"

# install the pheatmap package
install.packages("pheatmap")

# load package
library(pheatmap)

# create an example heatmap
pheatmap(as.matrix(iris[, -5]))
```

![](iris.png)

The next time you run RStudio Server, you just need to add the packages directory.

```r
.libPaths(new = "/packages")
library(pheatmap)
```

You can mount other volumes too, such as a notebooks directory, so that you can save your work. However, note that if you want to create R Markdown documents you will need to install additional packages, so make sure you have added `/packages` via `.libPaths()` first before installing the additional packages.

```bash
docker run --rm \
           -p 8888:8787 \
           -v /Users/dtang/github/learning_docker/rstudio/packages:/packages \
           -v /Users/dtang/github/learning_docker/rstudio/notebooks:/notebooks \
           -v /Users/dtang/github/learning_docker/rstudio:/data \
           -e PASSWORD=password \
           $rstudio_image
```

When you're done use CONTROL+C to stop the container.

### System libraries

Some packages will require libraries that are not installed on the default Debian installation. For example, the `Seurat` package will fail to install because it will be missing the `png` library. We can "log in" to the running container and install the missing libraries. First find out the container ID by running `docker ps`.

```bash
docker ps 
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS                    NAMES
215d041c976b        rocker/rstudio      "/init"             58 minutes ago      Up 58 minutes       0.0.0.0:8888->8787/tcp   interesting_turing
```

Now we can "log in" to `215d041c976b`.

```bash
docker exec -it 215d041c976b /bin/bash

# once inside
apt update
apt install libpng-dev
```

You can create another Docker image from `rocker/rstudio` so that you don't have to do this manually each time.

### RStudio Server preferences

I have some specific preferences for RStudio Server that are absolutely necessary, such as using Vim key bindings. These preferences are set via the `Tools` menu bar and then selecting `Global Options...`. Each time we start a new container, we will lose our preferences and I don't want to manually change them each time. Luckily, the settings are saved in a specific file, which we can use to save our settings; the `user-settings` file is stored in the location below:

```
/home/rstudio/.rstudio/monitored/user-settings/user-settings
```

Once you have made all your settings, save this file back to your local computer and use it to rewrite the default file next time you start a new instance. For example:

```
# once you have the container running in the background, log into Docker container
# I have mounted this directory to /data
cp /data/user-settings /home/rstudio/.rstudio/monitored/user-settings/user-settings
```

Now you can have persistent RStudio Server preferences!

## Dockerfile

I created a new Docker image (see `Dockerfile`) from the `rstudio` image to set `.libPaths("/packages/")`, to install the `png` library, and to copy over my `user-settings` file. I can now run this image instead of the base `rstudio` image so that new packages are installed in `packages` and my user settings are preserved. In addition, I installed the `rmarkdown` and `tidyverse` packages in this new image.

## Windows

This works very nicely with Windows! Just make sure you have WSL 2, a Linux distro, and follow [this guide](https://docs.docker.com/docker-for-windows/wsl/).

```bash
wsl -l -v
# convert to WSL 2 if you were using WSL 1
wsl --set-version Ubuntu-20.04 2

./run_docker.sh
```

Now open your favourite browser and head to localhost:8888!

