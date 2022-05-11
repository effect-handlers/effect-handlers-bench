# 005 - Flat pipes

This benchmark measures the effect of rapid context switching by way
of a simple pipes computation.

## Input

The input data is some integer `n` (default value is `n = 256`).

## Output

There is no output data, however, a correct implementation will
terminate.

## Description

This benchmark is a small flat pipeline consisting of one *producer*
and one *consumer*. The producer yields in turn integers in the
sequence `[1..n]`, for some `n`, connected to an infinite consumer
(blackhole) process that ignores all inputs.

The producer and consumer processes make use of one effectful
operation each. The effect interface can be summarised as follows.
Effect interface

```haskell
yield : int -> unit
await : unit -> int
```

The producer process uses the operation `yield` to send integers to
the consumer process. Dually, the consumer processes uses `await` to
block and wait for input.

The follow pseudocode give the gist of an adequate implementation of
the producer process.

```haskell
produceRange m n = if m > n then () else yield m; produceRange (m+1) n
```

An adequate consumer process may be implemented as follows.
```haskell
blackhole () = ignore (await ()); blackhole ()
```

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
cooperative switching between two differently known handlers.

## Reference

This benchmark originates from "G. Gonzalez. pipes-2.5: Faster and
slimmer, 2012. http://www.haskellforall.com/2012/10/pipes-25-faster-and-slimmer.html"

## Labels

CONCURRENCY
