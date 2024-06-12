#include "mpeff.h"
#include <stdio.h>
#include <stdlib.h>

MPE_DEFINE_EFFECT2(state, get, put)
MPE_DEFINE_OP0(state, get, long)
MPE_DEFINE_VOIDOP1(state, put, long)

static void* _state_get(mpe_resume_t* r, void* local, void* arg) {
  return mpe_resume_tail(r, local, local);
}

static void* _state_put(mpe_resume_t* r, void* local, void* arg) {
  return mpe_resume_tail(r, arg, NULL);
}

static const mpe_handlerdef_t state_hdef = { MPE_EFFECT(state), NULL, {
  { MPE_OP_TAIL_NOOP, MPE_OPTAG(state,get), &_state_get },
  { MPE_OP_TAIL_NOOP, MPE_OPTAG(state,put), &_state_put },
  { MPE_OP_NULL, mpe_op_null, NULL }
}};

static void* countdown(void* parameter) {
  long state = state_get();
  while (state > 0) {
    state_put(state - 1);
    state = state_get();
  }
  return mpe_voidp_long(state);
}

int main(int argc, char** argv) { 
  int64_t n = argc != 2 ? 5 : atoi(argv[1]);
  int64_t result = mpe_long_voidp(mpe_handle(&state_hdef, mpe_voidp_long(n), &countdown, NULL));
  printf("%ld\n", result);
  return 0;   
}