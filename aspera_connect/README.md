# README

[IBM Aspera Connect](https://www.ibm.com/aspera/connect/) cannot be installed
as root. If you try, you will get the following message.

```
Installing IBM Aspera Connect

This script cannot be run as root, IBM Aspera Connect must be installed per user.
```

This is why a user (called `parasite`) is created in the Dockerfile.

```
RUN useradd --create-home --shell /bin/bash parasite && \
    echo 'parasite:password' | chpasswd
```

In addition, the SSH keys are missing in the latest versions of Aspera Connect
and are manually copied.

```
ARG home=/home/parasite
COPY --chown=parasite:parasite asperaweb_id_dsa.openssh ${home}
COPY --chown=parasite:parasite asperaweb_id_dsa.openssh.pub ${home}
```

When you run the container, be sure to use the `parasite` user. For example:

```console
docker run --rm -it -u parasite -v $(pwd):$(pwd) -w $(pwd) davetang/aspera_connect:4.2.5.306 /bin/bash
```

Running the command above will mount the current directory and make it the
working directory; this will have permission issues because the parasite user
will (should) have a different user and group ID as you.

One way to get around this is to create a new directory that is globally
writable and use that to save the downloaded files. Then manually change the
file ownership back to your local user.
