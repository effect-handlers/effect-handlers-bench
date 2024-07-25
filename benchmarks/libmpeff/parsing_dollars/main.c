#include "mpeff.h"
#include <stdio.h>
#include <stdlib.h>

MPE_DEFINE_EFFECT1(read, read)
MPE_DEFINE_OP0(read, read, int)

MPE_DEFINE_EFFECT1(emit, emit)
MPE_DEFINE_VOIDOP1(emit, emit, long)

MPE_DEFINE_EFFECT1(stop, stop)
MPE_DEFINE_VOIDOP0(stop, stop)

#define NEWLINE 10
#define DOLLAR 36
inline bool is_newline(int c) { return c == NEWLINE; }
inline bool is_dollar(int c) { return c == DOLLAR; }

// Locals in parse function
typedef struct parse_locals_t {
  int64_t i;
  int64_t j;
  int64_t n;
} parse_locals_t;


// Sum handler
static void* sum(mpe_resume_t* r, void* local, void* arg) {
  int64_t new_s = mpe_long_voidp(local) + mpe_long_voidp(arg);
  return mpe_resume_tail(r, mpe_voidp_long(new_s), NULL);
}
static void* sum_return(void* local, void* arg) {
  return local;
}
static const mpe_handlerdef_t sum_hdef = { 
  MPE_EFFECT(emit), &sum_return, {
  { MPE_OP_TAIL_NOOP, MPE_OPTAG(emit,emit), &sum },
  { MPE_OP_NULL, mpe_op_null, NULL }
}};

// Read handler
static void* catch(mpe_resume_t* r, void* local, void* arg) {
  return NULL;
}
static const mpe_handlerdef_t catch_hdef = { 
  MPE_EFFECT(stop), NULL, {
  { MPE_OP_NEVER, MPE_OPTAG(stop,stop), &catch },
  { MPE_OP_FORWARD, MPE_OPTAG(emit,emit), NULL },
  { MPE_OP_NULL, mpe_op_null, NULL }
}};

// Feed handler
static void* feed(mpe_resume_t* r, void* local, void* arg) {
  parse_locals_t* locals = (parse_locals_t*) local;
  if (locals->i > locals->n) { 
    stop_stop();
    return NULL;
  }
  else if (locals->j == 0) {
    locals->i++;
    locals->j = locals->i;
    return mpe_resume_tail(r, local, mpe_voidp_int(NEWLINE));
  }
  else {
    locals->j--;
    return mpe_resume_tail(r, local, mpe_voidp_int(DOLLAR));
  }
}
static const mpe_handlerdef_t feed_hdef = { 
  MPE_EFFECT(read), NULL, {
  { MPE_OP_TAIL, MPE_OPTAG(read,read), &feed },
  { MPE_OP_FORWARD, MPE_OPTAG(emit,emit), NULL },
  { MPE_OP_FORWARD, MPE_OPTAG(stop,stop), NULL },
  { MPE_OP_NULL, mpe_op_null, NULL }
}};

static void* parse(void* parameter) {
  int64_t a = 0;
  while (true) {
    int c = read_read();
    if (is_dollar(c)) a++;
    else if (is_newline(c)) {
      emit_emit(a);
      a = 0;
    }
    else stop_stop();
  }
  return NULL;
}

static void* run_catch(void* parameter) {
  parse_locals_t local = {
    .i = 0,
    .j = 0,
    .n = mpe_long_voidp(parameter)
  };
  mpe_handle(&feed_hdef, mpe_voidp_ptr(&local), &parse, NULL);
  return NULL;
}

static void* run_sum(void* parameter) { 
  mpe_handle(&catch_hdef, NULL, &run_catch, parameter);
  return NULL;
}

static int64_t run(int64_t n) {
  return mpe_long_voidp(
    mpe_handle(&sum_hdef, mpe_voidp_long(0), &run_sum, mpe_voidp_long(n))
  );
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