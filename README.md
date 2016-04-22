# Getting started with Docker

Check out the official [getting started guide](https://docs.docker.com/linux/).

## Dockerfile

[Dockerfile documentation](https://docs.docker.com/engine/reference/builder/).

~~~~{.bash}
cat cat Dockerfile
From ubuntu
MAINTAINER Dave Tang <dave.tang@telethonkids.org.au>
RUN apt-get update
RUN apt-get install -y git build-essential zlib1g-dev

RUN mkdir /src
RUN cd /src && git clone https://github.com/lh3/bwa.git && cd bwa && make && ln -s /src/bwa/bwa /usr/bin/bwa
~~~~

## Building the image

~~~~{.bash}
docker build -t bwa .
~~~~

## Running the image

[Docker run documentation](https://docs.docker.com/engine/reference/run/). Mounting an INPUT and OUTPUT directory into the Docker container and creating three environmental variables.

~~~~{.bash}
docker run -it \
-v /home/tang/input/:/INPUT \
-v /home/tang/output/:/OUTPUT \
-e MYUID=`id -u` \
-e MYGID=`id -g` \
-e ME=`whoami` \
bwa
~~~~

## Creating an identical user inside the container

Inside the Docker container, you are `root`; the files you produce will have `root` permissions. Use the steps below to create an identical user inside the container, so that the files you produce can be edited outside of the container.

~~~{.bash}
adduser --quiet --home /home/san/$ME --no-create-home --gecos "" --shell /bin/bash --disabled-password $ME
echo "%$ME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# update the IDs to those passed into Docker via environment variable
sed -i -e "s/1000:1000/$MYUID:$MYGID/g" /etc/passwd
sed -i -e "s/$ME:x:1000/$ME:x:$MYGID/" /etc/group

# su - as the user
exec su - $ME

exit
~~~

## Removing the image

Find all the `bwa` processes (which should be stopped once you exit the container) and remove them.

~~~~{.bash}
docker ps -a
docker rm <blah>
docker rmi bwa
~~~~

## Installing Perl modules

Use `cpanminus`.

~~~~{.bash}
apt-get install -y cpanminus

# install some Perl modules
cpanm Archive::Extract Archive::Zip DBD::mysql
~~~~

## Useful links

* [A quick introduction to Docker](http://blog.scottlowe.org/2014/03/11/a-quick-introduction-to-docker/)

