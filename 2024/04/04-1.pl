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
        foreach my $wordindex (0..$#words) {
            if ($puzzle[$row][$col] eq $words[$wordindex][0]) {
                $count += evaluate($wordindex, $row, $col);
            }
        }
    }
}
print "$count words found!\n";

sub evaluate {
    my $wordindex = shift;
    my $row = shift;
    my $col = shift;

    my @letters = @{$words[$wordindex]};
    my $place = 0;
    my $found = 0;
    foreach (@directions) {
        my $row_place = $row;
        my $col_place = $col;
        my $row_adj = $_->[0];
        my $col_adj = $_->[1];
        my @needed = @letters;
        shift @needed;
        while (scalar @needed) {
            $row_place += $row_adj;
            $col_place += $col_adj;
            last if $row_place < 0 || $col_place < 0 || $row_place >= $numrows || $col_place >= $numcols;
            last if $puzzle[$row_place][$col_place] ne $needed[0];
            shift @needed;
        }
        $found++ unless scalar @needed;
    }
    return $found;
}