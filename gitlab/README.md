# README

[GitLab Docker images](https://docs.gitlab.com/ee/install/docker.html) are monolithic images of GitLab running all the necessary services in a single container. Official Docker image at <https://hub.docker.com/r/gitlab/gitlab-ee/>, which contains the GitLab Enterprise Edition image based on the Omnibus package. This container uses the official Omnibus GitLab package, so all configuration is done in the unique configuration file `/etc/gitlab/gitlab.rb`.

```bash
docker pull gitlab/gitlab-ee:14.2.3-ee.0

docker images gitlab/gitlab-ee:14.2.3-ee.0
# REPOSITORY         TAG           IMAGE ID       CREATED      SIZE
# gitlab/gitlab-ee   14.2.3-ee.0   9654fe42c8b2   9 days ago   2.43GB
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

## Add user

Logout from `root` account, then register a new account on the main page. Log back in as `root` and click `Menu` and then `Admin`. Then goto `Users` in the left menu bar and click the `Pending approval` tab and approve. Once approved go to the `Active` tab, click on the new user's name, look for the `Edit` button near the top right and click on it, and change the access level to `Admin`. 

## SSH key

Add the following to `~/.ssh/config`.

```
Host localhost
 HostName localhost
 User git
 IdentityFile /location/of/ssh_key
 Port 7778
```

Check.

```bash
ssh -T git@localhost
# Welcome to GitLab, @davetang!
```

## GitLab Runner

[Install GitLab Runner](https://docs.gitlab.com/runner/install/).

```bash
# Download the binary for your system
curl -L --output /usr/local/bin/gitlab-runner https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-linux-amd64

# Give it permissions to execute
chmod +x /usr/local/bin/gitlab-runner

# Create a GitLab CI user
useradd --comment 'GitLab Runner' --create-home gitlab-runner --shell /bin/bash

# Install and run as service
gitlab-runner install --user=gitlab-runner --working-directory=/home/gitlab-runner
gitlab-runner start
```

## Clone

Create a new project from the GUI.

```bash
git clone git@localhost:davetang/test_pages.git
# Cloning into 'test_pages'...
# remote: Enumerating objects: 116, done.
# remote: Total 116 (delta 0), reused 0 (delta 0), pack-reused 116
# Receiving objects: 100% (116/116), 1014.88 KiB | 59.70 MiB/s, done.
# Resolving deltas: 100% (6/6), done.
```

## GitLab Pages

See [GitLab Pages](https://docs.gitlab.com/ee/user/project/pages/) and following the tutorial for [creating a GitLab Pages website from scratch](https://docs.gitlab.com/ee/user/project/pages/getting_started/pages_from_scratch.html). Firstly, create a new project using the GUI.

```bash
git clone git@localhost:davetang/static_html.git
cd static_html
```

Create `index.html`.

```
 <html>
 <head>
   <title>Home</title>
 </head>
 <body>
   <h1>Hello World!</h1>
 </body>
 </html>
```

Create `.gitlab-ci.yml`.

```
image: ruby:2.7

pages:
  script:
    - gem install bundler
    - bundle install
    - bundle exec jekyll build -d public
  artifacts:
    paths:
      - public
```

Create `Gemfile`.

```
source "https://rubygems.org"

gem "jekyll"
```

