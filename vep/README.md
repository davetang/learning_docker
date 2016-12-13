## README

Variant Effect Predictor with cached data for hg19.

Build:

~~~~{.bash}
docker build -t vep .
~~~~

Run test:

~~~~{.bash}
docker run -v /local/:/data/ vep perl /src/ensembl-tools-release-82/scripts/variant_effect_predictor/variant_effect_predictor.pl -i /src/ensembl-tools-release-82/scripts/variant_effect_predictor/example_GRCh37.vcf --cache --assembly GRCh37 --offline --force_overwrite --dir_cache /root/.vep --output_file /data/outfile.vcf --vcf
~~~~

For some reason, when I run `docker` with:

```
-u `stat -c "%u:%g" /SCRATCH/Tang/docker/vep`
```

VEP cannot find the cached directory even though I specify it using `--dir_cache`. Resorted to manually changing the permissions back:

~~~~{.bash}
docker run -v /local:/data/ vep chown $EUID:$EUID /data/outfile.vcf_summary.html
docker run -v /local:/data/ vep chown $EUID:$EUID /data/outfile.vcf
~~~~

