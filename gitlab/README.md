# README

[GitLab Docker images](https://docs.gitlab.com/ee/install/docker.html) are monolithic images of GitLab running all the necessary services in a single container. Official Docker image at <https://hub.docker.com/r/gitlab/gitlab-ee/>, which contains the GitLab Enterprise Edition image based on the Omnibus package. This container uses the official Omnibus GitLab package, so all configuration is done in the unique configuration file `/etc/gitlab/gitlab.rb`.

```bash
docker pull gitlab/gitlab-ee:14.2.3-ee.0

docker images gitlab/gitlab-ee:14.2.3-ee.0
REPOSITORY         TAG           IMAGE ID       CREATED      SIZE
gitlab/gitlab-ee   14.2.3-ee.0   9654fe42c8b2   9 days ago   2.43GB
```

Start a container. (This takes a couple of minutes to start up depending on your compute resources; check `docker ps -a` and make sure the container does not say "health: starting" anymore.)

```bash
export GITLAB_HOME=$HOME/gitlab

docker run \
  -detach \
  --publish 4445:443 \
  --publish 8889:80 \
  --publish 7778:22 \
  --name gitlab \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  gitlab/gitlab-ee:14.2.3-ee.0
```

Visit `localhost:8889` and log in with username root and the password from the following command:

```bash
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

To edit configuration file use `docker exec`.

```bash
docker exec -it gitlab vi /etc/gitlab/gitlab.rb
```

Use `docker restart` to restart container.

```bash
docker restart gitlab
```

