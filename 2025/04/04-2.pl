#!/usr/bin/perl

use strict;
use warnings;


## global variables. Yes, I know.
my @grid = ( );
my $size_x = 0;
my $size_y = 0;

sub adjacent_count {
	my $x = shift;
	my $y = shift;

	my $count = 0;

	foreach my $x_adj (-1, 0, 1) {
		foreach my $y_adj (-1, 0, 1) {
			## skip myself
			next if $x_adj == 0 && $y_adj == 0;

			## skip if off grid
			my $x_check = $x + $x_adj;
			my $y_check = $y + $y_adj;
			next if $x_check < 0 || $x_check >= $size_x;
			next if $y_check < 0 || $y_check >= $size_y;

			## increment if there is roll of paper in this coordinate
			$count++ if $grid[$x_check][$y_check] eq "@";
		}
	}
	return $count;
}

## read input
while (<>) {
	chomp;
	push @grid, [split(//, $_)];
	$size_x = scalar @{$grid[$size_y]} unless $size_x;
	$size_y++;
}

my $count = 0;
my @accessible = ( );

## will do multiple rounds to find accessible rolls, remove them, and then
## repeat until no more rolls are accessible
do {
	@accessible = ( );
	foreach my $x (0..$size_x-1) {
		foreach my $y (0..$size_x-1) {
			if ($grid[$x][$y] eq "@" && adjacent_count($x, $y) < 4) {
				push @accessible, [$x, $y];
				$count++;
			}
		}
	}
	foreach (@accessible) {
		my($remove_x, $remove_y) = @{$_};
		$grid[$remove_x][$remove_y] = ".";
	}
} until (scalar @accessible == 0);

print "Count = $count total rolls of paper can be accessed by the forklift after removing some\n";