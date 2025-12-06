#!/usr/bin/perl

use strict;
use warnings;

# read input
my @rules = ( );
my @sets =( );
my $on_sets = 0;
while (<>) {
    chomp;
    if ($_ !~ /\d/) {
        $on_sets = 1;
        next;
    }
    if ($on_sets) {
        push @sets, [ split(/,/, $_) ];
    } else {
        push @rules, $_;
    }
}

my $total = 0;
foreach my $s (@sets) {
    my @set = @{$s};
    my $flipped_any_this_pass = 0;
    my $this_set_was_out_of_order = 0;
    # walk through the set, flipping any out of order page groupings.
    # Do this repeatedly until there is nothing to flip
    do {
        $flipped_any_this_pass = 0;
        foreach my $index (0.. $#set - 1) {
            my $first = $set[$index];
            my $second = $set[$index+1];
            if (grep(/^$second\|$first$/, @rules)) {
                # these pages are out of order. Flip them.
                my $temp = $set[$index+1];
                $set[$index+1] = $set[$index];
                $set[$index] = $temp;
                $flipped_any_this_pass = 1;
                $this_set_was_out_of_order = 1;
            }
        }
    } until $flipped_any_this_pass == 0;

    if ($this_set_was_out_of_order) {
        my $middle = (scalar @set + 1) / 2;
        $total += $set[$middle-1];
    }
}

print "Total = $total\n";