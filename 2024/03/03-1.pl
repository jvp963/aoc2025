#!/usr/bin/perl

use strict;
use warnings;

my $total = 0;
while (<>) {
    chomp;
    my @mul = $_ =~ /mul\(\d{1,3},\d{1,3}\)/g;
    foreach my $val (@mul) {
        $val =~ /mul\((\d{1,3}),(\d{1,3})\)/g;
        $total += $1*$2;
    }
}
print "Total = $total\n";