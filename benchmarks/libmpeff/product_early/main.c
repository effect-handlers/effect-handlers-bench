#include "mpeff.h"
#include <stdio.h>
#include <stdlib.h>

#define ENUMERATE_SIZE 1000

MPE_DEFINE_EFFECT1(early, done);
MPE_DEFINE_VOIDOP1(early, done, int);

// Using a linked list to mirror the other languages
typedef struct list {
  int64_t head;
  struct list* next;
} list_t;

static void* handle_early_done(mpe_resume_t* r, void* local, void* arg) {
  return arg;
}

static const mpe_handlerdef_t early_hdef = { MPE_EFFECT(early), NULL, {
  { MPE_OP_NEVER, MPE_OPTAG(early,done), &handle_early_done},
  { MPE_OP_NULL, mpe_op_null, NULL }
}};

static void* product(void* parameter) {
  list_t list = *(list_t*) mpe_ptr_voidp(parameter);
  if (list.head == 0) {
    early_done(0);
    return NULL;
  }
  else {
    int64_t res = mpe_long_voidp(product(mpe_voidp_ptr(list.next))); 
    return mpe_voidp_long(list.head * res);
  }
}

static int run_product(list_t* xs) {
  return mpe_int_voidp(mpe_handle(&early_hdef, NULL, &product, mpe_voidp_ptr(xs)));
}

// Allocate a linked list on the heap
static list_t* enumerate(size_t n) {
  list_t* top = malloc(sizeof(list_t));
  list_t* current = top;

  for (size_t i = 0; i < n; i++) {
    current->head = (n - 1) - i; 
    if (i == n - 1) current->next = NULL;
    else current->next = malloc(sizeof(list_t));
    current = current->next;
  }
  return top;
}

// Free linked list
static void free_list(list_t* xs) {
  while (xs != NULL) {
    list_t* next = xs->next;
    free(xs);
    xs = next;
  }
}

static int64_t run(int64_t n) {
  list_t* xs = enumerate(ENUMERATE_SIZE + 1);

  int64_t a = 0;
  for (int i = 0; i < n; i++) {
    a += run_product(xs);
  }

  free_list(xs);
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