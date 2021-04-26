#!perl
use strict;
use warnings;
use v5.10;

use Test::More tests => 3;
use Test::Exception;

use Parallel::Spoon;

throws_ok(sub {
    Parallel::Spoon::call(sub {}, -1);
  }, qr/n <= 0 doesn't make any sense/, 'bad nthreads throws');

throws_ok(sub {
    Parallel::Spoon::reduce(Parallel::Spoon::REDUCE_SUM, 'Oops');
  }, qr/requires a list of integers/, 'bad reduce list throws');

throws_ok(sub { Parallel::Spoon::reduce(-1, 1); },
  qr/invalid reducer with value/, 'bad reducer throws');

done_testing;
