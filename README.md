# effect-handlers-bench

The project aims to build a repository of various `systems` that implement
effect handlers, `benchmarks` implemented in those systems, and scripts to
build the systems, run the benchmarks and produce the results.

A `system` may either be a programming language that have native support for
effect handlers, or a library that embeds effect handlers in another programming
language.

## Quick start

```bash
$ make bench_ocaml
```

runs the OCaml benchmarks and produces `ocaml.csv` which contains the result of
running the benchmarks.

## Directory structure

+ `system/<system_name>/Dockerfile` is the `Dockerfile` in order to build
  the system.
+ `benchmarks/<system_name>/NNN_<benchmark_name>/` contains the source for the
  benchmark `<benchmark_name>` for the system `<system_name>`.
+ `Makefile` is used to build the systems and benchmarks, and run the
  benchmarks. For each `system`, the Makefile has the following rules:
  - `sys_<system_name>`: Builds the `<system_name>` docker image.
  - `bench_<system_name>`: Runs the benchmarks using the docker image for the
    `<system_name>`.

## Systems

The currently included systems are:

+ `ocaml` -- Multicore OCaml

## Benchmarks

| Serial Numer | Benchmark | Description |
|--------------|-----------|-------------|
| 1 | N-queens | Finds an assignment of queens on a chess board of size N x N |
| 2 | Generator | Traverses a complete binary tree of depth 25 by yielding at every step |
