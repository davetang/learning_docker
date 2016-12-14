## README

One can simply use `apt-get install -y r-base` if you don't require an R version later than `R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"`. The `ubuntu` version is Precise Pangolin (12.04) and [as noted](https://cran.r-project.org/bin/linux/ubuntu/): "R 3.3.0 and above is not supported for Precise Pangolin (12.04; LTS), but previous builds will remain here until end of life for 12.04." The `ontologyIndex` package required R (≥ 3.1.0), hence this Dockerfile that installs a lot of libraries required to compile R. The Docker image created from this Dockerfile was 1.334 GB.

Build:

~~~~{.bash}
docker build -t r .
~~~~

Run:

~~~~{.bash}
docker run r
R version 3.3.2 (2016-10-31) -- "Sincere Pumpkin Patch"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
http://www.gnu.org/licenses/.

docker run r R --quiet -e 'set.seed(31); sample(1:10, 5)'
> set.seed(31); sample(1:10, 5)
[1]  6  9  4  3 10
> 
> 
~~~~

