## README

Build:

~~~~{.bash}
docker build -t pandoc .
~~~~

Run:

~~~~{.bash}
docker run pandoc
pandoc 1.12.2.1
Compiled with texmath 0.6.5.2, highlighting-kate 0.5.5.1.
Syntax highlighting is supported for the following languages:
    actionscript, ada, apache, asn1, asp, awk, bash, bibtex, boo, c, changelog,
    clojure, cmake, coffee, coldfusion, commonlisp, cpp, cs, css, curry, d,
    diff, djangotemplate, doxygen, doxygenlua, dtd, eiffel, email, erlang,
    fortran, fsharp, gnuassembler, go, haskell, haxe, html, ini, java, javadoc,
    javascript, json, jsp, julia, latex, lex, literatecurry, literatehaskell,
    lua, makefile, mandoc, markdown, matlab, maxima, metafont, mips, modelines,
    modula2, modula3, monobasic, nasm, noweb, objectivec, objectivecpp, ocaml,
    octave, pascal, perl, php, pike, postscript, prolog, python, r,
    relaxngcompact, rhtml, roff, ruby, rust, scala, scheme, sci, sed, sgml, sql,
    sqlmysql, sqlpostgresql, tcl, texinfo, verilog, vhdl, xml, xorg, xslt, xul,
    yacc, yaml
Default user data directory: /root/.pandoc
Copyright (C) 2006-2013 John MacFarlane
Web:  http://johnmacfarlane.net/pandoc
This is free software; see the source for copying conditions.  There is no
warranty, not even for merchantability or fitness for a particular purpose.

docker run -v /local/:/data/ -u `stat -c "%u:%g" /local/` pandoc pandoc -V geometry:margin=1in -s -S --table-of-contents --toc-depth=2 --highlight-style=tango /data/blah.md -o /data/blah.pdf
~~~~

