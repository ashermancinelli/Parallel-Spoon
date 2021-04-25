package Parallel::Spoon;

use strict;
use warnings;

our $VERSION = 0.01;

require XSLoader;
XSLoader::load('Parallel::Spoon', $VERSION);

1;

__END__

=head1 NAME

Parallel::Spoon - Parallelism abstractions using the C<fork> system call.

=cut
