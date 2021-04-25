use v5.30;
use ExtUtils::MakeMaker 7.12;
WriteMakefile(
  NAME           => 'Parallel::Spoon',
  VERSION_FROM   => 'lib/Parallel/Spoon.pm',
  PREREQ_PM      => { 'ExtUtils::MakeMaker' => '7.12' },
  ABSTRACT_FROM  => 'lib/Parallel/Spoon.pm',
  TEST_REQUIRES  => { 'Test::More' => 0 },
  AUTHOR         => 'Asher Mancinelli',
  CCFLAGS        => '-Wall -Wextra -std=c99 -Xpreprocessor -fopenmp',
  OPTIMIZE       => '-O3',
  LICENSE        => 'freebsd',
  XSMULTI        => 1,
);
