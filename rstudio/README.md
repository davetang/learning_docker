## Running RStudio Server from Docker

The [Rocker project](https://www.rocker-project.org/) provides various Docker images for the R environment. Here's one way of using the [RStudio Server image](https://hub.docker.com/r/rocker/rstudio/) to enable reproducibility.

First use `docker` to pull version `3.6.1` of the RStudio Server image; remember to specify the version so we can reproducible analyses.

```bash
docker pull rocker/rstudio:3.6.1
```

Once you have successfully pulled the image, try running the command below. The output indicates that the image is using the Debian operating system.

```bash
docker run --rm -it rocker/rstudio:3.6.1 cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
NAME="Debian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```

For this example, I have created a `packages` directory for installing R packages into. We will use the `-v` parameter to share the `packages` directory; this directory will be accessible inside the container as `/packages`.

```bash
docker run --rm \
           -p 8888:8787 \
           -v /Users/dtang/github/learning_docker/rstudio/packages:/packages \
           -e PASSWORD=password \
           rocker/rstudio
```

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
           -e PASSWORD=password \
           rocker/rstudio
```

