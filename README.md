Table of Contents
=================

   * [Getting started with Docker](#getting-started-with-docker)
   * [Dockerfile](#dockerfile)
      * [CMD](#cmd)
      * [ENTRYPOINT](#entrypoint)
   * [Building the image](#building-the-image)
   * [Renaming image](#renaming-image)
   * [Running the image](#running-the-image)
   * [Restrict resource usage](#resource-usage)
   * [Copying files between host and container and vice versa](#copying-files-between-host-and-container-and-vice-versa)
   * [Sharing between host and Docker container](#sharing-between-host-and-docker-container)
      * [File permissions](#file-permissions)
      * [File Permissions 2](#file-permissions-2)
   * [Removing the image](#removing-the-image)
   * [Committing a change](#committing-a-change)
   * [Access running container](#access-running-container)
   * [Cleaning up exited containers](#cleaning-up-exited-containers)
   * [Installing Perl modules](#installing-perl-modules)
   * [Creating a data container](#creating-a-data-container)
   * [R](#r)
   * [Saving and transferring a Docker image](#saving-and-transferring-a-docker-image)
   * [Tips](#tips)
      * [Useful links](#useful-links)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Getting started with Docker

Docker is an open source project that allows one to pack, ship, and run any application as a lightweight container; the use of container here refers to the consistent and standard packaging of applications. An analogy of Docker containers are shipping containers, which provide a standard and consistent way of shipping just about anything. Another concept is a Docker image; an image is software that you load into a container. A Docker image can run a simple command and exit or contain an entire workflow.

Check out this [awesome tutorial](http://seankross.com/2017/09/17/Enough-Docker-to-be-Dangerous.html) by Sean Kross and the official [getting started guide](https://docs.docker.com/linux/).

# Dockerfile

[Dockerfile documentation](https://docs.docker.com/engine/reference/builder/); also refer to [Best practices for writing Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/).

```bash
FROM ubuntu:18.04

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
        apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y \
                build-essential \
                git \
                zlib1g-dev \
        && apt-get clean all && \
        apt-get purge && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /src && \
        cd /src && \
        git clone https://github.com/lh3/bwa.git && \
        cd bwa && \
        make && \
        ln -s /src/bwa/bwa /usr/bin/bwa

# shell form of CMD
CMD bwa
```

## CMD

The [CMD](https://docs.docker.com/engine/reference/builder/#cmd) instruction in a Dockerfile does not execute anything at build time but specifies the intended command for the image; there can only be one CMD instruction in a Dockerfile and if you list more than one CMD then only the last CMD will take effect. The main purpose of a CMD is to provide defaults for an executing container.

## ENTRYPOINT

An [ENTRYPOINT](https://docs.docker.com/engine/reference/builder/#entrypoint) allows you to configure a container that will run as an executable. ENTRYPOINT has two forms:

* ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
* ENTRYPOINT command param1 param2 (shell form)

```bash
FROM ubuntu
ENTRYPOINT ["top", "-b"]
CMD ["-c"]
```

Use `--entrypoint` to override ENTRYPOINT instruction.

```bash
docker run --entrypoint
```

# Building the image

Use the `build` subcommand to build images and use the `-f` parameter if your Dockerfile is a different name. You can push the built image to [Docker Hub](https://hub.docker.com/) if you have an account.

```bash
# uses Dockerfile in current directory
docker build -t bwa .

# use -f to specify the Dockerfile to use
# the period indicates that the Dockerfile is in the current directory
docker build -f Dockerfile.base -t davetang/base .
docker login
docker push davetang/base
```

# Renaming image

Use `docker image tag`.

```bash
docker image tag old_image_name:latest new_image_name:latest
```

# Running the image

[Docker run documentation](https://docs.docker.com/engine/reference/run/).

```bash
docker run bwa

Program: bwa (alignment via Burrows-Wheeler transformation)
Version: 0.7.17-r1198-dirty
Contact: Heng Li <lh3@sanger.ac.uk>

Usage:   bwa <command> [options]

Command: index         index sequences in the FASTA format
         mem           BWA-MEM algorithm
         fastmap       identify super-maximal exact matches
         pemerge       merge overlapping paired ends (EXPERIMENTAL)
         aln           gapped/ungapped alignment
         samse         generate alignment (single ended)
         sampe         generate alignment (paired ended)
         bwasw         BWA-SW for long queries

         shm           manage indices in shared memory
         fa2pac        convert FASTA to PAC format
         pac2bwt       generate BWT from PAC
         pac2bwtgen    alternative algorithm for generating BWT
         bwtupdate     update .bwt to the new format
         bwt2sa        generate SA from BWT and Occ

Note: To use BWA, you need to first index the genome with `bwa index'.
      There are three alignment algorithms in BWA: `mem', `bwasw', and
      `aln/samse/sampe'. If you are not sure which to use, try `bwa mem'
      first. Please `man ./bwa.1' for the manual.
```

# Resource usage

To [restrict](https://docs.docker.com/config/containers/resource_constraints/) CPU usage use `--cpus=n`. We can confirm the limited usage by running some endless Perl code and using `docker stats` to confirm CPU usage.

```bash
# restrict to 1 CPU
docker run --rm --cpus=1 -it davetang/base /bin/bash
perl -le 'while(1){ }'

CONTAINER ID        NAME                   CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
78b44b67f9dc        adoring_albattani      99.88%              760KiB / 376.6GiB     0.00%               840B / 0B           0B / 0B             2

# restrict to 1/2 CPU
docker run --rm --cpus=0.5 -it davetang/base /bin/bash
perl -le 'while(1){ }'

CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
0b6d4cb36e57        tender_wilson       49.35%              756KiB / 376.6GiB     0.00%               8.53MB / 152kB      0B / 0B             2

# restrict to 1/3 CPU
docker run --rm --cpus=0.33 -it davetang/base /bin/bash
perl -le 'while(1){ }'

CONTAINER ID        NAME                   CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
a8675c0fadca        elegant_leavitt        32.71%              760KiB / 376.6GiB     0.00%               978B / 0B           0B / 0B             2
```

Use `--memory=` to restrict the maximum amount of memory the container can use.

# Copying files between host and container and vice versa

Use `docker cp`.

```bash
docker cp --help

Usage:  docker cp [OPTIONS] CONTAINER:SRC_PATH DEST_PATH|-
        docker cp [OPTIONS] SRC_PATH|- CONTAINER:DEST_PATH

Copy files/folders between a container and the local filesystem

Options:
  -L, --follow-link   Always follow symbol link in SRC_PATH
      --help          Print usage

# find container name
docker ps -a

# create file to transfer
echo hi > hi.txt

docker cp hi.txt fee424ef6bf0:/root/

# start container
docker start -ai fee424ef6bf0

# inside container
cat /root/hi.txt 
hi

# create file inside container
echo bye > /root/bye.txt
exit

# transfer file from container to host
docker cp fee424ef6bf0:/root/bye.txt .

cat bye.txt 
bye
```

# Sharing between host and Docker container

The `bwa` image does not contain any data; we can use the `-v` flag to share directories between the host and Docker container.

```bash
# the directory ~/my_data on the host will be
# in /data of the Docker container
# any output written to the /data dir will
# will be saved to ~/my_data on the host computer
docker run -it -v ~/my_data:/data bwa /bin/bash

root@4f2188458474:/# ls /
bin  boot  data  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  src  srv  sys  tmp  usr  var

root@4f2188458474:/# ls /data
l100_n100_d400_31_1.fq  l100_n100_d400_31_2.fq  ref.fa  run.sh

cd /data
# run BWA
bwa index ref.fa
bwa mem ref.fa l100_n100_d400_31_1.fq l100_n100_d400_31_2.fq > aln.sam

# check alignment
head aln.sam 
@SQ     SN:1000000      LN:1000000
@PG     ID:bwa  PN:bwa  VN:0.7.13-r1126 CL:bwa mem ref.fa l100_n100_d400_31_1.fq l100_n100_d400_31_2.fq
1:165601        99      1000000 165601  60      100M    =       166001  500     CGCGTCGTCGGCAAAGTGCAGTGGTATCGGATCAGCCTAGATGCCATAGCTGAGCGCCAAATTTCCGGATTTTCCCCGTGTAGTCAATGGAGCTGTTACT    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
1:165601        147     1000000 166001  60      100M    =       165601  -500    TCTATACGGCAGCGTAAATCCGAGACGGAATCACAGCGGGGTTCGTATCATATCAGCTCCTCATTTAACATTACATGGATAGTAACTGGGGCACTTGCGC    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
2:591852        99      1000000 591852  60      100M    =       592252  500     ATACTCCAGGGAAGCGGCAACTTACCAAAATCGTGTTTTGGGGTGTCGCATGTTCGTCGGATCAAGCTGGGCATGGGTTCGGTGACGCGTAAAAAAATTT    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
2:591852        147     1000000 592252  60      100M    =       591852  -500    ACGTCACTGAAAGTCCAGTGCGAGAGCCAACCCGGAAACTCTACATGCGCATGTAGAACAACAGCCCCATCATTTACCTACACCTCAACCAGGGCCCGGC    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
3:987593        99      1000000 987593  60      100M    =       987993  500     TGCTGCTCTGAAAAGTCCTGCGCGGCTAAATCCGTCTCACAGGCCGCCAGGTAGCCGTAGGTGGATGTGACGGATGGCTAACCTGTAGGGACCACACACT    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
3:987593        147     1000000 987993  60      100M    =       987593  -500    CGACTCGCAATTATCTCGTATCCGGGAAACTGTATAGCCGGGGGAAACTCCGATACGGACCGGCATTGGTACCAAGCGTCGAGTAGATTACCACCGACCC    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
4:301430        99      1000000 301430  60      100M    =       301830  500     TCAATTGAACTTCGACCCGGGACTAGCGGGGGACGTATACCTACTCGCCCAATTCGATCAGTGGTATCTAGTTAAGAAATAGTCTTCCTCAATTTGACTC    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
4:301430        147     1000000 301830  60      100M    =       301430  -500    TACATTTGGACTTGATACCGTTACAACGGTTGTGTGATTTCTAGCATTACGTAACAAAACATATCTTCACGGGAGTACGAATATAGGGGTATTCGGGTAA    JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ    NM:i:0  MD:Z:100        AS:i:100        XS:i:0
```

## File permissions

The files created inside the Docker container will be owned by root; inside the Docker container, you are `root` and the files you produce will have `root` permissions. 

```bash
ls -lrt
total 2816
-rw-r--r-- 1 1211 1211 1000015 Apr 27 02:00 ref.fa
-rw-r--r-- 1 1211 1211   21478 Apr 27 02:00 l100_n100_d400_31_2.fq
-rw-r--r-- 1 1211 1211   21478 Apr 27 02:00 l100_n100_d400_31_1.fq
-rw-r--r-- 1 1211 1211     119 Apr 27 02:01 run.sh
-rw-r--r-- 1 root root 1000072 Apr 27 02:03 ref.fa.bwt
-rw-r--r-- 1 root root  250002 Apr 27 02:03 ref.fa.pac
-rw-r--r-- 1 root root      40 Apr 27 02:03 ref.fa.ann
-rw-r--r-- 1 root root      12 Apr 27 02:03 ref.fa.amb
-rw-r--r-- 1 root root  500056 Apr 27 02:03 ref.fa.sa
-rw-r--r-- 1 root root   56824 Apr 27 02:04 aln.sam
```

This is problematic because when you're back in the host environment, you can't modify these files. To circumvent this, create a user that matches the host user by passing three environmental variables from the host to the container.

```bash
docker run -it \
-v ~/my_data:/data \
-e MYUID=`id -u` \
-e MYGID=`id -g` \
-e ME=`whoami` \
bwa /bin/bash
```

Use the steps below to create an identical user inside the container.

```bash
adduser --quiet --home /home/san/$ME --no-create-home --gecos "" --shell /bin/bash --disabled-password $ME

# optional: give yourself admin privileges
echo "%$ME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# update the IDs to those passed into Docker via environment variable
sed -i -e "s/1000:1000/$MYUID:$MYGID/g" /etc/passwd
sed -i -e "s/$ME:x:1000/$ME:x:$MYGID/" /etc/group

# su - as the user
exec su - $ME

# run BWA again, after you have deleted the old files as root
bwa index ref.fa
bwa mem ref.fa l100_n100_d400_31_1.fq l100_n100_d400_31_2.fq > aln.sam

# check output
ls -lrt
total 2816
-rw-r--r-- 1 dtang dtang 1000015 Apr 27 02:00 ref.fa
-rw-r--r-- 1 dtang dtang   21478 Apr 27 02:00 l100_n100_d400_31_2.fq
-rw-r--r-- 1 dtang dtang   21478 Apr 27 02:00 l100_n100_d400_31_1.fq
-rw-r--r-- 1 dtang dtang     119 Apr 27 02:01 run.sh
-rw-rw-r-- 1 dtang dtang 1000072 Apr 27 02:12 ref.fa.bwt
-rw-rw-r-- 1 dtang dtang  250002 Apr 27 02:12 ref.fa.pac
-rw-rw-r-- 1 dtang dtang      40 Apr 27 02:12 ref.fa.ann
-rw-rw-r-- 1 dtang dtang      12 Apr 27 02:12 ref.fa.amb
-rw-rw-r-- 1 dtang dtang  500056 Apr 27 02:12 ref.fa.sa
-rw-rw-r-- 1 dtang dtang   56824 Apr 27 02:12 aln.sam

# exit container
exit
```

The files will be saved in `~/my_data` on the host.

```bash
ls -lrt ~/my_data
total 2816
-rw-r--r-- 1 dtang dtang 1000015 Apr 27 10:00 ref.fa
-rw-r--r-- 1 dtang dtang   21478 Apr 27 10:00 l100_n100_d400_31_2.fq
-rw-r--r-- 1 dtang dtang   21478 Apr 27 10:00 l100_n100_d400_31_1.fq
-rw-r--r-- 1 dtang dtang     119 Apr 27 10:01 run.sh
-rw-rw-r-- 1 dtang dtang 1000072 Apr 27 10:12 ref.fa.bwt
-rw-rw-r-- 1 dtang dtang  250002 Apr 27 10:12 ref.fa.pac
-rw-rw-r-- 1 dtang dtang      40 Apr 27 10:12 ref.fa.ann
-rw-rw-r-- 1 dtang dtang      12 Apr 27 10:12 ref.fa.amb
-rw-rw-r-- 1 dtang dtang  500056 Apr 27 10:12 ref.fa.sa
-rw-rw-r-- 1 dtang dtang   56824 Apr 27 10:12 aln.sam
```

## File Permissions 2

An easier way is to use the `-u` parameter

```bash
# assuming blah.fa exists in /local/data/
docker run -v /local/data:/data -u `stat -c "%u:%g" /local/data` bwa bwa index /data/blah.fa
```

# Removing the image

Find all the `bwa` processes (which should be stopped once you exit the container) and remove them.

```bash
docker ps -a
docker rm <blah>
docker rmi bwa
```

# Committing a change

When you log out of a container, the changes made are still stored; type `docker ps -a` to see all containers and the latest changes. You can [commit](https://docs.docker.com/engine/reference/commandline/commit/) these changes to the image. (Generally, it is better to use Dockerfiles to manage your images in a documented and maintainable way.)

```bash
docker ps -a

# git style commit
# -a, --author=       Author (e.g., "John Hannibal Smith <hannibal@a-team.com>")
# -m, --message=      Commit message
docker commit -m 'Made change to blah' -a 'Dave Tang' <CONTAINER ID> <image>

# use docker history <image> to check history
docker history <image>
```

# Access running container

To access a container that is already running, perhaps in the background (`docker run` with `-d`) use `docker exec`

```bash
docker exec -it rstudio_dtang /bin/bash
```

# Cleaning up exited containers

By default a container's file system persists even after the container exits. For example:

```bash
docker run hello-world

docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     PORTS               NAMES
5f640a09f34c        hello-world         "/hello"            6 seconds ago       Exited (0) 5 seconds ago                       xenodochial_kapitsa
```

We can use a sub-shell to get all (`-a`) container IDs (`-q`) that have exited (`-f status=exited`) and then remove them (`docker rm -v`).

```bash
docker rm -v $(docker ps -a -q -f status=exited)
5f640a09f34c

docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

As a Bash script; `-z` returns true if `$exited` is empty, i.e. no exited containers.

```bash
#!/bin/bash

exited=`docker ps -a -q -f status=exited`

if [ ! -z "$exited" ]; then
   docker rm -v $(docker ps -a -q -f status=exited)
fi
```

You can use the [--rm](https://docs.docker.com/engine/reference/run/#clean-up---rm) parameter to automatically clean up the container and remove the file system when the container exits.

```bash
docker run --rm hello-world

docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

# Installing Perl modules

Use `cpanminus`.

```bash
apt-get install -y cpanminus

# install some Perl modules
cpanm Archive::Extract Archive::Zip DBD::mysql
```

# Creating a data container

This [guide on working with Docker data volumes](https://www.digitalocean.com/community/tutorials/how-to-work-with-docker-data-volumes-on-ubuntu-14-04) provides a really nice introduction. Use `docker create` to create a data container; the `-v` indicates the directory for the data container; the `--name data_container` indicates the name of the data container; and `ubuntu` is the image to be used for the container.

```bash
docker create -v /tmp --name data_container ubuntu
```

If we run a new Ubuntu container with the `--volumes-from` flag, output written to the `/tmp` directory will be saved to the `/tmp` directory of the `data_container` container.

```bash
docker run -it --volumes-from data_container ubuntu /bin/bash
```

# R

Use https://github.com/rocker-org/rocker

```bash
docker run --rm -ti rocker/r-base
```

For Bioconductor use [release_core](https://hub.docker.com/r/bioconductor/release_core/) from the [Bioconductor Docker Hub](https://hub.docker.com/u/bioconductor/) by running:

```bash
docker pull bioconductor/release_core

# run R in vanilla mode (just like the ice cream, it means plain)
docker run -it bioconductor/release_core R --vanilla

# quit R
q()
```

# Saving and transferring a Docker image

See [this post](http://stackoverflow.com/questions/23935141/how-to-copy-docker-images-from-one-host-to-another-without-via-repository) on Stack Overflow.

```bash
docker save -o <save image to path> <image name>
docker load -i <path to image tar file>
```

Here's an example.

```bash
# save on Unix server
docker save -o davebox.tar davebox

# copy file to MacBook Pro
scp davetang@192.168.0.31:/home/davetang/davebox.tar .

docker load -i davebox.tar 
93c22f563196: Loading layer [==================================================>] 134.6 MB/134.6 MB
...

docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
davebox             latest              d38f27446445        10 days ago         3.46 GB

docker run davebox samtools

Program: samtools (Tools for alignments in the SAM format)
Version: 1.3 (using htslib 1.3)

Usage:   samtools <command> [options]
...
```

# Pushing to Docker Hub

https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html

```bash
docker login

# create repo on Docker Hub then tag your image
docker tag bb38976d03cf yourhubusername/newrepo

# push
docker push yourhubusername/newrepo
```

# Tips

Tip from https://support.pawsey.org.au/documentation/display/US/Containers: each RUN, COPY, and ADD command in a Dockerfile generates another layer in the container thus increasing its size; use multi-line commands and clean up package manager caches to minimise image size:

```bash
RUN apt-get update \
      && apt-get install -y \
         autoconf \
         automake \
         gcc \
         g++ \
         python \
         python-dev \
      && apt-get clean all \
      && rm -rf /var/lib/apt/lists/*
```

## Useful links

* [A quick introduction to Docker](http://blog.scottlowe.org/2014/03/11/a-quick-introduction-to-docker/)
* [The BioDocker project](https://github.com/BioDocker/biodocker); check out their [Wiki](https://github.com/BioDocker/biodocker/wiki), which has a lot of useful information
* [The impact of Docker containers on the performance of genomic pipelines](http://www.ncbi.nlm.nih.gov/pubmed/26421241)
* [Learn enough Docker to be useful](https://towardsdatascience.com/learn-enough-docker-to-be-useful-b0b44222eef5)
* [10 things to avoid in Docker containers](http://developers.redhat.com/blog/2016/02/24/10-things-to-avoid-in-docker-containers/)
* The [Play with Docker classroom](https://training.play-with-docker.com/) brings you labs and tutorials that help you get hands-on experience using Docker
* [Shifter](https://github.com/NERSC/shifter) enables container images for HPC
* http://biocworkshops2019.bioconductor.org.s3-website-us-east-1.amazonaws.com/page/BioconductorOnContainers__Bioconductor_Containers_Workshop/

