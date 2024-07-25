#include "mpeff.h"
#include <stdio.h>
#include <stdlib.h>

MPE_DEFINE_EFFECT1(sieve, prime)
MPE_DEFINE_OP1(sieve, prime, bool, long)

typedef struct primes_params_t {
  int64_t i;
  int64_t n;
  int64_t a;
} primes_params_t;

static void* handle_sieve_prime(mpe_resume_t* r, void* local, void* arg) {
  bool res;
  if (mpe_long_voidp(arg) % mpe_long_voidp(local) == 0) res = false;
  else res = mpe_bool_voidp(sieve_prime(mpe_long_voidp(arg)));
  return mpe_resume_tail(r, local, mpe_voidp_bool(res));
}

static void* handle_top_sieve_prime(mpe_resume_t* r, void* local, void* arg) {
  return mpe_resume_tail(r, local, mpe_voidp_bool(true));
}

// NOTE: We exepected to be able to use MPE_OP_TAIL here, but when used we
// enter an infinite loop of the same handler handling the next emitted prime
// effect instead of the next one up the stack.
// See https://github.com/effect-handlers/effect-handlers-bench/pull/60#issuecomment-2167645757
static const mpe_handlerdef_t sieve_hdef = {
  MPE_EFFECT(sieve), NULL,
  {  
    { MPE_OP_SCOPED_ONCE, MPE_OPTAG(sieve,prime), &handle_sieve_prime },
    { MPE_OP_NULL, mpe_op_null, NULL }
  } 
};

static const mpe_handlerdef_t top_sieve_hdef = {
  MPE_EFFECT(sieve), NULL,
  {  
    { MPE_OP_SCOPED_ONCE, MPE_OPTAG(sieve,prime), &handle_top_sieve_prime },
    { MPE_OP_NULL, mpe_op_null, NULL }
  } 
};

static void* primes(void* parameter) {
  primes_params_t* params = (primes_params_t*) mpe_voidp_ptr(parameter);
  if (params->i >= params->n) return mpe_voidp_long(params->a);

  int64_t i = params->i;
  if (sieve_prime(params->i)) {
    params->a += i;
    params->i++;
    return mpe_handle(&sieve_hdef, 
                     mpe_voidp_long(i), 
                     &primes, 
                     mpe_voidp_ptr(params));
  }
  else {
    params->i++;
    return primes(mpe_voidp_ptr(params));
  }
}

static int64_t run(int64_t n) {
  primes_params_t params = {
    .i = 2,
    .n = n,
    .a = 0
  };
  return mpe_long_voidp(
    mpe_handle(&top_sieve_hdef, NULL, &primes, mpe_voidp_ptr(&params))
  );
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
