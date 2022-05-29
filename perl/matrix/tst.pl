use strict;

use lib './';
require Mtrx;


my $ncols = 3;
my $nrows = 3;
my $a = Mtrx::New($nrows, $ncols);
Mtrx::SetValue($a, 0, 0, 0); Mtrx::SetValue($a, 0, 1, 1); Mtrx::SetValue($a, 0, 2, 2);
Mtrx::SetValue($a, 1, 0, 1); Mtrx::SetValue($a, 1, 1, 3); Mtrx::SetValue($a, 1, 2, 1);
Mtrx::SetValue($a, 2, 0, 2); Mtrx::SetValue($a, 2, 1, 2); Mtrx::SetValue($a, 2, 2, 2);

my $b = Mtrx::New($nrows, 1);
Mtrx::SetValue($b, 0, 0, 25);
Mtrx::SetValue($b, 1, 0, 26);
Mtrx::SetValue($b, 2, 0, 32);

# Solve $a$x = $b
my $x = Mtrx::Solve($a, $b);

my $msg = Mtrx::ToString($a); print $msg;
$msg = Mtrx::ToString($b); print $msg;
$msg = Mtrx::ToString($x); print $msg;

# my $det = Mtrx::GetDeterminant($a);
# print "Determinant: $det\n";

