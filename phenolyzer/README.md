## README

Build:

~~~~{.bash}
docker build -t phenolyzer .
~~~~

Run:

~~~~{.bash}
docker run -v /local:/data -u `stat -c "%u:%g" /local` phenolyzer perl /src/phenolyzer/disease_annotation.pl /data/hpo.txt -f -p -ph -logistic -out /data/phenolyzer/hpo -addon DB_DISGENET_GENE_DISEASE_SCORE,DB_GAD_GENE_DISEASE_SCORE -addon_weight 0.25
~~~~

