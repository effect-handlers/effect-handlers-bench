# 001 - N-Queens Problem

The goal of the benchmark is to calculate the number of safe assignments of
queens on a N x N chess board. Effect handlers are utilised for backtracking
search.

## Input

The program should take a single command-line argument which is the
size `N` of the chess board. For benchmarking, the default input used is 13.

## Output

The program should print the number of solutions to the standard
output.

## Labels

BACKTRACKING, MULTIPLE_RESUMPTIONS

## Description

Compute the number of solutions to the N-Queens problem.
Use brute force search without any heuristics or symmetries to speed up the search.
The suggested implementation of backtracking is to use the effect `Choose : int -> int`
which continues the search for every cell in the current column.

## Output example

| N | Number of solutions |
|---|---------------------|
| 1 | 1 |
| 2 | 0 |
| 3 | 0 |
| 4 | 2 |
| 5 | 10 |
| 6 | 4 |
| 7 | 40 |
| 8 | 92 |
| 9 | 352 |
| 10 | 724 |
| 11 | 2,680 |
| 12 | 14,200 |
| 13 | 73,712 |
| 14 | 365,596 |
| 15 | 2,279,184 |
| 16 | 14,772,512 |
| 17 | 95,815,104 |
| 18 | 666,090,624 |
| 19 | 4,968,057,848 |
| 20 | 39,029,188,884 |
| 21 | 314,666,222,712 |
| 22 | 2,691,008,701,644 |
| 23 | 24,233,937,684,440 |
| 24 | 227,514,171,973,736 |
| 25 | 2,207,893,435,808,352 |
| 26 | 22,317,699,616,364,044 |
