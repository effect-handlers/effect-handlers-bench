# 006 - Nested pipes

This benchmark is a variation of the [flat pipes](005_flatpipes.md)
benchmark. This variation measures the effect of rapid context
switching in deeply nested pipelines.

## Input

The input data is some (relatively small) integer `n` (default value
is `n = 8`).

## Output

There is no output data, however, a correct implementation will
terminate.

## Description

This benchmark is deeply nested pipeline consisting of `3 + 2^n`
producers/consumers. The initial producer yields an infinite sequence
of integers, this sequence passes through `2^n` pipes before another
pipe consumes the first `1000` elements of the sequence and forwards
them to a blackhole.

The producer and consumer processes make use of two effectful
operations. The effect interface can be summarised as follows.  Effect
interface

```haskell
yield : int -> unit
await : unit -> int
```

A producer process uses `yield` to send integers to the consumer
process. Dually, the consumer processes uses `await` to block and wait
for input. A process may be a producer and consumer simultaneously.

The follow pseudocode give the gist of an adequate implementation of
the initial producer process.

```haskell
produceFrom n = yield n; produceFrom (n+1)
```

The following pseudocode generates `2^n` pass-through pipes.

```haskell
expoPipe n =
  if n = 0
  then let x = await () in
       yield (x+1); expoPipe 0
  else pipe (λ().expoPipe (n - 1)) (λ().expoPipe (n - 1))
```

where the binary function `pipe` constructs a pipeline using its two
arguments.

The glue code between the producer and consumer processes is
implemented by some handler. There are multiple possible ways to
realise this handler, e.g. in a unary setting one can use a pair of
mutually-recursive shallow handlers or `sheep' handlers to handle
`yield` and `await` in tandem such as outlined by the following
pseudocode.

```haskell
pipe prod cons = handle prod () with
                   val x -> ()
                   yield n k -> copipe (\().cons n) k

copipe cons prod = handle cons () with
                     val x -> ()
                     await () k -> pipe prod k
```
Alternatively, in a binary setting, one can aptly use
a single deep handler, e.g.


```haskell
pipe prod cons = handle cons (), prod () with
                   val (x, y) -> ()
                   (await (), yield n) k -> k(n, ())
```

## Benchmark rationale

This benchmark measure the effect of continuously changing handler
contexts. This is a good benchmark to measure the performance of rapid
cooperative switching between many differently handlers.

## Reference

This benchmark originates from Kammar et al. (2013): Handlers in
Action.

## Labels

CONCURRENCY
