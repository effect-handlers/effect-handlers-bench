#include "mpeff.h"
#include <stdio.h>
#include <stdlib.h>

MPE_DEFINE_EFFECT1(iterator, emit);
MPE_DEFINE_VOIDOP1(iterator, emit, long);

static void* handle_iterator_emit(mpe_resume_t* r, void* local, void* arg) {
  long result = mpe_long_voidp(local) + mpe_long_voidp(arg);
  return mpe_resume_tail(r, mpe_voidp_long(result), NULL);
}

static void* handle_iterator_result(void* local, void* arg) {
  return local;
}

static const mpe_handlerdef_t iterator_hdef = { 
  MPE_EFFECT(iterator), 
  &handle_iterator_result, 
  {
    { MPE_OP_TAIL_NOOP, MPE_OPTAG(iterator,emit), &handle_iterator_emit },
    { MPE_OP_NULL, mpe_op_null, NULL }
  }
};

struct range_args {
  int64_t l;
  int64_t u;
};

static void* range(void* args) {
  struct range_args* range_args = mpe_ptr_voidp(args);
  for (int l = range_args->l; l <= range_args->u; l++) {
    iterator_emit(l);
  }
  return NULL;
}

static int64_t run(int64_t n) {
  struct range_args args = {
    .l = 0,
    .u = n
  };
  return mpe_long_voidp(mpe_handle(&iterator_hdef, 
                                   mpe_voidp_long(0), 
                                   &range,
                                   mpe_voidp_ptr(&args)));
}

int main(int argc, char** argv) { 
  int64_t n = argc != 2 ? 5 : atoi(argv[1]);
  int64_t r = run(n);

  // Increase output buffer size to increase performance
  char buffer[8192];
  setvbuf(stdout, buffer, _IOFBF, sizeof(buffer));
  printf("%ld\n", r);
  return 0;   
}