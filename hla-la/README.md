## README

Installing https://github.com/DiltheyLab/HLA-LA

## Installation

Use Docker. Check out https://github.com/zlskidmore/docker-hla-la/blob/master/Dockerfile.

    docker build -f Dockerfile -t davetang/hla-la .
    docker run --rm -it hla-la /bin/bash

Follow instructions from https://stackoverflow.com/questions/12578499/how-to-install-boost-on-ubuntu to install Boost (requires >= 1.59)

    cd /tmp
    wget https://sourceforge.net/projects/boost/files/boost/1.72.0/boost_1_72_0.tar.gz/download -O boost_1_72_0.tar.gz
    tar -xzf boost_1_72_0.tar.gz && cd boost_1_72_0
    ./bootstrap.sh --prefix=/usr/
    ./b2 && ./b2 install

`CMAKE_INSTALL_PREFIX` is the root of your final installation directory; see https://github.com/pezmaster31/bamtools/wiki/Building-and-installing;

    cd /tmp && mkdir tool
    git clone https://github.com/pezmaster31/bamtools
    cd bamtools
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/tmp/tool/ -DBUILD_SHARED_LIBS=ON ..
    make
    make install
    cd /tmp/tool/ && ln -s lib lib64

Miniconda

    cd /tmp/
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh -b -p $HOME/miniconda3
    /root/miniconda3/condabin/conda install -y -c bioconda bwa samtools picard mummer minimap2

Picard

    cd /tmp/
    wget https://sourceforge.net/projects/picard/files/picard-tools/1.119/picard-tools-1.119.zip/download -O picard-tools-1.119.zip
    unzip picard-tools-1.119.zip

HLA-LA

    cd /tmp/
    mkdir HLA-LA HLA-LA/bin HLA-LA/src HLA-LA/obj HLA-LA/temp HLA-LA/working HLA-LA/graphs
    cd HLA-LA/src; git clone https://github.com/DiltheyLab/HLA-LA.git .
    make all BOOST_PATH=/usr/ BAMTOOLS_PATH=/tmp/tool/
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/tmp/tool/lib64
    ../bin/HLA-LA --action testBinary

Should see

    HLA*LA binary functional!

## Testing

Download testing data and check integrity (md5sum):

* PRG_MHC_GRCh38_withIMGT.tar.gz 525a8aa0c7f357bf29fe2c75ef1d477d
* NA12878.mini.cram 45d1769ffed71418571c9a2414465a12

Download tarball and CRAM file in `graphs` directory.

    cd /tmp/HLA-LA/graphs/
    wget -c http://www.well.ox.ac.uk/downloads/PRG_MHC_GRCh38_withIMGT.tar.gz
    md5sum PRG_MHC_GRCh38_withIMGT.tar.gz
    tar -xzf PRG_MHC_GRCh38_withIMGT.tar.gz
    wget -c https://www.dropbox.com/s/xr99u3vqaimk4vo/NA12878.mini.cram?dl=0 -O NA12878.mini.cram
    
Edit `paths.ini`.

    picard_sam2fastq_bin=/tmp/picard-tools-1.119/SamToFastq.jar
    samtools_bin=/root/miniconda3/bin/samtools
    bwa_bin=/root/miniconda3/bin/bwa
    nucmer_bin=/root/miniconda3/bin/nucmer
    dnadiff_bin=/root/miniconda3/bin/dnadiff
    minimap2_bin=/root/miniconda3/bin/minimap2
    workingDir=$HLA-LA-DIR/../working/
    workingDir_HLA_ASM=$HLA-LA-DIR/output_HLA_ASM/

