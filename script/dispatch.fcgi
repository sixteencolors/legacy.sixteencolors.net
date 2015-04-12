#!/usr/bin/perl -w

use lib '../../perl5/lib/perl5';
require local::lib;
local::lib->import( '../../perl5' );

do 'sixteencolors_fastcgi.pl';
