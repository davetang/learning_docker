## README

The R version that is currently packaged on Ubuntu 14.04 is `R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"`; you can run `apt-get install -y r-base` to install that version. If you require a later version and want to compile from source, read on. Below is the Ubuntu version I'm using as the base image:

```bash
docker run -it ubuntu cat /etc/*release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04.3 LTS"
NAME="Ubuntu"
VERSION="14.04.3 LTS, Trusty Tahr"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 14.04.3 LTS"
VERSION_ID="14.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
```

### Motivation

The `ontologyIndex` package required R (≥ 3.1.0), so I created this Dockerfile to install all the required libraries for compiling R. The Docker image created from this Dockerfile was 1.5 GB.

### Building R from source using Docker

To use `install_github()` from the `devtools` package, you need to set: `options(unzip = 'internal')`.

Build:

```bash
docker build -t r .
```

### Running R

```bash
docker run r
R version 3.3.2 (2016-10-31) -- "Sincere Pumpkin Patch"
Copyright (C) 2016 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

R is free software and comes with ABSOLUTELY NO WARRANTY.
You are welcome to redistribute it under the terms of the
GNU General Public License versions 2 or 3.
For more information about these matters see
http://www.gnu.org/licenses/.

docker run r R --quiet -e 'set.seed(31); sample(1:10, 5)'
> set.seed(31); sample(1:10, 5)
[1]  6  9  4  3 10

docker run r /src/human_phenotype_ontology/prop/hpo_to_ic.R HP:0000007
          id     info       freq
6 HP:0000007 3.623653 0.02668503

docker run r /src/human_phenotype_ontology/cluster/omim_to_closest_2.R 100300
     omim   jaccard
1  100300 1.0000000
2  612530 0.1960784
3  613150 0.1833333
4  601420 0.1794872
5  611603 0.1739130
6  615411 0.1707317
7  300958 0.1702128
8  610031 0.1702128
9  611134 0.1702128
10 235730 0.1700000
11 614219 0.1698113
12 613398 0.1632653
13 608097 0.1627907
14 615282 0.1627907
15 612938 0.1578947
16 600460 0.1571429
17 604317 0.1568627
18 614039 0.1555556
19 615502 0.1555556
20 603671 0.1525424
                                                                                                name
1                                                                              ADAMS-OLIVER SYNDROME
2                                                      #612530 CHROMOSOME 1Q41-Q42 DELETION SYNDROME
3  #613150 MUSCULAR DYSTROPHY-DYSTROGLYCANOPATHY (CONGENITAL WITH BRAIN AND EYEANOMALIES), TYPE A, 2
4                                     MICROCEPHALY, CORPUS CALLOSUM DYSGENESIS, AND CLEFT LIP/PALATE
5                                                                            #611603 LISSENCEPHALY 3
6                              #615411 CORTICAL DYSPLASIA, COMPLEX, WITH OTHER BRAIN MALFORMATIONS 3
7                                                           #300958 MENTAL RETARDATION, X-LINKED 102
8                                                    #610031 POLYMICROGYRIA, SYMMETRIC OR ASYMMETRIC
9                                                                    #611134 MECKEL SYNDROME, TYPE 4
10                                                                     #235730 MOWAT-WILSON SYNDROME
11                                                                   #614219 ADAMS-OLIVER SYNDROME 2
12                                                                  #613398 WARSAW BREAKAGE SYNDROME
13                        #608097 PERIVENTRICULAR HETEROTOPIA WITH MICROCEPHALY, AUTOSOMAL RECESSIVE
14                             #615282 CORTICAL DYSPLASIA, COMPLEX, WITH OTHER BRAIN MALFORMATIONS 2
15                    #612938 GROWTH RETARDATION, DEVELOPMENTAL DELAY, COARSE FACIES, AND EARLYDEATH
16                          600460 CLEFT PALATE, CARDIAC DEFECT, GENITAL ANOMALIES, AND ECTRODACTYLY
17       #604317 MICROCEPHALY 2, PRIMARY, AUTOSOMAL RECESSIVE, WITH OR WITHOUT CORTICALMALFORMATIONS
18                               #614039 CORTICAL DYSPLASIA, COMPLEX, WITH OTHER BRAIN MALFORMATIONS
19                                                 #615502 MENTAL RETARDATION, AUTOSOMAL DOMINANT 21
20                                                          #603671 ACROMELIC FRONTONASAL DYSOSTOSIS
```

Running R while mounting the current directory:

```bash
docker run -v `pwd`:/data/ -w /data/ -it r R

R version 3.4.1 (2017-06-30) -- "Single Candle"
Copyright (C) 2017 The R Foundation for Statistical Computing
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

> list.files('/data')
> [1] "1M_neurons_aggr_web_summary.html"          
> [2] "1M_neurons_analysis.tar.gz"                
> [3] "1M_neurons_cloupe.cloupe"                  
> [4] "1M_neurons_filtered_gene_bc_matrices_h5.h5"
> [5] "1M_neurons_neuron20k.h5"                   
> [6] "1M_neurons_reanalyze.csv"                  
> [7] "1M_neurons_web_summary.html"               
```

Commit changes you've made, if you want:

```bash
# Show the latest created container (includes all states)
docker ps -l

docker commit -m 'Installed monocole' -a 'Dave Tang' <CONTAINER ID> <image>
```

