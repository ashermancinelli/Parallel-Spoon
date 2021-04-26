package Parallel::Spoon;

use strict;
use warnings;

our $VERSION = 0.01;

require XSLoader;
XSLoader::load('Parallel::Spoon', $VERSION);

# \see lib/Parallel/Util.xs
use constant {
  REDUCE_SUM => 0,
  REDUCE_ADJ_DIFF => 1,
};

1;

__END__

=head1 NAME

Parallel::Spoon - Parallelism abstractions using the C<fork> system call.

=cut
