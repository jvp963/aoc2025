#!/usr/bin/perl

use strict;
use warnings;

# read input
my @ranges = ( );
my @ingredients = ( );
my $found_blank = 0;
while (<>) {
	chomp;
	if ($found_blank) {
		push @ingredients, $_;
	} else {
		if (/^(\d+)-(\d+)$/) {
			push @ranges, [ $1, $2 ];
		} else {
			$found_blank = 1;
		}
	}
}

# go through ingredients and check ranges
my $good_ingredient_count = 0;
foreach my $ingredient (@ingredients) {
	foreach my $range (@ranges) {
		my($start, $end) = @{$range};
		if ($ingredient >= $start && $ingredient <= $end) {
			$good_ingredient_count++;
			last;
		}
	}
}

print "There are $good_ingredient_count good ingredients\n";