#include "seff.h"
#include <stdio.h>
#define ENUMERATE_SIZE 1000

DEFINE_EFFECT(done, 0, int64_t, { int64_t value; });

static int64_t handleDone(seff_coroutine_t *k, int* xs) {
  effect_set handles_done = HANDLES(done); 
  seff_request_t req = seff_handle(k, NULL, handles_done);

  switch (req.effect) {
    CASE_EFFECT(req, done, {
      return (int64_t) payload.value;
    })
    CASE_RETURN(req, {
      return (int64_t) payload.result;
    })
    default:
      return -1;
  };
}

static void* product(void* parameter) {
  int* xs = (int*) parameter;
  int64_t prod = 1;
  
  int i = 0;
  while (i <= ENUMERATE_SIZE) {
    if (xs[i] == 0) {
      PERFORM (done, 0);
    }
    else {
      prod *= xs[i];
      i++;
    }
  }
  return NULL;
}

static int run_product(int* xs) {
  seff_coroutine_t *k = seff_coroutine_new(product, (void*) xs);
  int64_t result = handleDone(k, xs);
  seff_coroutine_delete(k);
  return result;
}

static void enumerate(size_t n, int xs[n]) {
  for (size_t i = 0; i < n; i++) {
    xs[i] = (int) (n - 1) - i;
  }
}

static int64_t run(int64_t n) {
  int xs[ENUMERATE_SIZE + 1];
  enumerate(ENUMERATE_SIZE + 1, xs); 

  int64_t a = 0;
  for (int i = 0; i < n; i++) {
    a += run_product(xs);
  }
  return a;
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