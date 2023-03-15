# 004 - Triples

Compute the number of strictly decreasing triples that sum up to a target number `s`.
Effect handlers are used to iterate through all the possible combinations.

The program should use the effect handler `Choice : unit -> bool` to iterate
through all the possible combinations of numbers, starting with `n` as seen in
the following `ocaml` code:

```ocaml
let rec choice n =
  if (n < 1) then raise Fail
  else if (perform (Flip ())) then n
  else choice (n - 1)
```

To produce a triple, the program should choose three numbers using the `choice`
function and returning the triple if numbers sum up to `s` or failing otherwise.
Do not take any symmetries or optimization into account and do not short circuit
the calculations. To prevent compiler from optimizing the calculations away, the
final result is the sum of hashes of all valid triples modulo `1000000007`. The
hash of triple is calculated as follows:

```ocaml
let hash_triple (a,b,c) =
    (53 * a + 2809 * b + 148877 * c) mod 1000000007 (* 2089 = 53 * 53, 148877 = 53 * 2089  *)
```

Do not store the calculated triples in a list.

The program should take two command line arguments:

- `s` is the target sum.
- `n` is the maximum number in the triple.

The output is the sum of hashes of triples modulo `1000000007`.

## Examples

### Small

Input: 10 10

Output: 779312

### Large

Input: 300 300

Output: 460212934

## Metadata

### Labels

BACKTRACKING, MULTIPLE_RESUMPTIONS

### References

### Rationale

