#include "seff.h"
#include <stdio.h>
#define ENUMERATE_SIZE 1000

DEFINE_EFFECT(done, 0, int64_t, { int64_t value; });

// Using a linked list to mirror the other languages
typedef struct list {
  int64_t head;
  struct list* next;
} list_t;

static int64_t handleDone(seff_coroutine_t *k, list_t* xs) {
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
  list_t list = *(list_t*) parameter;
  if (list.head == 0) {
    PERFORM(done, 0);
  }
  else {
    int64_t res = (int64_t) product(list.next); 
    return (void*) (list.head * res);
  }
  return NULL;
}

static int run_product(list_t* xs) {
  seff_coroutine_t *k = seff_coroutine_new(product, (void*) xs);
  int64_t result = handleDone(k, xs);
  seff_coroutine_delete(k);
  return result;
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