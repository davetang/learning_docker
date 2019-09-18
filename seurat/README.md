## README

R version 3.6.1 with `Seurat` and `tidyverse` packages installed.

```
docker images
REPOSITORY              TAG                 IMAGE ID            CREATED             SIZE
davetang/seurat3        latest              ce6e4ec3d604        5 minutes ago       1.24GB
```

Image available at https://hub.docker.com/r/davetang/seurat3.

```
docker run --rm -it davetang/seurat3 R

R version 3.6.1 (2019-07-05) -- "Action of the Toes"
Copyright (C) 2019 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under certain conditions.
Type 'license()' or 'licence()' for distribution details.

R is a collaborative project with many contributors.
Type 'contributors()' for more information and
'citation()' on how to cite R or R packages in publications.

Type 'demo()' for some demos, 'help()' for on-line help, or
'help.start()' for an HTML browser interface to help.
Type 'q()' to quit R.

> library(Seurat)
Registered S3 method overwritten by 'R.oo':
  method        from       
  throw.default R.methodsS3
> 
```

