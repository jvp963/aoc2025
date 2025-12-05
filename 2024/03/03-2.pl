#!/usr/bin/perl

use strict;
use warnings;

my $total = 0;
my @all_instr = ();
while (<>) {
    chomp;
    my @instr = $_ =~ /(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don\'t\(\))/g;
    push @all_instr, @instr;
}
my $doing = 1;
foreach my $val (@all_instr) {
    next unless $val;
    if ($val eq 'do()') {
        $doing = 1;
    } elsif ($val eq 'don\'t()') {
        $doing = 0;
    } else {
        if ($doing) {
            print "$val\n";
            if ($val =~ /mul\((\d{1,3}),(\d{1,3})\)/) {
                $total += $1*$2;
            }
        }
    }
}
print "Total = $total\n";