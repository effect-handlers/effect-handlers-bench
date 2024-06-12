#include "mpeff.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

MPE_DEFINE_EFFECT1(op, perform)
MPE_DEFINE_VOIDOP1(op, perform, long)

static inline int64_t binaryOperation(int64_t x, int64_t y) { 
  return (labs(x - (503 * y) + 37)) % 1009;
}

static void* handle_op_perform(mpe_resume_t* r, void* local, void* arg) {
  int64_t result = mpe_long_voidp(mpe_resume(r, local, NULL));
  return mpe_voidp_long(binaryOperation(mpe_long_voidp(arg), result));
}

static void* handle_return(void* local, void* arg) {
  return arg;
}

static const mpe_handlerdef_t op_hdef = { 
  MPE_EFFECT(op), &handle_return, {
  { MPE_OP_SCOPED_ONCE, MPE_OPTAG(op,perform), &handle_op_perform },
  { MPE_OP_NULL, mpe_op_null, NULL }
}};

typedef struct loop_args_t {
  int64_t n;
  int64_t s;
} loop_args_t;

// Note: using a for loop instead of recursion because
// it is the idiomatic way of doing loops in C
static void* loop(void* parameter) {
  loop_args_t* args = (loop_args_t*) parameter;
  for (int i = args->n; i > 0; i--) {
    op_perform(i);
  }
  return (void*) args->s;
}

static int64_t run(int64_t n, int64_t s) {
  loop_args_t args = {
    .n = n,
    .s = s
  };
  return mpe_long_voidp(
    mpe_handle(&op_hdef, NULL, loop, mpe_voidp_ptr(&args))
  );
}

static int64_t repeat(int64_t n) {
  int64_t s = 0;
  for (int i = 0; i < 1000; i++) {
    s = run(n, s);
  }
  return s;
}

int main(int argc, char** argv) { 
  int64_t n = argc != 2 ? 5 : atoi(argv[1]);
  int64_t r = repeat(n);
  
  // Increase output buffer size to increase performance
  char buffer[8192];
  setvbuf(stdout, buffer, _IOFBF, sizeof(buffer));
  printf("%ld\n", r);
  return 0; 
}