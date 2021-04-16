# Creates a word count of words in a document, sorted by descending count.
use strict;
my %wordcount;

# Open a file to use for word count:
my $src = 'resume_rod_doe.md';
my $fh = undef;
open $fh, '<', $src or die "Cannot open $src\n";

# Read all lines into a list:
my @lines = <$fh>;
close($fh);

my $line = undef;

# Iterate through list of lines:
foreach $line (@lines) {
  # Split line on white space:
  my @tokens = split '\s+', $line;
  my $token = undef;
  # Update count of each word in wordcount hash:
  foreach $token (@tokens) {
    $wordcount{lc($token)}++;
  }
}

my $key = undef;
# Create list of keys sorted by descending word count:
my @sorted_keys = reverse(sort { $wordcount{$a} <=> $wordcount{$b} } keys %wordcount);
foreach $key (@sorted_keys) {
  print("$key: $wordcount{$key}\n");
}
