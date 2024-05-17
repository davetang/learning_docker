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

    /home/rstudio/.rstudio/monitored/user-settings/user-settings

In newer versions of RStudio Server, the settings are now saved in `rstudio-prefs.json` located in:

    /home/rstudio/.config/rstudio

Once you have made all your settings, save this file back to your local computer and use it to rewrite the default file next time you start a new instance. For example:

```
# once you have the container running in the background, log into Docker container
# I have mounted this directory to /data
cp /data/user-settings /home/rstudio/.rstudio/monitored/user-settings/user-settings

# for newer version of RStudio Server
cp /data/rstudio-prefs.json /home/rstudio/.config/rstudio
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

## Configuration files

[Managing R with .Rprofile, .Renviron, Rprofile.site, Renviron.site, rsession.conf, and repos.conf](https://support.posit.co/hc/en-us/articles/360047157094-Managing-R-with-Rprofile-Renviron-Rprofile-site-Renviron-site-rsession-conf-and-repos-conf).

Upon startup, R and RStudio IDE look for a few different files you can use to control the behaviour of your R session, for example by setting options or environment variables. Below is a summary of how to control R options and environment variables on startup.

* `.Rprofile` - sourced as R code.
* `.Renviron`	- set environment variables only.
* `Rprofile.site`	- sourced as R code.
* `Renviron.site` -	set environment variables only.
* `rsession.conf`	- only RStudio IDE settings, only single repository.
* `repos.conf` - only for setting repositories.

### .Rprofile

`.Rprofile` files are user-controllable files to set options and environment variables. `.Rprofile` files can be either at the user or project level. User level `.Rprofile` files live in the base of the user's home directory, and project level `.Rprofile` files live in the base of the project directory.

R will source only one `.Rprofile` file. So if you have both a project specific `.Rprofile` file and a user `.Rprofile` file that you want to use, you explicitly source the user level `.Rprofile` at the top of your project level `.Rprofile` with `source("~/.Rprofile")`.

`.Rprofile` files are sourced as regular R code, so setting environment variables must be done inside a `Sys.setenv(key = "value")` call.

One easy way to edit your `.Rprofile` file is to use the `usethis::edit_r_profile()` function from within an R session. You can specify whether you want to edit the user or project level `.Rprofile`.

### .Renviron

`.Renviron` is a user controllable file that can be used to create environment variables. This is especially useful to avoid including credentials like API keys inside R scripts. This file is written in a key-value format, so environment variables are created in the format:

```
Key1=value1
Key2=value2
```

And then `Sys.getenv("Key1")` will return "value1" in an R session.

Like with `.Rprofile`, `.Renviron` files can be at either the user or project level. If there is a project level `.Renviron`, the user level file **will not be sourced**. The {usethis} package includes a helper function for editing `.Renviron` files from an R session with `usethis::edit_r_environ()`.

### Rprofile.site and Renviron.site

Both `.Rprofile` and `.Renviron` files have equivalents that apply server wide. `Rprofile.site` and `Renviron.site` (no leading dot) files are managed by RStudio Server admins, and are specific to a particular version of R. The most common settings for these files involve access to package repositories. For example, using the shared-baseline package management strategy is generally done from an `Rprofile.site`.

Users can override settings in these files with their individual `.Rprofile` files.

These files are set for each version of R and should be located in `R_HOME/etc/`. You can find `R_HOME` by running the command `R.home(component = "home")` in a session of that version of R. So, for example, if you find that `R_HOME` is `/opt/R/3.6.2/lib/R`, the `Rprofile.site` for R 3.6.2 would go in `/opt/R/3.6.2/lib/R/etc/Rprofile.site`.

### rsession.conf and repos.conf

RStudio Server allows server admins to configure particular server-wide R package repositories via the `rsession.conf` and `repos.conf` files. Only one repository can be configured in `rsession.conf`. If multiple repositories are needed, `repos.conf` should be used.
