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
  struct thunk_t* next;
};
typedef struct thunk_t thunk_t;
typedef thunk_t* generator_t;

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

// Allocate and free generator thunk
static inline thunk_t* allocThunk() { return malloc(sizeof(thunk_t)); }
static inline void freeThunk(thunk_t* t) { free(t); }

// Free generator memory
static void freeGenerator(generator_t generator) {
  generator_t next;
  while (generator != NULL) {
    next = generator->next; 
    freeThunk(generator);
    generator = next;
  }
}

// Yield handler
static generator_t handleYield(seff_coroutine_t *k) {
  effect_set handles_yield = HANDLES(yield); 
  seff_request_t req = seff_handle(k, NULL, handles_yield);

  generator_t generator = allocThunk(); 
  generator->v = -1;
  generator_t currentThunk = generator;
  bool done = false;
  while (!done) {   
    switch (req.effect) {
      CASE_EFFECT(req, yield, { 
        currentThunk->v = payload.value;
        currentThunk->next = allocThunk();
        currentThunk = currentThunk->next;
        req = seff_handle(k, 0, handles_yield);
        break;
      })
      CASE_RETURN(req, {
        currentThunk->next = NULL; // Empty thunk 
        done = true;
        break;
      })
    };
  }

  // If no values were generated
  if (generator->v == -1) {
    freeGenerator(generator);
    return NULL;
  }
  return generator;
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
  while (generator != NULL) {
    acc += generator->v;
    generator = generator->next;
  }
  return acc;
}

static int64_t run(int64_t n) {
  tree_t tree = makeTree(n); 

  // Create generator
  seff_coroutine_t *k = seff_coroutine_new(iterate, (void*) tree);
  generator_t generator = handleYield(k);
  seff_coroutine_delete(k);

  // Sum generated values
  int64_t result = sum(generator);

  // Free memory
  freeGenerator(generator);
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