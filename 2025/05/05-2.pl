#!/usr/bin/perl

use strict;
use warnings;

# takes a list of ranges and combines where possible. Note: this just does one pass
sub consolidate_ranges {
	my $range_ref = shift;
	my @ranges = @{$range_ref};

	# we need to consolidate the ranges since they can overlap
	my @consolidated_ranges = ( );
	foreach my $range (@ranges) {
		my($start, $end) = @{$range};
		my $interacted_with_another_range = 0;
		foreach my $consolidated_range (@consolidated_ranges) {
			my($test_start, $test_end) = @{$consolidated_range};
			# there are 5 options for how this range might interact with another range
	
			if ($start < $test_start && $end >= $test_start-1 && $end <= $test_end) {
				# option 1: extends it to the left
				@{$consolidated_range}[0] = $start;
				$interacted_with_another_range = 1;
				last;
			} elsif ($end > $test_end && $start <= $test_end + 1 && $start >= $test_start) {
				# option 2: extends it to the right
				@{$consolidated_range}[1] = $end;
				$interacted_with_another_range = 1;
				last;
			} elsif ($start < $test_start && $end > $test_end) {
				# option 3: extends it to the left and right
				@{$consolidated_range}[0] = $start;
				@{$consolidated_range}[1] = $end;
				$interacted_with_another_range = 1;
				last;
			} elsif ($start >= $test_start && $end <= $test_end) {
				# option 4: is already inside of another range
				$interacted_with_another_range = 1;
				last;
			}
			# option 5: is a distinct range - do nothing
	
		}
		unless ($interacted_with_another_range) {
			push @consolidated_ranges, [ $start, $end ];
		}
	}

	return @consolidated_ranges;
}

# read input
my @ranges = ( );
while (<>) {
	chomp;
	# stop once we don't have a range definition
	last unless /^(\d+)-(\d+)$/;
	push @ranges, [ $1, $2 ];
}

# consolidate ranges - multiple passes may be needed, so continue doing
# consolidations until the output ranges are the same as the input
my $need_more_consolidation = 1;
while ($need_more_consolidation) {
	my @consolidated_ranges = consolidate_ranges(\@ranges);
	if (scalar @consolidated_ranges == scalar @ranges) {
		$need_more_consolidation = 0;
	}
	@ranges = @consolidated_ranges;
}

# count up the number of ingredients represented in the ranges
my $total_good_count = 0;
foreach my $range (@ranges) {
	my($start, $end) = @{$range};
	$total_good_count += $end - $start + 1;
}

print "There are $total_good_count total possible good ingredients\n";