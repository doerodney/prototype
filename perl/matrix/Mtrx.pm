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


sub GetValue() {
  my ($mtrx, $row, $col) = @_;
    my $val = undef;
    if (($row >= 0) && ($col >=0) && ($row < $mtrx->{'nrows'}) && ($col < $mtrx->{'ncols'})) {
    my $i = getIndex($mtrx, $row, $col);
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
  my $i = getIndex($mtrx, $row, $col);
  $mtrx->{'radata'}->[$i] = $val;
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
    $i = getIndex($mtrx, $row, $col);

    $value = $mtrx->{'radata'}->[$i];
    push(@values, $value);
  }
  return @values;
}


sub getIndex() {
  my ($mtrx, $row, $col) = @_;
  my $ncols = $mtrx->{'ncols'};
  my $idx = ($row * $ncols) + $col;

  return $idx;
}


1; # Required by module loader
