# Test with:  prove Matrix.t
use Test::Simple tests => 9;
use lib './';
use Matrix;

my $nCols = 3;
my $nRows = 3;
my $mtrx = Matrix->new($nRows, $nCols);
my $row = 0;
my $col = 0;
my @left = (0, 10, 20);
my @right = (2, 12, 22);
my @tooMany = (2, 4, 6, 8);

# Initialize the matrix:
for ($row = 0; $row < $nRows; $row++) {
  for ($col = 0; $col < $nCols; $col++) {
    $mtrx->setValue($row, $col, ($row * 10) + $col);
  }
}

ok(defined($mtrx) && ref $mtrx eq 'Matrix', 'new() works');
ok($mtrx->getRowCount() == $nRows, 'Row count is correct');
ok($mtrx->getColCount == $nCols, 'Column count is correct');
ok($mtrx->getValue(0,0) == 0, 'First loaded value is correct');
ok($mtrx->getValue(2,2) == 22, 'Final loaded value is correct');
ok($mtrx->getColumn(0) == @left, 'Get left column values');
ok($mtrx->getColumn(2) == @right, 'Get right column values');
ok($mtrx->setColumn(2, @tooMuch) != 0, 'Add too many values to a column fails');
ok($mtrx->setColumn(0, @right) == 0, 'Add correct amount of values to a column succeeds');

