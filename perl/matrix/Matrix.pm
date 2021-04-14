package Matrix;

use strict;

sub new () {
  my ($class, $nrows, $ncols) = @_;
  my $self = {};
  bless $self, $class;

  $self->{'nrows'} =  $nrows;
  $self->{'ncols'} = $ncols;
  my @data = ();
  for (my $i = 0; $i < $nrows * $ncols; $i++) {
    push(@data, undef);
  }

  $self->{'radata'} = \@data; 

  return $self;
}

sub getRowCount() {
  my $self = shift;
  return $self->{'nrows'};
}

sub getColCount() {
  my $self = shift;
  return $self->{'ncols'};
}

sub getColumn() {
  my ($self, $column) = @_;
  my @values = ();
  my $value = undef;
  my $rowCount = $self->getRowCount();
  
  for (my $row = 0; $row < $rowCount; $row++) {
    $value = $self->getValue($row, $column);
    push(@values, $value);
  }
  return @values;
}

sub getIndex() {
  my ($self, $row, $col) = @_;
  my $ncols = $self->getColCount();
  my $idx = ($row * $ncols) + $col;

  return $idx;
}

sub getValue() {
  my ($self, $row, $col) = @_;

  my $idx = $self->getIndex($row, $col);
  my $radata = $self->{'radata'};
  my $value = $radata->[$idx];
  return $value;
}

sub setColumn() {
  my ($self, $col, @values) = @_;
  my $failure = 0;
  my $nRows = $self->getRowCount();
  if ($nRows == scalar(@values)) {
    for (my $row = 0; $row < $nRows; $row++) {
      $self->setValue($row, $col, $values[$row]);
    }
  } else {
    warn "setColumn failed";
    $failure = 1;
  }

  return $failure;
}

sub setValue() {
  my ($self, $row, $col, $value) = @_;

  my $idx = $self->getIndex($row, $col);
  my $radata = $self->{'radata'};
  $radata->[$idx] = $value;
}

1;

