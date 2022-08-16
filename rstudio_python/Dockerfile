FROM davetang/rstudio:4.2.0

LABEL source="https://github.com/davetang/learning_docker/blob/main/rstudio_python/Dockerfile"

MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get clean all && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		python3 \
		python-is-python3 \
		python3-pip \
	&& apt-get clean all && \
	apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install numpy pandas scikit-learn matplotlib

WORKDIR /home/rstudio

