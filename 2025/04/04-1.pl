#!/usr/bin/perl

use strict;
use warnings;

my @grid = ( );
my $size_x = 0;
my $size_y = 0;
while (<>) {
	chomp;
	push @grid, [split(//, $_)];
	$size_x = scalar @{$grid[$size_y]} unless $size_x;
	$size_y++;
}

my $count = 0;
foreach my $x (0..$size_x-1) {
	foreach my $y (0..$size_x-1) {
		print "Adjacent count at $x, $y = " . adjacent($x, $y), "\n";
		$count++ if adjacent($x, $y) < 4;
	}
}

print "Count = $count\n";

sub adjacent() {
	my $x = shift;
	my $y = shift;

	my $count = 0;
	foreach my $x_adj (-1, 0, 0) {
		foreach my $y_adj (-1, 0, 0) {
			next if $x_adj == 0 && $y_adj == 0;
			my $x_check = $x + $x_adj;
			my $y_check = $y + $y_adj;
			next if $x_check < 0;
			next if $x_check >= $size_x;
			next if $y_check < 0;
			next if $y_check >= $size_y;
			$count++ if $grid[$x_check][$y_check] eq "@";
		}
	}
	return $count;
}

