package Mtrx;  # function-based implementation (non-OO) of a matrix.

use strict;

sub GetColCount() {
  my $mtrx = shift;
  return $mtrx->{'ncols'};
}


sub GetRowCount() {
  my $mtrx = shift;
  return $mtrx->{'nrows'};
}


sub GetDeterminant() {
  my $mtrx = shift;

  my $det = undef;

  my $nrows = &GetRowCount($mtrx);
  my $ncols = &GetColCount($mtrx);
  my $col = 0;
  my $row = 0;
  my $diag = 1;
  my $i = 0;
  my $fixed = 0;
  my $value = 0;

  if ($nrows > 0 && ($nrows == $ncols)) {
    $det = 0;
    # Calculate sum of L->R diagonals:
    for ($col = 0; $col < $ncols; $col++) {
      $diag = 1;
      for ($row = 0; $row < $nrows; $row++) {
        $fixed = &fixColumnIndex($mtrx, $col + $row);
        $value = &GetValue($mtrx, $row, $fixed);
        $diag *= $value;
      }
      $det += $diag;
    }

    # Calculate sum of R->L diagonals:
    for ($col = $ncols - 1; $col >= 0; $col--) {
      $diag = 1;
      for ($row = 0; $row < $nrows; $row++) {
        $fixed = &fixColumnIndex($mtrx, $col - $row);
        $value = &GetValue($mtrx, $row, $fixed);
        $diag *= $value;
      }
      $det -= $diag;
    }
  }

  return $det;
}


sub GetValue() {
  my ($mtrx, $row, $col) = @_;
  my $val = undef;
  if (($row >= 0) && ($col >=0) && ($row < $mtrx->{'nrows'}) && ($col < $mtrx->{'ncols'})) {
    my $i = &datumIndex($mtrx, $row, $col);
    $val = $mtrx->{'radata'}->[$i];
  }
  return $val;
}


sub IsSingular() {
  my $mtrx = shift;
  
  my $det = &GetDeterminant($mtrx);
  my $isSingular = (defined($det) && $det != 0) ? 0 : 1;

  return $isSingular;
}


sub New() {
  my ($nrows, $ncols) = @_;

  my $mtrx = {};
  $mtrx->{'nrows'} = $nrows;
  $mtrx->{'ncols'} = $ncols;
  
  my @data = ();
  for (my $i = 0; $i < $nrows * $ncols; $i++) {
    push(@data, undef);
  }

  $mtrx->{'radata'} = \@data;

  return $mtrx;
}


sub SetValue() {
  my ($mtrx, $row, $col, $val) = @_;
  my $i = &datumIndex($mtrx, $row, $col);
  $mtrx->{'radata'}->[$i] = $val;
}


sub Solve() {
  my ($a, $b) = @_;
  my $x = undef;
  if (&GetRowCount($a) != &GetColCount($a)) {
    print "Matrix a has unequal row and column count.\n";
  } elsif (&GetRowCount($a) != &GetRowCount($b)) {
    print "Matrix a and b have unequal row counts.\n";
  } elsif (&GetColCount($b) > 1) {
    print "Matrix b has more than one column.  It should only have one column.\n";
  } else {
    my $ncols = &GetColCount($a);
    my $nrows = &GetRowCount($b);
    my @bvals = ();
    my @prev = ();
    my $col = undef;
    my $i = 0;
    my $row = undef;

    # Capture b values in a list for easy exchange:
    for ($row = 0; $row < $nrows; $row++) {
      push(@bvals, &GetValue($b, $row, 0));
    }

    my $denom = &GetDeterminant($a);
    my @dets = ();
    my $det = undef;

    # Calculate the determinants of matrices with substituted columns:
    for ($col = 0; $col < $ncols; $col++) {
      # Get the current column values:
      @prev = &getColumnContent($a, $col);
      # Substitute the b values in the a column:
      &setColumnContent($a, $col, @bvals);
      # Get the determinant and store it:
      $det = &GetDeterminant($a);
      push(@dets, $det);
      # Restore the column values:
      &setColumnContent($a, $col, @prev);
    }
    
    # Store solution value in $x matrix:
    $x = &New($nrows, 1);
    my $value = undef;
    for ($row = 0; $row < $nrows; $row++) {
      $value = $dets[$row] / $denom;
      &SetValue($x, $row, 0, $value);
    }
 }

 return $x;
}


sub ToString() {
  my $mtrx = shift;

  my $msg = undef;
  my $nrows = &GetRowCount($mtrx);
  my $ncols = &GetColCount($mtrx);
  my $row = 0;
  my $col = 0;
  my $value = 0;
  
  for ($row = 0; $row < $nrows; $row++) {
    for ($col = 0; $col < $ncols; $col++) {
      $value = &GetValue($mtrx, $row, $col);
      $msg .= "\t$value";
    }
    $msg .= "\n";
  }

  return $msg;
}


sub datumIndex() {
  my ($mtrx, $row, $col) = @_;
  my $ncols = $mtrx->{'ncols'};
  my $idx = ($row * $ncols) + $col;

  return $idx;
}


sub fixColumnIndex() {
  my ($mtrx, $index) = @_;
  my $ncols = $mtrx->{'ncols'};
  my $fixed = $index;

  while ($fixed >= $ncols) {
    $fixed -= $ncols;
  }
  while ($fixed < 0) {
    $fixed += $ncols;
  }

  return $fixed;
}


sub getColumnContent() {
  my ($mtrx, $col) = @_;
  my @values = ();
  my $value = undef;
  my $rowCount = $mtrx->{'nrows'};
  my $i = undef;

  for (my $row = 0; $row < $rowCount; $row++) {
    $i = &datumIndex($mtrx, $row, $col);

    $value = $mtrx->{'radata'}->[$i];
    push(@values, $value);
  }
  return @values;
}
  

sub setColumnContent() {
  my ($mtrx, $col, @values) = @_;
  my $failure = 0;
  my $i = 0;
  my $nRows = $mtrx->{'nrows'};
  if ($nRows == scalar(@values)) {
    for (my $row = 0; $row < $nRows; $row++) {
      $i = &datumIndex($mtrx, $row, $col);
      $mtrx->{'radata'}->[$i] = $values[$row];
    }
  } else {
    $failure = 1;
  }

  return $failure;
}



1; # Required by module loader
