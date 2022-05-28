package Mtrx;  # Funtional implementation (non-OO) of a matrix.

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
  my $i = getIndex($mtrx, $row, $col);
  my $ra = $mtrx->{'radata'};
  my $val = @$ra[$i];
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
  my $i = getIndex($mtrx. $row, $col);
  my $ra = $mtrx->{'radata'};
  $ra->[$i] = $val;

}

sub getIndex() {
  my ($mtrx, $row, $col) = @_;
  my $ncols = %$mtrx{'ncols'};
  my $idx = ($row * $ncols) + $col;

  return $idx;
}


1; # Required by module loader
