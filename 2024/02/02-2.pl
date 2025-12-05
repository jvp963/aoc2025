#!/usr/bin/perl

use strict;
use warnings;

my $count_safe = 0;
while (<>) {
    chomp;
    my @nums = split(/\s+/, $_);
    my $safe = check(@nums);
    unless ($safe) {
        foreach my $index (0..$#nums) {
            my @test = @nums;
            splice(@test, $index, 1);
            $safe = check(@test);
            last if $safe;
        }
    }
    $count_safe++ if $safe;
}
print "Found $count_safe rows\n";

sub check {
    my @nums = @_;
    my $safe = 1;
    my $prev = shift @nums;
    my $increasing = 0;
    my $decreasing = 0;
    foreach my $num (@nums) {
        my $diff = $num - $prev;
        if ($diff < 0) {
            if ($increasing) {
                $safe = 0;
                last;
            }
            if ($diff < -3) {
                $safe = 0;
                last;
            }
            $decreasing = 1;
        }
        if ($diff > 0) {
            if ($decreasing) {
                $safe = 0;
                last;
            }
            if ($diff > 3) {
                $safe = 0;
                last;
            }
            $increasing = 1;
        }
        if ($diff == 0) {
            $safe = 0;
            last;
        }
        $prev = $num;
    }
    return $safe;
}