From ubuntu
MAINTAINER Dave Tang <me@davetang.org>

RUN apt-get update
RUN apt-get install -y wget build-essential libcurl4-gnutls-dev libssl-dev libxml2-dev fort77 xorg-dev liblzma-dev libblas-dev gfortran gcc-multilib gobjc++ aptitude libbz2-dev libpcre3 libpcre3-dev openjdk-6-jdk
RUN aptitude install -y libreadline-dev

RUN mkdir /src && cd /src && wget https://cran.r-project.org/src/base/R-3/R-3.3.2.tar.gz && tar -xzf R-3.3.2.tar.gz && cd R-3.3.2 && ./configure && make && make install
RUN R -e 'install.packages(c("devtools", "XML", "ontologyIndex", "dplyr", "ggplot2"), repos = "http://cran.us.r-project.org")'
RUN R -e 'source("https://bioconductor.org/biocLite.R"); biocLite("Rgraphviz", ask=FALSE)'
RUN R -e 'install.packages("ontologyPlot", repos = "http://cran.us.r-project.org")'

CMD R --version

