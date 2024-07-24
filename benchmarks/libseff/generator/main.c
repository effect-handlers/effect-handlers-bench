#include "seff.h"
#include <stdio.h>

DEFINE_EFFECT(yield, 0, void, { int64_t value; });

// Tree data structure
struct node_t {
  struct node_t* l;
  int64_t v;
  struct node_t* r;
};
typedef struct node_t node_t;
typedef struct node_t* tree_t;

// Generator data structure
struct thunk_t {
  int64_t v;
  seff_coroutine_t *k;
};
typedef struct thunk_t thunk_t;
typedef thunk_t generator_t;

// Allocate and free a tree node
static inline node_t* allocNode() { return malloc(sizeof(node_t));}
static inline void freeNode(node_t* node) { free(node); }

// Allocate a tree on the heap
static tree_t makeTree(int n) {
  if (n == 0) return NULL;
  tree_t node = allocNode();
  tree_t t = makeTree (n - 1);

  // Note: both left and right pointers point to the same memory, 
  // to match the other languages
  node->l = t;
  node->r = t;
  node->v = n;
  return node;
}

// Free tree from heap
static void freeTree(tree_t tree) {
  if (tree == NULL) return;
  freeTree(tree->l);
  freeNode(tree);
}

// Yield handler
static thunk_t handleYield(seff_coroutine_t *k) {
  seff_request_t req = seff_handle(k, NULL, HANDLES(yield));
  thunk_t thunk;
  switch (req.effect) {
    CASE_EFFECT(req, yield, {
      thunk.v = payload.value;
      thunk.k = k;
      return thunk;
    });
    CASE_RETURN(req, {
      thunk.v = (int64_t) payload.result;
      thunk.k = NULL; 
      seff_coroutine_delete(k);
      return thunk;
    });
  }

  // Unreachable, but required by C
  thunk.v = 0;
  thunk.k = NULL;
  return thunk;
}

// Performs yield for every node in tree
static void* iterate(void* parameter) {
  if (parameter == NULL) return NULL;
  tree_t tree = parameter;
  iterate(tree->l);
  PERFORM (yield, tree->v);
  iterate(tree->r);
  return NULL;
}

// Sums all values generated
static int64_t sum(generator_t generator) {
  int64_t acc = 0;
  while (generator.k != NULL) {
    acc += generator.v;
    generator = handleYield(generator.k);
  }
  return acc;
}

static int64_t run(int64_t n) {
  tree_t tree = makeTree(n); 
  seff_coroutine_t *k = seff_coroutine_new(iterate, (void*) tree);
  generator_t generator = handleYield(k);

  // Sum generated values
  int64_t result = sum(generator);

  // Free memory
  freeTree(tree);
  return result;
}

int main(int argc, char** argv) { 
  int64_t n = argc != 2 ? 25 : atoi(argv[1]);
  int64_t r = run(n);

  // Increase size of output buffer for performance
  char buffer[8192];
  setvbuf(stdout, buffer, _IOFBF, sizeof(buffer));
  printf("%ld\n", r);
  return 0; 
}