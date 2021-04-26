#!perl
use strict;
use warnings;
use v5.10;
use Test::More tests => 1;

use Parallel::Spoon;

is_deeply(Parallel::Spoon::map(sub {}, 1, 2, 3), [1, 2, 3], 'map dummy');

done_testing;
