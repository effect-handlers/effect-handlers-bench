#include "seff.h"
#include <math.h>
#include <stdio.h>

DEFINE_EFFECT(op, 0, void, { int64_t x; });

static inline int64_t binaryOperation(int64_t x, int64_t y) { 
  return (labs(x - (503 * y) + 37)) % 1009;
}

static int64_t handleOpRec(seff_coroutine_t *k) {
  seff_request_t req = seff_handle(k, NULL, HANDLES(op));
  switch (req.effect) {
    CASE_EFFECT(req, op, {
      return binaryOperation(payload.x, handleOpRec(k));
    })
    CASE_RETURN(req, {
      return (int64_t) payload.result;
    })
  };
  return -1;
}

typedef struct loop_args_t {
  int64_t n;
  int64_t s;
} loop_args_t;

// Note: using a for loop instead of recursion because
// it is the idiomatic way of doing loops in C
static void* loop(void* parameter) {
  loop_args_t* args = (loop_args_t*) parameter;
  for (int i = args->n; i > 0; i--) {
    PERFORM(op, i);
  }
  return (void*) args->s;
}

static int64_t run(int64_t n, int64_t s) {
  loop_args_t args = {
    .n = n,
    .s = s
  };
  seff_coroutine_t *k = seff_coroutine_new(loop, &args);
  int64_t result = handleOpRec(k);
  seff_coroutine_delete(k);
  return result;
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