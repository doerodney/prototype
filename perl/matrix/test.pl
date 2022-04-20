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

my $msg = $mtrx->toString();
print "\n$msg\n";

my $det = $mtrx->getDeterminant();
print("Determinant: $det\n");

