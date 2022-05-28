# Test with:  prove Mtrx.t
use strict;
use Test::Simple tests => 3;
use lib './';
require Mtrx;

my $ncols = 3;
my $nrows = 3;
my $a = Mtrx::New($nrows, $ncols);
Mtrx::SetValue($a, 0, 0, 1); Mtrx::SetValue($a, 0, 1, 1); Mtrx::SetValue($a, 0, 2, 1);
Mtrx::SetValue($a, 1, 0, 2); Mtrx::SetValue($a, 1, 1, 3); Mtrx::SetValue($a, 1, 2, 4);
Mtrx::SetValue($a, 2, 0, 2); Mtrx::SetValue($a, 2, 1, 1); Mtrx::SetValue($a, 2, 2, 2);



# Add tests here.  Update the count of tests above.
ok(defined($a) && $a->{'nrows'} == $nrows && $a->{'ncols'} == $ncols, 'Mtrx::New works');
ok(Mtrx::GetColCount($a) == $ncols, 'Mtrx::GetColCount works');
ok(Mtrx::GetRowCount($a) == $nrows, 'Mtrx::GetRowCount works');
ok(Mtrx::GetValue($a, 0, 0) == 1, 'Mtrx::[Get|Set]Value work');


