## README

Install [SAMtools](http://www.htslib.org/) 1.5 in a Docker image.

```bash
# change image name from davebox to name of your choice
docker build -t davebox .
```

Convert SAM to BAM.

```bash
# download example SAM file
wget https://github.com/davetang/learning_bam_file/raw/master/aln.sam

# run SAMtools
docker run -v `pwd`:/data davebox samtools view -bS /data/aln.sam > aln.bam
```

Setup alias for samtools by including this line in your `.profile` or `.bash_profile` file.

```bash
alias samtools="docker run -v `pwd`:/data davebox samtools"

samtools

Program: samtools (Tools for alignments in the SAM format)
Version: 1.5 (using htslib 1.5)

Usage:   samtools <command> [options]

Commands:
  -- Indexing
     dict           create a sequence dictionary file
     faidx          index/extract FASTA
     index          index alignment

  -- Editing
     calmd          recalculate MD/NM tags and '=' bases
     fixmate        fix mate information
     reheader       replace BAM header
     rmdup          remove PCR duplicates
     targetcut      cut fosmid regions (for fosmid pool only)
     addreplacerg   adds or replaces RG tags

  -- File operations
     collate        shuffle and group alignments by name
     cat            concatenate BAMs
     merge          merge sorted alignments
     mpileup        multi-way pileup
     sort           sort alignment file
     split          splits a file by read group
     quickcheck     quickly check if SAM/BAM/CRAM file appears intact
     fastq          converts a BAM to a FASTQ
     fasta          converts a BAM to a FASTA

  -- Statistics
     bedcov         read depth per BED region
     depth          compute the depth
     flagstat       simple stats
     idxstats       BAM index stats
     phase          phase heterozygotes
     stats          generate stats (former bamcheck)

  -- Viewing
     flags          explain BAM flags
     tview          text alignment viewer
     view           SAM<->BAM<->CRAM conversion
     depad          convert padded BAM to unpadded BAM


# remember to include /data/, where the current directory is mounted
samtools view -bS /data/aln.sam > aln.bam
```

Finally I have a [clean up script](https://github.com/davetang/learning_docker#cleaning-up-exited-containers) that I run to remove all the exited containers.

