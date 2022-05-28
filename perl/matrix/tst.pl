use strict;

use lib './';
require Mtrx;


my $ncols = 3;
my $nrows = 3;
my $a = Mtrx::New($nrows, $ncols);
Mtrx::SetValue($a, 0, 0, 1); Mtrx::SetValue($a, 0, 1, 1); Mtrx::SetValue($a, 0, 2, 1);
Mtrx::SetValue($a, 1, 0, 2); Mtrx::SetValue($a, 1, 1, 3); Mtrx::SetValue($a, 1, 2, 4);
Mtrx::SetValue($a, 2, 0, 2); Mtrx::SetValue($a, 2, 1, 1); Mtrx::SetValue($a, 2, 2, 2);

my @content = Mtrx::getColumnContent($a, 0);
print @content;



