# effect-handlers-bench

[![Handlers in Action](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_hia.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_hia.yml) 
[![Koka](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_koka.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_koka.yml)
[![Links](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_links.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_links.yml)
[![Multicore OCaml](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_ocaml.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_ocaml.yml) 

The project aims to build a repository of `systems` that implement
effect handlers, `benchmarks` implemented in those systems, and scripts to
build the systems, run the benchmarks, and produce the results.

A `system` may either be a programming language that has native support for
effect handlers, or a library that embeds effect handlers in another programming
language.

## Quick start

Ensure that [Docker](https://www.docker.com/) is installed on your system. Then,

```bash
$ make bench_ocaml
```

runs the OCaml benchmarks and produces `_results/ocaml.csv` which contains the
result of running the Multicore OCaml benchmarks.

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

| S.No. | Benchmark | Description |
|--------------|-----------|-------------|
| 1 | N-queens | Counts the number of solutions to the N queens problem for board size N x N |
| 2 | Generator | Count the sum of elements in a complete binary tree using a generator |

We use [hyperfine](https://github.com/sharkdp/hyperfine) to run the benchmarks.

## Contributing

### Benchmarking chair

The role of the benchmarking chair is to curate the repository, monitor the 
quality of benchmarks, and to solicit new benchmarks and fixes to existing
benchmarks. The tenure of the benchmarking chair is 6 months.

Inaugural chair (2021/07/23 - 2022/01/22): [Daniel Hillerström](https://github.com/dhil)

### Benchmark

If you wish to add a new benchmark `goat_benchmark` for system `awesome_system`,

+ Pick the next serial number for the benchmark `NNN`.
+ Add the benchmark sources under `benchmarks/<awesome_system>/NNN_<goat_benchmark>`.
+ Update the `Makefile` to build and run the benchmark.
+ Add a benchmark description under `benchmark_description/NNN_<goat_benchmark>.md`
  clearly stating the input, output and the expectation from the benchmark. Make sure
  you mention the default input argument for the benchmark.
+ Update this `README.md` file to add the new benchmark to the table of benchmarks.

If you wish to add a benchmark `leet_benchmark` that is not available for a system 
`awesome_system` but is available for another system

+ Use the same serial number for the benchmark `NNN` that is used by the existing system
+ Add the benchmark sources under `benchmarks/<awesome_system>/NNN_<leet_benchmark>`.
+ Update the `Makefile` to build and run the benchmark, using the same parameter as 
  suggested in the benchmark description.

### System

If you wish to contribute a system `awesome_system`, please 

+ add a new dockerfile at `systems/<awesome_system>/Dockerfile`
+ add a new workflow under `.github/workflows/system_<awesome_system>.yml`
+ create a status badge for the new workflow and add it to the top of this `README.md` file in 
  lexicographic order.
  
Ideally, you will also add benchmarks to go with the new system.

Having a dockerfile aids reproducibility and ensures that we can build the system from 
scratch natively on a machine if needed. The benchmarking chair will push the image 
to [Docker Hub](https://hub.docker.com/repository/docker/effecthandlers/effect-handlers) so
that systems are easily available for wider use.
