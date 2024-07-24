#include "seff.h"
#include <stdio.h>

DEFINE_EFFECT(emit, 0, void, { int64_t value; });

struct range_args {
  int64_t l;
  int64_t u;
};

static int64_t handleEmit(seff_coroutine_t *k) {
  effect_set handles_emit = HANDLES(emit); 
  seff_request_t req = seff_handle(k, NULL, handles_emit);

  int64_t s = 0;
  bool done = false;
  while (!done) {   
    switch (req.effect) {
      CASE_EFFECT(req, emit, {
        s += payload.value;
        req = seff_handle(k, NULL, handles_emit);
        break;
      })
      CASE_RETURN(req, {
        done = true;
        break;
      })
    };
  }
  return s;
}

static void* range(void* args) {
  struct range_args* range_args = args;
  for (int l = range_args->l; l <= range_args->u; l++) {
    PERFORM (emit, l);
  }
  return NULL;
}

static int64_t run(int64_t n) {
  struct range_args args = {
    .l = 0,
    .u = n
  };
  seff_coroutine_t *k = seff_coroutine_new(range, (void*) &args);
  int64_t result = handleEmit(k);
  seff_coroutine_delete(k);
  return result;
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