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

  my $nrows = $mtrx->{'nrows'};
  my $ncols = $mtrx->{'ncols'};
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
        $i = &datumIndex($mtrx, $row, $fixed);
        $value = $mtrx->{'radata'}->[$i];
        $diag *= $value;
      }
      $det += $diag;
    }

    # Calculate sum of R->L diagonals:
    for ($col = $ncols - 1; $col >= 0; $col--) {
      $diag = 1;
      for ($row = 0; $row < $nrows; $row++) {
        $fixed = &fixColumnIndex($mtrx, $col - $row);
        $i = &datumIndex($mtrx, $row, $fixed);
        $value = $mtrx->{'radata'}->[$i];
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


sub New() {
  my ($nrows, $ncols) = @_;

  my $self = {};
  $self->{'nrows'} = $nrows;
  $self->{'ncols'} = $ncols;
  
  my @data = ();
  for (my $i = 0; $i < $nrows * $ncols; $i++) {
    push(@data, undef);
  }

  $self->{'radata'} = \@data;

  return $self;
}


sub SetValue() {
  my ($mtrx, $row, $col, $val) = @_;
  my $i = &datumIndex($mtrx, $row, $col);
  $mtrx->{'radata'}->[$i] = $val;
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
