# Test with:  prove Matrix.t
use strict;
use Test::Simple tests => 18;
use lib './';
use Matrix;

my $nCols = 3;
my $nRows = 3;
my $mtrx = Matrix->new($nRows, $nCols);
my $nonsqr = Matrix->new(3, 4);
my $row = 0;
my $col = 0;
my @left = (0, 1, 2);
my @right = (2, 1, 2);
my @tooMany = (2, 4, 6, 8);

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

# Initialize a singular matrix (determinant == 0):
my $singular = Matrix->new($nRows, $nCols);
$singular->setValue(0, 0, 0); $singular->setValue(0, 1, 0); $singular->setValue(0, 2, 0);
$singular->setValue(1, 0, 0); $singular->setValue(1, 1, 0); $singular->setValue(1, 2, 0);
$singular->setValue(2, 0, 0); $singular->setValue(2, 1, 0); $singular->setValue(2, 2, 0);


ok(defined($mtrx) && ref $mtrx eq 'Matrix', 'new() works');
ok($mtrx->getRowCount() == $nRows, 'Row count is correct');
ok($mtrx->getColCount == $nCols, 'Column count is correct');
ok($mtrx->getValue(0,0) == 0, 'First loaded value is correct');
ok($mtrx->getValue(2,2) == 2, 'Final loaded value is correct');
ok($mtrx->getColumn(0) == @left, 'Get left column values');
ok($mtrx->getColumn(2) == @right, 'Get right column values');
ok($mtrx->setColumn(2, @tooMany) != 0, 'Add too many values to a column fails');
ok($mtrx->setColumn(0, @left) == 0, 'Add correct amount of values to a column succeeds');
ok($mtrx->fixColumn(4) == 1, 'Fix too large column is correct');
ok($mtrx->fixColumn(-3) == 0, 'Fix negative column is correct');
ok(defined($nonsqr->getDeterminant()) == 0, 'Determinant of non-square matrix is undefined');
ok($mtrx->getDeterminant() == -8, '3x3 matrix determinant is correct');
ok($singular->isSingular() != 0, 'All-zero matrix is singular');
ok($mtrx->isSingular() == 0, 'Matrix with non-zero determinant is not singular');
ok($x->getValue(0, 0) == 1, 'Solution test 0');
ok($x->getValue(0, 1) == 5, 'Solution test 1');
ok($x->getValue(0, 2) == 10, 'Solution test 2');

