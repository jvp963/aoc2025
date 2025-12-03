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
	my $first_digit = 0;
	my $first_digit_pos = undef;
	## note: last battery in the bank can't be used for the first digit
	foreach my $position (0..$#{$bank}-1) {
		if (@{$bank}[$position] > $first_digit) {
			$first_digit = @{$bank}[$position];
			$first_digit_pos = $position;
		}
	}
	my $second_digit = 0;
	my $second_digit_pos = undef;
	foreach my $position ($first_digit_pos+1 ..$#{$bank}) {
		if (@{$bank}[$position] > $second_digit) {
			$second_digit = @{$bank}[$position];
			$second_digit_pos = $position;
		}
	}
	my $bank_joltage = int("${first_digit}${second_digit}");
	$total_joltage += $bank_joltage;
}



print "$total_joltage\n";