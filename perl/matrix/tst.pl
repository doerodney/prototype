use strict;

use lib './';
require Mtrx;

my $ncols = 3;
my $nrows = 3;
my $mtrx = Mtrx::New($nrows, $ncols);

my $val = Mtrx::GetColCount($mtrx);
print $val;


