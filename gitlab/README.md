# README

Set up your own GitLab server using Docker! The [GitLab Docker images](https://docs.gitlab.com/ee/install/docker.html) contain all the necessary services in a single container. Official Docker images are at <https://hub.docker.com/r/gitlab/gitlab-ee/> and contain the GitLab Enterprise Edition image based on the Omnibus package. All configurations are done in the unique configuration file `/etc/gitlab/gitlab.rb` for containers using the official Omnibus GitLab package.

First we'll pull the latest image. (Use a version tag instead of simply using latest.)

```bash
docker pull gitlab/gitlab-ee:14.2.3-ee.0

docker images gitlab/gitlab-ee:14.2.3-ee.0
# REPOSITORY         TAG           IMAGE ID       CREATED      SIZE
# gitlab/gitlab-ee   14.2.3-ee.0   9654fe42c8b2   9 days ago   2.43GB
```

Next we'll run a container in detached mode, expose some ports, and mount some volumes. (The container takes a couple of minutes to start up [especially the first time you run this step]; check `docker ps -a` and make sure the container does not say "health: starting" anymore.)

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

If all goes well you should be able to see the GitLab page at <localhost:8889>.

## Configuring

To edit the configuration file use `docker exec` (after you have started the container).

```bash
docker exec -it gitlab vi /etc/gitlab/gitlab.rb
```

For your changes to take effect, use `docker restart` to restart container (or run `gitlab-ctl reconfigure`).

```bash
docker restart gitlab

# or

docker exec -it gitlab /bin/bash
gitlab-ctl reconfigure
exit
```

## Add user

To create your own account, visit `localhost:8889` and register a new acccount; it will say that the account is pending. Next log in with username `root` and the password from the following command.

```bash
docker exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

Click on `Menu` and then `Admin`. Then go to `Users` in the left menu bar and click on the `Pending approval` tab and approve the account you just registered. Once approved go to the `Active` tab, click on the new user's name, look for the `Edit` button near the top right and click on it, and change the access level to `Admin`. 

## SSH key

First create your key pair and save the public SSH key. In your `User Settings` click on `SSH Keys` and paste the public key.

Next, add the following to `~/.ssh/config` on your local computer.

```
Host localhost
 HostName localhost
 User git
 IdentityFile /location/of/ssh_key
 Port 7778
```

Check to see if it works.

```bash
ssh -T git@localhost
# Welcome to GitLab, @davetang!
```

## GitLab Runner

The [GitLab Runner](https://docs.gitlab.com/runner/) is an application that works with GitLab CI/CD to run jobs in a pipeline. We can also [install the GitLab Runner](https://docs.gitlab.com/runner/install/docker.html) in a container. But first, we need to find the IP address of our GitLab container by running the following.

```bash
docker network inspect bridge | grep "gitlab" -A 3
                "Name": "gitlab",
                "EndpointID": "d2e73801e30fbe79c054749a111e6d7de6a0b3b8badcca33ab027fb074b5e5ba",
                "MacAddress": "02:42:ac:11:00:05",
                "IPv4Address": "172.17.0.5/16",
```

The IP is `172.17.0.5`. Next set the following in `/etc/gitlab/gitlab.rb`:

* `external_url 'http://172.17.0.5'`.
* `pages_external_url "http://localhost/"`

```bash
docker exec -it gitlab /bin/bash
vi /etc/gitlab/gitlab.rb
gitlab-ctl reconfigure
exit
```

Now pull the `gitlab-runner` image and start a container.

```bash
docker pull gitlab/gitlab-runner:ubuntu-v14.2.0

docker run \
  -d \
  --name gitlab-runner \
  -v /srv/gitlab-runner/config:/etc/gitlab-runner \
  -v /var/run/docker.sock:/var/run/docker.sock \
  gitlab/gitlab-runner:ubuntu-v14.2.0
```

Log into <localhost:8889> and go to the `Admin Area` and `Runners` and copy the registration token. When prompted:

* Use the IP of the container: 172.17.0.5
* Use the registration token from the Admin page of `localhost:8889`
* Enter a description
* Enter tags
* Enter `docker` as your executor
* Enter a default Docker image, such as `ruby:2.7`

```bash
docker run --rm -it -v /srv/gitlab-runner/config:/etc/gitlab-runner gitlab/gitlab-runner:ubuntu-v14.2.0 register

# Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
```

In the `Admin Area` and `Runners` section, you should now see the Runner you registered.

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

To create a new [GitLab Pages](https://docs.gitlab.com/ee/user/project/pages/) create a new project; I will call my new project `pages-test`. Add a new HTML file with the following.

```
 <html>
 <head>
   <title>Home</title>
 </head>
 <body>
   <h1>It's working!</h1>
 </body>
 </html>
```

Add a new file called `.gitlab-ci.yml` with the following.

```
# This file is a template, and might need editing before it works on your project.
# To contribute improvements to CI/CD templates, please follow the Development guide at:
# https://docs.gitlab.com/ee/development/cicd/templates.html
# This specific template is located at:
# https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/gitlab/ci/templates/Pages/HTML.gitlab-ci.yml

# Full project: https://gitlab.com/pages/plain-html
pages:
  stage: deploy
  script:
    - mkdir .public
    - cp -r * .public
    - mv .public public
  artifacts:
    paths:
      - public
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

```

If you go to `CI/CD` and then `Pipelines`, hopefully the page successfully built and passed. Go to `Settings` and then `Pages` to find the URL of your page site. It should look something like `http://username.localhost/pages-test`. In this guide I have forwarded post `80` to `8889`, so you will have to visit <http://username.localhost:8889/pages-test> to see the site.

See [GitLab Pages administration](https://docs.gitlab.com/ee/administration/pages/index.html) for information on how to administer GitLab Pages.

