use strict;
use lib './';
use Matrix;

my $nCols = 3;
my $nRows = 3;
my $mtrx = Matrix->new($nRows, $nCols);

# Initialize the matrix:
$mtrx->setValue(0, 0, 0); $mtrx->setValue(0, 1, 1); $mtrx->setValue(0, 2, 2);
$mtrx->setValue(1, 0, 1); $mtrx->setValue(1, 1, 3); $mtrx->setValue(1, 2, 1);
$mtrx->setValue(2, 0, 2); $mtrx->setValue(2, 1, 2); $mtrx->setValue(2, 2, 2);

# Initialize a B matrix (AX=B).
my $b = Matrix->new($nRows, 1);
$b->setValue(0, 0, 25);
$b->setValue(1, 0, 26);
$b->setValue(2, 0, 32);

my $x = $mtrx->solve($b);
my $p = $x->getValue(0, 0);
my $n = $x->getValue(1, 0);
my $d = $x->getValue(2, 0);
printf "solution:  ($p, $n, $d) \n";
my $msg = $mtrx->toString();
print "\n$msg\n";

my $det = $mtrx->getDeterminant();
print("Determinant: $det\n");

