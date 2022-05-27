#!/usr/local/bin/perl
# Converts epoch timestamps to human-readable UTC timestamps.
# Copy this script to /usr/local/bin/, and chmod +x it.
# Usage: k logs <pod> -n <namespace> | tsfix
use strict;

my $line = undef;

foreach $line (<STDIN>) {
   # Find lines that start with an epoch timestamp i.e., 1.6503132662672734e+09:
   if ($line =~ /^.+e\+\d+/) {
    # Split the line on whitespace into tokens:	   
    my @tokens = split /\s+/, $line;
    # Calculate GMT/UTC from the epoch:
    my $epoch = $tokens[0];
    my $gmt = gmtime($epoch);
    # Substitute the UTC timestamp for the epoch: 
    substr($line, 0, length($epoch), "$gmt UTC");
  }
  # Standardize whitespace in the line:
  $line =~ s/\s+/ /g;
  print "$line\n";

}
