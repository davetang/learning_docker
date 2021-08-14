#!/usr/bin/env bash

set -euo pipefail

if ! [ -x "$(command -v gh-md-toc)" ]; then
   >&2 echo Please install gh-md-toc from https://github.com/ekalinin/github-markdown-toc
   exit 1
fi

if ! [ -x "$(command -v Rscript)" ]; then
   >&2 echo Could not find Rscript. Please make sure R is installed.
   exit 1
fi

out_md=tmp.md
Rscript -e "rmarkdown::render('readme.Rmd', output_file=\"${out_md}\")"

cp -f ${out_md} mkdocs_site/docs/index.md

gh-md-toc ${out_md} > toc

cat toc <(echo) <(date) <(echo) ${out_md} > README.md

rm ${out_md} toc

>&2 echo Done!

exit 0

