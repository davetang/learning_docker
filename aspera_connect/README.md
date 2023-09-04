# README

[IBM Aspera Connect](https://www.ibm.com/aspera/connect/) cannot be installed
as root. If you try, you will get the following message.

```
Installing IBM Aspera Connect

This script cannot be run as root, IBM Aspera Connect must be installed per user.
```

This is why a user (called `parasite`) is created in the Dockerfile.

```
ARG user=parasite
RUN useradd \
    --create-home \
    --home-dir /home/${user} \
    --base-dir /home/${user} \
    --shell /bin/bash ${user} && \
    echo "${user}:password" | chpasswd && \
    usermod -d /home/${user} ${user}
```

In addition, the SSH keys are missing in the latest versions of Aspera Connect
and are manually copied.

```
arg home=/home/${user}
copy --chown=${user}:${user} asperaweb_id_dsa.openssh ${home}
copy --chown=${user}:${user} asperaweb_id_dsa.openssh.pub ${home}
```

In the Dockerfile, `/home/parasite` is made globally accessible so any user can
run `ascp`. (I did not think this would work when I was implementing it because
I thought the installation had some user specific settings but it does!)

```
arg home=/home/${user}
RUN chmod -R 777 ${home}
```

Use the image as follows but change the URL to the data you want to download;
also note the period at the end, which specifies where to copy the data.

```console
docker run --rm -u $(id -u):$(id -g) -v $(pwd):$(pwd) -w $(pwd) davetang/aspera_connect:4.2.6.393 era-fasp@fasp.sra.ebi.ac.uk:vol1/fastq/SRR390/SRR390728/SRR390728_1.fastq.gz .
```
