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

sub fixColumn() {
  my ($self, $index) = @_;
  my $ncols = $self->getColCount();
  my $fixed = $index;

  while ($fixed >= $ncols) {
    $fixed -= $ncols;
  }
  while ($fixed < 0) {
    $fixed += $ncols;
  }

  return $fixed;
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

sub getDeterminant() {
  my $self = shift;

  my $det = undef;

  my $nrows = $self->getRowCount();
  my $ncols = $self->getColCount();
  my $col = 0;
  my $row = 0;
  my $diag = 1;
  my $fixed = 0;
  my $value = 0;

  if ($nrows > 0 && ($nrows == $ncols)) {
    $det = 0;
    # Calculate sum of L->R diagonals:
    for ($col = 0; $col < $ncols; $col++) {
      $diag = 1;
      for ($row = 0; $row < $nrows; $row++) {
        $fixed = $self->fixColumn($col + $row);
        $value = $self->getValue($row, $fixed);
        $diag *= $value;
      }
      $det += $diag;
    }

    # Calculate det of R->L diagonals:
    for ($col = $ncols - 1; $col >= 0; $col--) {
      $diag = 1;
      for ($row = 0; $row < $nrows; $row++) {
        $fixed = $self->fixColumn($col - $row);
        $value = $self->getValue($row, $fixed);
        $diag *= $value;
      }
      $det -= $diag;
    }
  }

  return $det;
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

sub toString() {
  my $self = shift;

  my $msg = undef;
  my $nrows = $self->getRowCount();
  my $ncols = $self->getColCount();
  my $row = 0;
  my $col = 0;
  my $value = 0;
  
  for ($row = 0; $row < $nrows; $row++) {
    for ($col = 0; $col < $ncols; $col++) {
      $value = $self->getValue($row, $col);
      $msg .= "\t$value";
    }
    $msg .= "\n";
  }

  return $msg;
}


1;

