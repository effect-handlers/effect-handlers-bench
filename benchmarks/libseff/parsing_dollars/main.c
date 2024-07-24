#include "seff.h"
#include <stdio.h>

DEFINE_EFFECT(read, 0, char, {});
DEFINE_EFFECT(emit, 1, void, { int64_t value; });
DEFINE_EFFECT(stop, 2, void, {});

// Improves readability, but is not needed
#define HANDLE(func, arg, handler) handler(seff_coroutine_new(func, arg))

#define NEWLINE 10
#define DOLLAR 36
inline bool is_newline(char c) { return (int) c == NEWLINE; }
inline bool is_dollar(char c) { return (int) c == DOLLAR; }

static void* parse(void* parameter) {
  int64_t a = 0;
  while (true) {
    char c = PERFORM(read);
    if (is_dollar(c)) a++;
    else if (is_newline(c)) {
      PERFORM(emit, a);
      a = 0;
    }
    else PERFORM(stop);
  }
  return NULL;
}

static int64_t sum(seff_coroutine_t *k) {
  int64_t s = 0;
  seff_request_t req = seff_handle(k, NULL, HANDLES(emit));
  
  bool done = false;
  while (!done) {
    switch (req.effect)
    {
      CASE_EFFECT(req, emit, {
        s += payload.value;
        req = seff_handle(k, NULL, HANDLES(emit));
        break;
      })
      CASE_RETURN(req, {
        done = true;
        seff_coroutine_delete(k);
        break;
      })
    }
  }
  return s;
}

static void catch(seff_coroutine_t *k) {
  seff_handle(k, NULL, HANDLES(stop));
  seff_coroutine_delete(k);
}

static void feed(int64_t n, seff_coroutine_t *k) {
  int64_t i = 0;
  int64_t j = 0;
  seff_request_t req = seff_handle(k, NULL, HANDLES(read));

  bool done = false;
  while (!done) {
    switch (req.effect)
    {
      CASE_EFFECT(req, read, {
        if (i > n) { 
          seff_coroutine_delete(k);
          PERFORM(stop);
        }
        else if (j == 0) {
          i++;
          j = i;
          req = seff_handle(k, (void*) NEWLINE, HANDLES(read));
        }
        else {
          j--;
          req = seff_handle(k, (void*) DOLLAR, HANDLES(read));
        }
        break;
      });
      CASE_RETURN(req, {
        done = true;
        seff_coroutine_delete(k);
        break;
      });
    }
  }
}

static void* run_catch(void* parameter) {
  seff_coroutine_t *parse_k = seff_coroutine_new(parse, NULL); // Never freed, see https://github.com/effect-handlers/effect-handlers-bench/pull/58#discussion_r1627262932
  feed((int64_t) parameter, parse_k);
  return NULL;
}

static void* run_sum(void* parameter) { 
  HANDLE(run_catch, parameter, catch); 
  return NULL;
}

static int64_t run(int64_t n) {
  int64_t result = HANDLE(run_sum, (void*) n, sum);
  return result;
}

int main(int argc, char** argv) { 
  int64_t n = argc != 2 ? 10 : atoi(argv[1]);
  int64_t result = run(n);
  
  // Increase output buffer size to increase performance
  char buffer[8192];
  setvbuf(stdout, buffer, _IOFBF, sizeof(buffer));
  printf("%ld\n", result);
  return 0; 
}