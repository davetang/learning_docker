From ubuntu
MAINTAINER Dave Tang <me@davetang.org>
RUN apt-get update

# dependencies for GEMINI
# Python 2.7.x, git, wget, a working C/C++ compiler such as gcc, and zlib (include headers)
RUN apt-get install -y python git unzip curl build-essential zlib1g-dev wget
RUN mkdir /src && cd /src && wget https://raw.github.com/arq5x/gemini/master/gemini/scripts/gemini_install.py && python gemini_install.py /usr/local /usr/local/share/gemini
RUN gemini update --dataonly --extra cadd_score

# include tabix and bgzip, which are required by GEMINI, and might as well include BCFtools
RUN cd /src && wget https://github.com/samtools/htslib/releases/download/1.3.2/htslib-1.3.2.tar.bz2 && tar -xjf htslib-1.3.2.tar.bz2 && cd htslib-1.3.2 && make && make install
RUN cd /src && wget https://github.com/samtools/bcftools/releases/download/1.3.1/bcftools-1.3.1.tar.bz2 && tar -xjf bcftools-1.3.1.tar.bz2 && cd bcftools-1.3.1 && make && make install

CMD gemini

