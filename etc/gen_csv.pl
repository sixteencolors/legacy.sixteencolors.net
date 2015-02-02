#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';

use SixteenColors;

my $c     = 'SixteenColors';
my $rs    = $c->model( 'DB::Pack' );

print '"year","pack","file","artist","group","sauce_artist","sauce_group"', "\n";
while (my $pack = $rs->next) {
  my $f_rs = $pack->files;
  my @row = ( $pack->year, $pack->filename );
  while(my $file = $f_rs->next) {
      my $s = $file->sauce;
      my @out = @row;
      push @out, $file->file_path, '', '', ($s ? $s->author : ''), ($s ? $s->group : '');
      print '"' . join( '","', @out ) . '"' . "\n";
  }
}
