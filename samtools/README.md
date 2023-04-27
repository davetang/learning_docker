# README

Build a Docker image for [samtools](https://github.com/samtools/samtools) using
a [multistage build](https://docs.docker.com/build/building/multi-stage/) for
testing purposes only. Do not use this image for any other reason because it
includes a lot of unnecessary libraries.

Ideally the image should only contain these dependencies:

Samtools:
* zlib
* curses or GNU ncurses (optional, for the 'tview' command)

HTSlib:
* zlib
* libbz2
* liblzma
* libcurl (optional but strongly recommended, for network access)
* libcrypto (optional, for Amazon S3 support; not needed on MacOS)

Or is there a way to build `samtools` such that all libraries are statically
linked, where a multistage build makes more sense.

## Build

Use Ubuntu build image to build `samtools`.

```console
docker pull davetang/build:23.04
```

Run `build.sh`.

```console
./build.sh
```

## Testing

Run `test.sh`.

```console
./test.sh
# 1176360 + 0 in total (QC-passed reads + QC-failed reads)
# 1160084 + 0 primary
# 16276 + 0 secondary
# 0 + 0 supplementary
# 0 + 0 duplicates
# 0 + 0 primary duplicates
# 1126961 + 0 mapped (95.80% : N/A)
# 1110685 + 0 primary mapped (95.74% : N/A)
# 1160084 + 0 paired in sequencing
# 580042 + 0 read1
# 580042 + 0 read2
# 1060858 + 0 properly paired (91.45% : N/A)
# 1065618 + 0 with itself and mate mapped
# 45067 + 0 singletons (3.88% : N/A)
# 0 + 0 with mate mapped to a different chr
# 0 + 0 with mate mapped to a different chr (mapQ>=5)
# Done
```
