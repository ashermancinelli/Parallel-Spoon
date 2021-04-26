#define PERL_NO_GET_CONTEXT // we'll define thread context if necessary (faster)
#include "EXTERN.h"         // globals/constant import locations
#include "perl.h"           // Perl symbols, structures and constants definition
#include "XSUB.h"           // xsubpp functions and macros
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <stdint.h>

// Interface {{{
typedef enum {
  REDUCE_SUM=0,
} reduce_t;

typedef I32 (*reducer_t)(I32, I32);

static I32
reduce_sum(I32 acc, I32 other) {
  return acc + other;
}

#define CHKISINT(x) \
  if (!SvOK(ST(x)) || !SvIOK(ST(x))) \
    croak("requires a list of integers");

MODULE = Parallel::Spoon PACKAGE = Parallel::Spoon PREFIX = spoon_
PROTOTYPES: ENABLE

# Sum a list under multiple procs
static int
spoon_reduce(reducer, ...)
I32 reducer;
CODE:
  RETVAL = 0;
  reducer_t fp;
  fp = &reduce_sum;

  if (items == 1) {
    croak("list of length 0 doesn't make any sense!");
  }
  else if (items == 2) {
    CHKISINT(1);
    RETVAL = SvIVX(ST(1));
  }
  else {
    I32 i;
    for (i = 1; i < items; i++) {
      CHKISINT(i);
      RETVAL = (*fp)(RETVAL, SvIVX(ST(i)));
    }
  }
OUTPUT:
  RETVAL

# Invoke a callback under n procs
static int
spoon_call(subname, n)
SV* subname;
int n;
CODE:
  RETVAL = EXIT_SUCCESS;
  if (n <= 0)
    croak("n <= 0 doesn't make any sense!");

  I32 i = 0;
  bool isparent = false;
spawn:
  switch (fork()) {
    # Child: go do the work
    case 0: break;

    # Fork failed: goodbye cruel world
    case -1: abort();

    # Parent: continue until n-1 procs have been spawned
    default:
      if (++i == n-1) {
        isparent = true;
        break;
      }
      goto spawn;
  }

  # Set up local access to stack pointer
  dSP;

  ENTER;
  SAVETMPS;

  # Prepare one parameter (the tid)
  PUSHMARK(SP);
  EXTEND(SP, 1);
  
  PUSHs(sv_2mortal(newSViv(i)));
  PUTBACK;
  # Invoke the callback
  call_sv(subname, 0);

  FREETMPS;
  LEAVE;

  if (!isparent)
    exit(EXIT_SUCCESS);
OUTPUT:
  RETVAL
