From ubuntu
MAINTAINER Dave Tang <me@davetang.org>
RUN apt-get update

RUN apt-get install -y wget unzip cpanminus libmysqlclient-dev build-essential curl git zlib1g-dev
RUN cpanm Archive::Extract Archive::Zip DBD::mysql

RUN mkdir /src && cd /src && wget https://github.com/Ensembl/ensembl-tools/archive/release/82.zip && unzip 82.zip && cd ensembl-tools-release-82/scripts/variant_effect_predictor/ && perl ./INSTALL.pl -a alc -y GRCh37 -s homo_sapiens

CMD echo Image for the Variant Effector Predictor tool

