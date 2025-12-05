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
        push @rules, [ split(/\|/, $_) ];
    }
}

my $total = 0;
foreach my $set (@sets) {
    print "set: " . join(",", @{$set}) . "\n";

    my @relevant_rules = ( );
    foreach my $rule (@rules) {
        my $first = @{$rule}[0];
        my $second = @{$rule}[1];
        if (grep(/^$first$/, @{$set}) && grep(/^$second$/, @{$set})) {
            print " - Relevant: $first,$second\n";
        }
    }
    next;

    my $good = 1;
    foreach my $rule (@rules) {
        #print "  - rule: " . join(",", @{$rule}) . "\n";
        last unless $good;
        my $first = @{$rule}[0];
        my $second = @{$rule}[1];
        my $found_first = undef;
        my $found_second = undef;
        foreach my $counter (0..$#{$set}) {
            if (@{$set}[$counter] == $first) {
                $found_first = $counter;
            }
            if (@{$set}[$counter] == $second) {
                $found_second = $counter;
            }
        }
        if (defined $found_first && defined $found_second) {
            $good = 0 unless $found_second > $found_first;
        }
    }
    if ($good) {
        print "Good set: " . join(",", @{$set}) . "\n";
        my $middle = (scalar @{$set} + 1) / 2;
        $total += @{$set}[$middle-1];
    }
}
print "Total = $total\n";