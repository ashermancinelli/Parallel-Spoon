#!perl
use strict;
use warnings;
use v5.10;

use Test::More tests => 2;
use Test::Exception;

use Parallel::Spoon;

throws_ok { Parallel::Spoon::call(sub {}, -1); } qr/n <= 0 doesn't make any sense!/;

throws_ok {
  Parallel::Spoon::reduce(sub {}, 'Oops');
} qr/requires a list of integers/;

done_testing;
