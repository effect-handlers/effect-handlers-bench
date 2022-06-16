# 004 - Triples

Compute the number of strictly decreasing triples that sum up to a target number `s`.
Effect handlers are used to iterate through all the possible combinations.

## Input

The program should take two command line arguments:

- `s` is the target sum. Default: 300
- `n` is the maximum number in the triple. Default: 300

The program should output the sum of hashes of triples that sum up to `s`, where the values in triples are nonnegative numbers less than or equal to the number `n`.

## Output

Single integer sum of hashes of triples modulo `1000000007`.

## Description

The program should use the effect handler `Choice : unit -> bool` to iterate through all the possible combinations of numbers, starting with `n` as seen in the following `ocaml` code:

```ocaml
let rec choice n =
  if (n < 1) then raise Fail
  else if (perform (Flip ())) then n
  else choice (n - 1)
```

To produce a triple, the program should choose three numbers using the `choice` function and returning the triple if numbers sum up to `s` or failing otherwise.
Do not take any symmetries or optimization into account and do not short circuit the calculations.
To prevent compiler from optimizing the calculations away, the final result is the sum of hashes of all valid triples modulo `1000000007`.
The hash of triple is calculated as follows:

```ocaml
let hash_triple (a,b,c) = 
    (53 * a + 2809 * b + 148877 * c) mod 1000000007 (* 2089 = 53 * 53, 148877 = 53 * 2089  *)
```

You do not need to store the calculated triples in a list and doing so will probably decrease the performance of the benchmark

## Labels

BACKTRACKING, MULTIPLE_RESUMPTIONS

## Output example

Example:

| n | s | hash sum |
|--------|---------------------|
| 10 | 10 | 779312 |
| 10 | 20 | 4186576 |
| 10 | 27 | 1216827 |
| 100 | 100 | 380148825 |
| 100 | 250 | 186257618 |
| 200 | 200 | 306102599 |
| 300 | 300 | 460212934 |
| 400 | 400 | 504650095 |
| 500 | 500 | 131783323 |
| 600 | 600 | 23964230 |
