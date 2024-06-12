#include "mpeff.h"
#include <stdio.h>
#include <stdlib.h>

MPE_DEFINE_EFFECT1(yield, yield)
MPE_DEFINE_VOIDOP1(yield, yield, long)

// Tree data structure
struct node_t {
  struct node_t* l;
  int64_t v;
  struct node_t* r;
};
typedef struct node_t node_t;
typedef struct node_t* tree_t;

// Allocate and free a tree node
static inline node_t* alloc_node() { return malloc(sizeof(node_t));}
static inline void free_node(node_t* node) { free(node); }

// Generator data structure
struct thunk_t {
  int64_t v;
  mpe_resume_t *k;
};
typedef struct thunk_t thunk_t;
typedef thunk_t generator_t;

// Allocate and free a thunk
static inline thunk_t* alloc_thunk() { return malloc(sizeof(thunk_t));}
static inline void free_thunk(thunk_t* thunk) { free(thunk); }

// Allocate a tree on the heap
static tree_t makeTree(int n) {
  if (n == 0) return NULL;
  tree_t node = alloc_node();
  tree_t t = makeTree (n - 1);

  // Note: both left and right pointers point to the same memory, 
  // to match the other languages
  node->l = t;
  node->r = t;
  node->v = n;
  return node;
}

// Free tree from heap
static void free_tree(tree_t tree) {
  if (tree == NULL) return;
  free_tree(tree->l);
  free_node(tree);
}

static void* handler_yield(mpe_resume_t* r, void* local, void* arg) {
  thunk_t* thunk = alloc_thunk(); 
  thunk->v = mpe_long_voidp(arg);
  thunk->k = r;
  return mpe_voidp_ptr(thunk); 
}

static void* handler_result(void* local, void* arg) {
  thunk_t* thunk = alloc_thunk();
  thunk->v = mpe_long_voidp(arg);
  thunk->k = NULL;
  return mpe_voidp_ptr(thunk);
}

static const mpe_handlerdef_t yield_hdef = { 
  MPE_EFFECT(yield), &handler_result, {
  { MPE_OP_ONCE, MPE_OPTAG(yield,yield), &handler_yield },
  { MPE_OP_NULL, mpe_op_null, NULL }
}};

static inline thunk_t* resume_yield(thunk_t* t) {
  mpe_resume_t* k = t->k;
  free_thunk(t);
  return (thunk_t*) mpe_resume(k, NULL, NULL);
}

// Performs yield for every node in tree
static void* iterate(void* parameter) {
  if (parameter == NULL) return NULL;
  tree_t tree = parameter;
  iterate(tree->l);
  yield_yield(tree->v);
  iterate(tree->r);
  return NULL;
}

// Sums all values generated
static int64_t sum(generator_t* generator) {
  int64_t acc = 0;
  while (generator->k != NULL) {
    acc += generator->v;
    generator = resume_yield(generator);
  }
  free_thunk(generator);
  return acc;
}

static int64_t run(int64_t n) {
  tree_t tree = makeTree(n); 
  generator_t* generator = mpe_handle(&yield_hdef, NULL, &iterate, tree);

  // Sum generated values
  int64_t result = sum(generator);

  // Free memory
  free_tree(tree);
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