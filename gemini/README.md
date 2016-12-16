## README

The Docker image ended up being 49.73 GB in size, mainly because of CADD.

Build:

~~~~{.bash}
docker build -t gemini .
~~~~

I already have a test GEMINI database called test.db; run a test query:

~~~~{.bash}
docker run -v /local:/data/ gemini gemini query -q 'select count(*) from variants' --header /data/test.db
count(*)
53103

# redirect
docker run -v /local:/data/ gemini gemini query -q 'select count(*) from variants' --header /data/test.db > output
cat output 
count(*)
53103
~~~~

