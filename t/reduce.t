#!perl
use strict;
use warnings;
use v5.10;
use Test::More tests => 4;

use Parallel::Spoon;

# Sum
is(
  Parallel::Spoon::reduce(Parallel::Spoon::REDUCE_SUM, 3),
  3, 'Reduce sum single value');
is(
  Parallel::Spoon::reduce(Parallel::Spoon::REDUCE_SUM, 1, 2, 3),
  6, 'Reduce sum multi value');

# Adjascent difference
is(
  Parallel::Spoon::reduce(Parallel::Spoon::REDUCE_ADJ_DIFF, 3),
  3, 'Reduce adjascent difference single value');
is(
  Parallel::Spoon::reduce(Parallel::Spoon::REDUCE_ADJ_DIFF, 5, 2, 2),
  1, 'Reduce adjascent difference multi value');

done_testing;
