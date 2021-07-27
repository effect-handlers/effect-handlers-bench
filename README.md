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

+ `systems/<system_name>/Dockerfile` is the `Dockerfile` in order to build
  the system.
+ `benchmarks/<system_name>/NNN_<benchmark_name>/` contains the source for the
  benchmark `<benchmark_name>` for the system `<system_name>`.
+ `benchmark_descriptions/NNN_<benchmark_name>.md` contains the description of
  the benchmark, the input and outputs, and any special considerations.
+ `Makefile` is used to build the systems and benchmarks, and run the
  benchmarks. For each `system`, the Makefile has the following rules:
  - `sys_<system_name>`: Builds the `<system_name>` docker image.
  - `bench_<system_name>`: Runs the benchmarks using the docker image for the
    `<system_name>`.

## Systems

The currently included systems are:

+ `ocaml` - [Multicore OCaml](https://github.com/ocaml-multicore/ocaml-multicore)

We use Ubuntu 20.04 as the base image for building the systems.

## Benchmarks

| Serial Numer | Benchmark | Description |
|--------------|-----------|-------------|
| 1 | N-queens | Finds an assignment of queens on a chess board of size N x N |
| 2 | Generator | Traverses a complete binary tree of depth 25 by yielding at every step |

We use [hyperfine](https://github.com/sharkdp/hyperfine) to run the benchmarks.

## Contributing

### System

If you wish to contribute a system `awesome_system`, please add a new dockerfile
at `systems/<awesome_system>/Dockerfile`. Having a dockerfile aids
reproducibility and ensures that we can build the system from scratch natively
on a machine if needed.

### Benchmark

If you wish to add a new benchmark `goat_benchmark` for system `awesome_system`,

+ Pick the next serial number for the benchmark `NNN`.
+ Add the benchmark sources under `benchmarks/<awesome_system>/NNN_<goat_benchmark>`.
+ Update the `Makefile` to build and run the benchmark.

## Benchmarking chair

The benchmarking chairs maintain the repository and ensure that the quality of
the contributions. The tenure of the benchmarking chair is 6 months. The current
benchmarking chair is [Daniel Hillerström](https://github.com/dhil).
