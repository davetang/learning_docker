## MySQL

Use https://hub.docker.com/_/mysql/?tab=description

    docker pull mysql:8

Starting a MySQL instance;

    docker run -p 3306:3306 --name docker_mysql -v ~/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password -d mysql:8
    docker port docker_mysql 3306

where `--name` is the name you want to assign to your container and password is the password to be set for the MySQL root user. The -v `~/mysql:/var/lib/mysql` part of the command mounts `~/mysql` directory from the underlying host system as `/var/lib/mysql` inside the container, where MySQL by default will write its data files.

You can get the IP address by using `docker network` (see https://docs.docker.com/network/network-tutorial-standalone/):

    docker network inspect bridge

You can use the same image to connect:

    docker run -it --network bridge --rm mysql:8 mysql -h 172.17.0.2 -u root -p

If you have the `mysql` client installed, you can use the client too:

    mysql -h 0.0.0.0 -u root -p

