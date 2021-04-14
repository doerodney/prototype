use strict;
my %wordcount;

my $src = 'resume_rod_doe.md';
open SRC, $src or die "Cannot open $src\n";
my @lines = <SRC>;
close(SRC);

my $line = undef;

foreach $line (@lines) {
  my @tokens = split '\s+', $line;
  my $token = undef;
  foreach $token (@tokens) {
    $wordcount{lc($token)}++;
  }
}

my $key = undef;
foreach $key (reverse(sort { $wordcount{$a} <=> $wordcount{$b}} keys %wordcount )) {
  print("$key: $wordcount{$key}\n");
}
