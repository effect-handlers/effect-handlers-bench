# 001 - N-Queens Problem

The goal of the benchmark is to calculate the number of safe assignments of
queens on a N x N chess board. Effect handlers are utilised for backtracking
search.

Compute the number of solutions to the N-Queens problem. Use brute force search
without any heuristics or symmetries to speed up the search. The suggested
implementation of backtracking is to use the effect `Choose : int -> int` which
continues the search for every cell in the current column.

The input is the size `N` of the chess board.

The output is the number of solutions.

## Examples

### Small

Input: 5

Output: 10

### Large

Input: 13

Output: 73712

## Metadata

### Labels

BACKTRACKING, MULTIPLE_RESUMPTIONS

### References

### Rationale

