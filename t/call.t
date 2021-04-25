#!perl
use strict;
use warnings;
use v5.10;
use Test::More tests => 15;

use Parallel::Spoon;

# Run by invoking with the name
sub do { `touch file$_[0].tmp`; };
Parallel::Spoon::call("do", 5);
sleep 1; # Spoon does not wait on children, so we might have to sleep
for (0..4) {
  ok(1, "File check $_") if (-e "file$_.tmp");
}
`rm file$_.tmp` for 0..4;

# Invoke sub ref
Parallel::Spoon::call(\&do, 5);
sleep 1; # Spoon does not wait on children, so we might have to sleep
for (0..4) {
  ok(1, "File check $_") if (-e "file$_.tmp");
}
`rm file$_.tmp` for 0..4;

# Invoke with anon sub
Parallel::Spoon::call(sub {
    `touch file$_[0].tmp`;
  }, 5);
sleep 1;
for (0..4) {
  ok(1, "File check $_") if (-e "file$_.tmp");
}
`rm file$_.tmp` for 0..4;
