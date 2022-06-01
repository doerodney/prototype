# Test with:  prove Mtrx.t
use strict;
use Test::More;
use lib './';
require Mtrx;

my $ncols = 3;
my $nrows = 3;
# Create the A matrix (AX=B).
my $a = Mtrx::New($nrows, $ncols);
my $rd = $a->{'radata'};

Mtrx::SetValue($a, 0, 0, 0); Mtrx::SetValue($a, 0, 1, 1); Mtrx::SetValue($a, 0, 2, 2);
Mtrx::SetValue($a, 1, 0, 1); Mtrx::SetValue($a, 1, 1, 3); Mtrx::SetValue($a, 1, 2, 1);
Mtrx::SetValue($a, 2, 0, 2); Mtrx::SetValue($a, 2, 1, 2); Mtrx::SetValue($a, 2, 2, 2);

my @columnContent = (0, 1, 2);

# Create the B matrix:
my $b = Mtrx::New($nrows, 1);
Mtrx::SetValue($b, 0, 0, 25);
Mtrx::SetValue($b, 1, 0, 26);
Mtrx::SetValue($b, 2, 0, 32);

# Solve $a$x = $b
my $x = Mtrx::Solve($a, $b);

# Create a singular matrix:
my $s = Mtrx::New($nrows, $ncols);
Mtrx::SetValue($s, 0, 0, 0); Mtrx::SetValue($s, 0, 1, 0); Mtrx::SetValue($s, 0, 2, 0);
Mtrx::SetValue($s, 1, 0, 1); Mtrx::SetValue($s, 1, 1, 1); Mtrx::SetValue($s, 1, 2, 1);
Mtrx::SetValue($s, 2, 0, 2); Mtrx::SetValue($s, 2, 1, 2); Mtrx::SetValue($s, 2, 2, 2);



# Add tests here.  Update the count of tests above.
ok(defined($a) && $a->{'nrows'} == $nrows && $a->{'ncols'} == $ncols, 'matrix construction');
ok(scalar(@$rd) == $nrows * $ncols, 'matrix data has correct size');  
ok(Mtrx::GetColCount($a) == $ncols, 'get column count');
ok(Mtrx::GetRowCount($a) == $nrows, 'get row count');

ok(Mtrx::IsSingular($s), 'identify singular matrix');
ok(!Mtrx::IsSingular($a), 'identify non-singular matrix');


ok(Mtrx::GetValue($a, 0, 0) == 0, 'get value at start of matrix data');
ok(Mtrx::GetValue($a, 2, 2) == 2, 'get value at end of matrix data');
ok(Mtrx::getColumnContent($a, 0) == @columnContent, 'get contents of a matrix column');

ok(Mtrx::GetDeterminant($a) == -8, 'get determinant of matrix');
ok(Mtrx::GetValue($x, 0, 0) == 1, 'validate x row 0'); 
ok(Mtrx::GetValue($x, 1, 0) == 5, 'validate x row 1');  
ok(Mtrx::GetValue($x, 2, 0) == 10, 'validate x row 2');

done_testing();
