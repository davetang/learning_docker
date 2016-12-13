## README

Build:

~~~~{.bash}
docker build -t vt .
~~~~

Download test file:

~~~~{.bash}
wget http://davetang.org/eg/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf.gz
~~~~

Run:

~~~~{.bash}
docker run -v /local:/data -u `stat -c "%u:%g" /local` vt vt decompose -s /data/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf.gz -o /data/first.vcf
docker run -v /local:/data -u `stat -c "%u:%g" /local` vt vt normalize -r /data/hg19.fa -o /data/second.vcf /data/first.vcf

md5sum second.vcf 
d1f148e4a5bd312e5a709404cdb80132  second.vcf
~~~~

I normally run `decompose` and `normalize` as a pipe but I couldn't using Docker, hence the two separate steps.

