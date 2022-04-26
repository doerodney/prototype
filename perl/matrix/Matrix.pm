package Matrix v0.0.1;

use strict;

sub moo() {
  print "moo\n";
}

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

sub fixColumnIndex() {
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

sub getColumnContent() {
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
        $fixed = $self->fixColumnIndex($col + $row);
        $value = $self->getValue($row, $fixed);
        $diag *= $value;
      }
      $det += $diag;
    }

    # Calculate det of R->L diagonals:
    for ($col = $ncols - 1; $col >= 0; $col--) {
      $diag = 1;
      for ($row = 0; $row < $nrows; $row++) {
        $fixed = $self->fixColumnIndex($col - $row);
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

sub isSingular() {
  my $self = shift;
  
  my $det = $self->getDeterminant();
  my $isSingular = (defined($det) && $det != 0) ? 0 : 1;

  return $isSingular;
}

sub setColumnContent() {
  my ($self, $col, @values) = @_;
  my $failure = 0;
  my $nRows = $self->getRowCount();
  if ($nRows == scalar(@values)) {
    for (my $row = 0; $row < $nRows; $row++) {
      $self->setValue($row, $col, $values[$row]);
    }
  } else {
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

# Solves AX=B system of equations:
# a (self) is an NxN matrix object.
# b is an NX1 matrix object.
# x is returned as an Nx1 matrix or undef if something is wrong.
sub solve() {
  my ($self, $b) = @_;
  my $x = undef;
  if ($self->getRowCount() != $self->getColCount()) {
    print "Matrix a has unequal row and column count.\n";
  } elsif ($self->getRowCount() != $b->getRowCount()) {
    print "Matrix a and b have unequal row counts.\n";
  } elsif ($b->getColCount() > 1) {
    print "Matrix b has more than one column.  What the hell are you doing?\n";
  } else {
    my $ncols = $self->getColCount();
    my $nrows = $b->getRowCount();
    my @bvals = ();
    my @prev = ();
    my $col = undef;
    my $row = undef;

    # Capture b values in a list for easy exchange:
    for ($row = 0; $row < $nrows; $row++) {
      push(@bvals, $b->getValue($row, 0));
    }

    my $denom = $self->getDeterminant();
    my @dets = ();
    my $det = undef;

    # Calculate the determinants of matrices with substituted columns:
    for ($col = 0; $col < $ncols; $col++) {
      # Get the current column values:
      @prev = $self->getColumnContent($col);
      # Substitute the b values in the a column:
      $self->setColumnContent($col, @bvals);
      # Get the determinant and store it:
      $det = $self->getDeterminant();
      push(@dets, $det);
      # Restore the column values:
      $self->setColumnContent($col, @prev);
    }
    
    $x = Matrix->new($nrows, 1);
    for ($row = 0; $row < $nrows; $row++) {
      $x->setValue($row, 0, $dets[$row] / $denom);
    }
 }

  return $x;
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

