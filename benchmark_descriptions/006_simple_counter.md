# 006 - Simple Counter

Repeatedly apply an operation in a loop at a non-tail position.

## Input

The program should take as input a single non-negative integer `n` with default value 100000.

## Output

Output a single integer, operation applied `n` times and repeated `1000` times.

## Description

Compute the repeated application of provided operation. The operation is applied via handling of effect `Increment` which applies the operation `op` on the rest of computation (recursive call with decremented param) and provided argument. The continuation should be resumed at a non-tail position as indicated by the following code.

```ocaml
effect Increment : int -> unit
let op x y = abs (x - (503 * y) + 37) mod 1009 in

handle
  let rec looper i = 
    if i = 0 then
      initial_value
  else ( 
    perform (Increment i);
    looper (i - 1)
  )
  in
  looper n
with
  | effect (Increment j) k -> op j (continue k ()))
```

The full benchmark is repeated `1000` times, each time, the result from the previous run is taken as the `initial_value`. The initial `initial_value` is `0`. 

Try to call the repeating part of the program in a tail recursive way, as the stack size of `looper` is expected to be linear in `n`.  The main purpose of `op` is to thwart any optimizations performed by compilers to inline the resuming call.

## Benchmark rationale

The benchmark measures the performance of a deep stack of resumptions applied exactly once, but in a non tail position.

## Labels (optional)

SINGLE_RESUMPTION, EXACTLY_ONCE_RESUMPTION, DEEP_RESUMPTION_STACK

## Output example

Example:

| Input param | Square of the input |
|--------|---------------------|
| 1 | 537 |
| 2 | 913 |
| 3 | 96 |
| 4 | 812 |
| 5 | 37 |
| 10 | 654 |
| 100 | 518 |
| 1000 | 708 |
| 10000 | 860 |
| 100000 | 1004 |
| 200000 | 956 |
| 250000 | 866 |
