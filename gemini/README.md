## README

The Docker image ended up being 49.64 GB in size, because of CADD.

Build:

~~~~{.bash}
docker build -t gemini .
~~~~

I already have a test GEMINI database called test.db; run a test query:

~~~~{.bash}
docker run -v /local:/data/ gemini gemini query -q 'select count(*) from variants' --header /data/test.db
count(*)
53103
~~~~

