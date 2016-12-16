## README

One can simply use `apt-get install -y r-base` but that installs `R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"`. The `ubuntu` version I was using:

~~~~{.bash}
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
~~~~

The `ontologyIndex` package required R (≥ 3.1.0), so I created this Dockerfile to install all the required libraries for compiling R. The Docker image created from this Dockerfile was 1.5 GB.

To use `install_github()` from the `devtools` package, you need to set: `options(unzip = 'internal')`.

Build:

~~~~{.bash}
docker build -t r .
~~~~

Run:

~~~~{.bash}
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
~~~~

