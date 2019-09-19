#!/usr/bin/env perl

use strict;
use warnings;
use Bio::DB::Sam;
use Getopt::Std;
use Parallel::ForkManager;
# https://github.com/MullinsLab/Bio-Cigar
use Bio::Cigar;

use lib "$ENV{HOME}/perllib/";
use Vcf;

print "OK\n";

