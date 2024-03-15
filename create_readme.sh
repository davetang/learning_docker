#!/usr/bin/env bash

set -euo pipefail

if ! [ -x "$(command -v docker)" ]; then
   >&2 echo Could not find Docker
   exit 1
fi

download_url (){
   my_url=$1
   outfile=$2
   if ! [ -x "$(command -v wget)" ]; then
      if ! [ -x "$(command -v curl)" ]; then
         >&2 echo Could not find a suitable downloader
         exit 1
      else
         curl ${my_url} -L --max-redirs 5 -o ${outfile}
      fi
   fi
   wget -O ${outfile} ${my_url}
}

if ! [ -x "$(command -v pandoc)" ]; then
   >&2 echo Could not find pandoc
   >&2 echo Trying to download pandoc
   os=$(uname -s)
   arc=$(arch)

   RAN_DIR=$$$RANDOM
   mkdir /tmp/${RAN_DIR} && cd /tmp/${RAN_DIR}
   pandoc_ver=2.16.2
   pandoc_url=https://github.com/jgm/pandoc/releases/download/${pandoc_ver}/pandoc-${pandoc_ver}

   if [[ ${os} == Darwin ]]; then
      download_url ${pandoc_url}-macOS.zip, pandoc.zip
      unzip pandoc.zip
   elif [[ ${os} == Linux ]]; then
      if [[ ${arc} == x86_64 ]]; then
         download_url ${pandoc_url}-amd64.tar.gz pandoc.tar.gz
         tar -xzf pandoc.tar.gz
      elif [[ ${arc} =~ arm ]]; then
         download_url ${pandoc_url}-arm64.tar.gz pandoc.tar.gz
         tar -xzf pandoc.tar.gz
      fi
   else
      >&2 echo Unrecognised operating system
      exit 1
   fi
   PATH=$PATH:$(pwd)/pandoc-${pandoc_ver}/bin
   cd -
fi

if ! [ -x "$(command -v Rscript)" ]; then
   >&2 echo Could not find Rscript. Please make sure R is installed.
   exit 1
fi

if ! [ -x "$(command -v gh-md-toc)" ]; then
   >&2 echo Could not find gh-md-toc
   ghmdtoc_ver=0.10.0
   ghmdtoc_url=https://github.com/ekalinin/github-markdown-toc/archive/refs/tags/${ghmdtoc_ver}.tar.gz
   RAN_DIR=$$$RANDOM
   mkdir /tmp/${RAN_DIR} && cd /tmp/${RAN_DIR}
   >&2 echo Trying to download gh-md-toc
   if ! [ -x "$(command -v wget)" ]; then
      if ! [ -x "$(command -v curl)" ]; then
         >&2 echo Could not download gh-md-toc
      else
         curl ${ghmdtoc_url} -L --max-redirs 5 -o ghmdtoc-${ghmdtoc_ver}.tar.gz
      fi
   fi
   wget -O ghmdtoc-${ghmdtoc_ver}.tar.gz ${ghmdtoc_url}
   tar -xzf ghmdtoc-${ghmdtoc_ver}.tar.gz
   PATH=$PATH:$(pwd)/github-markdown-toc-${ghmdtoc_ver}
   cd -
fi

out_md=tmp.md
Rscript -e "rmarkdown::render('readme.Rmd', output_file=\"${out_md}\")"

cp -f ${out_md} mkdocs_site/docs/index.md

gh-md-toc ${out_md} > toc

cat toc <(echo) <(date) <(echo) ${out_md} > README.md

rm ${out_md} toc

>&2 echo Done!

exit 0
