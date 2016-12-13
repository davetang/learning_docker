From ubuntu
MAINTAINER Dave Tang <dave.tang@telethonkids.org.au>
RUN apt-get update

# dependencies for GEMINI
# Python 2.7.x, git, wget, a working C/C++ compiler such as gcc, and zlib (include headers)
RUN apt-get install -y python git unzip curl build-essential zlib1g-dev wget
RUN mkdir /src && cd /src && wget https://raw.github.com/arq5x/gemini/master/gemini/scripts/gemini_install.py && python gemini_install.py /usr/local /usr/local/share/gemini
RUN gemini update --dataonly --extra cadd_score

# shell form of CMD
CMD gemini

