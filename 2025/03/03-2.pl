#!/usr/bin/perl

use strict;
use warnings;

# read input
my $banks = [ ];
while (<>) {
	chomp;
	push @{$banks}, [ split(//, $_) ];
}

my $total_joltage = 0;
foreach my $bank (@{$banks}) {
	my $batteries_remaining = 12;

	my $first_possible_position = 0;
	my $on_string = "";
	while ($batteries_remaining) {
		my $digit = 0;
		my $digit_pos = undef;
		foreach my $position ($first_possible_position .. $#{$bank}-$batteries_remaining+1) {
			if (@{$bank}[$position] > $digit) {
				$digit = @{$bank}[$position];
				$digit_pos = $position;
			}
		}
		$on_string .= $digit;
		$first_possible_position = $digit_pos+1;
		$batteries_remaining--;
	}

	my $bank_joltage = int($on_string);
	$total_joltage += $bank_joltage;
}

print "$total_joltage\n";