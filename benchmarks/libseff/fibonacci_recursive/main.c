#include "seff.h"
#include <stdio.h>

int64_t fib(int n) {
  if (n == 0) return 0;
  if (n == 1) return 1;
  return fib(n - 1) + fib(n - 2);
}

int main(int argc, char** argv) {
  int64_t n = argc != 2 ? 5 : atoi(argv[1]);
  int64_t result = fib(n);
  printf("%ld\n", result);
  return 0;
}


