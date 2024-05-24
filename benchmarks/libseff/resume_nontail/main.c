#include "seff.h"
#include <math.h>
#include <stdio.h>

DEFINE_EFFECT(op, 0, void, { int32_t x; });

inline int32_t binaryOperation(int32_t x, int32_t y) { 
  return (labs(x - (503 * y) + 37)) % 1009;
}

seff_request_t req;

int32_t handleOp(seff_coroutine_t *k) {
  req = seff_handle(k, NULL, HANDLES(op));
  switch (req.effect) {
    CASE_EFFECT(req, op, {
      return binaryOperation(payload.x, handleOp(k));
    })
    CASE_RETURN(req, {
      return (int32_t) payload.result;
    })
  };
  return -1;
}

typedef struct loop_args_t {
  int32_t n;
  int32_t s;
} loop_args_t;

void* loop(void* parameter) {
  loop_args_t* args = parameter; 
  if (args->n == 0) return (void*) args->s;
  PERFORM (op, args->n);
  args->n--;
  return loop(args);
}

int32_t run(int32_t n, int32_t s) {
  loop_args_t args = {
    .n = n,
    .s = s
  };
  seff_coroutine_t *k = seff_coroutine_new(loop, (void*) &args);
  int32_t result = handleOp(k);
  seff_coroutine_delete(k);
  return result;
}

int32_t repeat(int32_t n) {
  int32_t s;
  for (int i = 1000; i > 0; i--) {
    s = run(n, s);
  }
  return s;
}

int main(int argc, char** argv) { 
  int32_t n = argc != 2 ? 5 : atoi(argv[1]);
  int32_t r = repeat(n);
  printf("%d\n", r);
  return 0; 
}