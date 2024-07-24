#include "seff.h"
#include <stdio.h>

DEFINE_EFFECT(prime, 0, bool, { int64_t e; });

typedef struct primes_params_t {
  int64_t i;
  int64_t n;
  int64_t a;
} primes_params_t;

static int64_t handle_toplevel(seff_coroutine_t *k) {
  seff_request_t req = seff_handle(k, NULL, HANDLES(prime));
  int64_t result = 0;
  bool done = false;
  while (!done) {
    switch(req.effect) {
      CASE_EFFECT(req, prime, {
        req = seff_handle(k, (void*) true, HANDLES(prime));
        break;
      });
      CASE_RETURN(req, {
        done = true;
        result = (int64_t) payload.result;
        seff_coroutine_delete(k);
        break;
      });
    }
  }
  return result;
}

static int64_t handle_prime(seff_coroutine_t *k, int64_t i) {
  seff_request_t req = seff_handle(k, NULL, HANDLES(prime));

  int64_t result = 0;
  bool done = false;
  while (!done) {
    switch(req.effect) {
      CASE_EFFECT(req, prime, {
        bool res;
        if (payload.e % i == 0) res = false;
        else res = PERFORM (prime, payload.e);
        req = seff_handle(k, (void*) res, HANDLES(prime));
        break;
      });
      CASE_RETURN(req, {
        done = true;
        result = (int64_t) payload.result;
        seff_coroutine_delete(k);
        break;
      });
    }
  }
  return result;
}

static void* primes(void* parameter) {
  primes_params_t params = *(primes_params_t*) parameter;
  if (params.i >= params.n) return (void*) params.a;

  int64_t i = params.i;
  if (PERFORM (prime, params.i)) {
    params.a += i;
    params.i++;
    seff_coroutine_t *new_k = seff_coroutine_new(primes, (void*) &params);
    return (void*) handle_prime(new_k, i);
  }
  else {
    params.i++;
    return (void*) primes((void*) &params);
  }
}

static int64_t run(int64_t n) {
  primes_params_t params = {
    .i = 2,
    .n = n,
    .a = 0
  };
  seff_coroutine_t *k = seff_coroutine_new(primes, (void*) &params);
  int64_t result = handle_toplevel(k);
  return result;
}

int main(int argc, char** argv) { 
  int64_t n = argc != 2 ? 10 : atoi(argv[1]);
  int64_t r = run(n);
  
  // Increase output buffer size to increase performance
  char buffer[8192];
  setvbuf(stdout, buffer, _IOFBF, sizeof(buffer));
  printf("%ld\n", r);
  return 0;   
}