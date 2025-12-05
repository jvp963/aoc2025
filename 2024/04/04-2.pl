#!/usr/bin/perl

use strict;
use warnings;

my @words = (
    ['X','M','A','S']
);
my @directions = (
    [1,0],  # down
    [-1,0], # up
    [0,1],  # right
    [0,-1], # left
    [1,1],  # diagonal right down
    [1,-1], # diagonal right up
    [-1,1],  # diagonal left down
    [-1,-1], # diagonal left up
);
my @puzzle = ( );
my $numrows = 0;
my $numcols = 0;
my $count = 0;
while (<>) {
    chomp;
    next unless /[^\s]/;
    my(@letters) = split("", $_);
    $numcols = @letters;
    $puzzle[$numrows] = \@letters;
    $numrows++;
}

foreach my $row (0..$numrows-1) {
    foreach my $col (0..$numcols-1) {
        # skip out of bounds
        next if $row+2 >= $numrows || $col+2 >= $numcols;

        # middle will alway be "A"
        next unless $puzzle[$row+1][$col+1] eq 'A';

        next unless (my $tl = $puzzle[$row][$col]) =~ /^[MS]$/;
        next unless (my $tr = $puzzle[$row][$col+2]) =~ /^[MS]$/;
        next unless (my $bl = $puzzle[$row+2][$col]) =~ /^[MS]$/;
        next unless (my $br = $puzzle[$row+2][$col+2]) =~ /^[MS]$/;

        if ($tl eq 'M') {
            next unless $br eq 'S';
            if ($tr eq 'M') {
                next unless $bl eq 'S';
            } else {
                next unless $bl eq 'M';
            }
        } else {
            next unless $br eq 'M';
            if ($tr eq 'M') {
                next unless $bl eq 'S';
            } else {
                next unless $bl eq 'M';
            }
        }
        $count++;
    }
}
print "$count x-mas found!\n";