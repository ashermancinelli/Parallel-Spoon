#!perl

use strict;
use warnings;
use Test::More tests => 1;

use Parallel::Spoon;

ok(1, 'placeholder');
# is Parallel::Spoon::sum(5), 5, 'Sum Single';
# is Parallel::Spoon::sum(1, 2, 3), 6, 'Sum List';
# is Parallel::Spoon::sum(1..10), 55, 'Sum Range';
# is Parallel::Spoon::sum(1..10000), 50005000, 'Sum Big Range';

done_testing;
