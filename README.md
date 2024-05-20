# Effect handlers benchmarks suite

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

runs the OCaml benchmarks and produces `benchmarks/ocaml/results.csv` which
contains the results of running the Multicore OCaml benchmarks.

## System availability

| System | Availability |
|--------|--------------|
| [Eff](https://github.com/matijapretnar/eff) | [![Eff](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_eff.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_eff.yml) |
| [Effekt](https://github.com/effekt-lang/effekt) | [![Effekt](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_effekt.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_effekt.yml) |
| [Handlers in Action](https://github.com/slindley/effect-handlers) | [![Handlers in Action](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_hia.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_hia.yml) |
| [Koka](https://github.com/koka-lang/koka) | [![Koka](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_koka.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_koka.yml) |
| [libhandler](https://github.com/koka-lang/libhandler) | [![libhandler](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libhandler.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libhandler.yml) |
| [libmpeff](https://github.com/koka-lang/libmprompt) | [![libmpeff](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libmpeff.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libmpeff.yml) |
| [Links](https://github.com/links-lang/links) | [![Links](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_links.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_links.yml) |
| [Multicore OCaml](https://github.com/ocaml-multicore/ocaml-multicore) | [![Multicore OCaml](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_ocaml.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_ocaml.yml) |

## Benchmark availability

|                         | Eff                | Effekt             | Handlers in Action | Koka               | Multicore OCaml    |
| :---------------------- | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: |
| **Countdown**           | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Fibonacci Recursive** | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Product Early**       | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Iterator**            | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Nqueens**             | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Generator**           | :heavy_check_mark: | :x:                | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Tree explore**        | :heavy_check_mark: | :heavy_check_mark: | :x:                | :heavy_check_mark: | :heavy_check_mark: |
| **Triples**             | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Parsing Dollars**     | :heavy_check_mark: | :heavy_check_mark: | :x:                | :heavy_check_mark: | :heavy_check_mark: |
| **Resume Nontail**      | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |
| **Handler Sieve**       | :heavy_check_mark: | :x:                | :x:                | :heavy_check_mark: | :heavy_check_mark: |

Legend:

+ :heavy_check_mark: : Benchmark is implemented
+ :x: : Benchmark is not implemented
+ :heavy_minus_sign: : Benchmark is unsuitable for this system, and there is no sense in implementing it (eg. benchmarking the speed of file transfer in a language that does not support networking)

## Directory structure

+ `systems/<system_name>/Dockerfile` is the `Dockerfile` in order to build
  the system.
+ `benchmarks/<system_name>/<benchmark_name>/` contains the source for the
  benchmark `<benchmark_name>` for the system `<system_name>`.
+ `descriptions/<benchmark_name>/` contains the description of
  the benchmark, the input and outputs, and any special considerations.
+ `Makefile` is used to build the systems and benchmarks, and run the
  benchmarks. For each `system`, the Makefile has the following rules:
  - `system_<system_name>`: Builds the `<system_name>` docker image.
  - `bench_<system_name>`: Runs the benchmarks using the docker image for `<system_name>`.
  - `test_<system_name>`: Tests the benchmark programs using the docker image for `<system_name>`.
+ `LABELS.md` contains a list of available benchmark labels.
  Each benchmark can be assigned multiple labels.

## Contributing

### Benchmarking chairs

The role of the benchmarking chairs is to curate the repository,
monitor the quality of benchmarks, and to solicit new benchmarks and
fixes to existing benchmarks. Each benchmarking chair serves two
consecutive terms. Each term is 6 months.

The current co-chairs are

* [Jesse Sigal](https://github.com/jasigal) (2023/09/27 - 2024/03/27 - 2024/09/27)
* [Philipp Schuster](https://github.com/phischu) (2022/09/21 - 2023/03/21 - 2023/09/21)

Past co-chairs

* [Filip Koprivec](https://github.com/jO-Osko) (2022/01/21 - 2022/07/22 - 2023/03/21)
* [Daniel Hillerström](https://github.com/dhil) (Inaugural chair, 2021/07/23 - 2022/01/22 - 2022/09/20)


### Benchmark

If you wish to implement `<goat_benchmark>` for system `<awesome_system>`,

+ Add the benchmark sources under `benchmarks/<awesome_system>/<goat_benchmark>`.
  The benchmark takes its input as a command-line argument and prints its outputs.
+ Update `benchmarks/<awesome_system>/Makefile`to build, test, and benchmark the program.
  Use the parameters for testing and benchmarking provided in `descriptions/<goat_benchmark>/README.md`.
+ Update this `README.md` file to tick the new benchmark in the benchmark availability table.

### Description

If you wish to add a new benchmark `<goat_benchmark>`,

+ Add a benchmark description under `descriptions/<goat_benchmark>/README.md`.
  Use the template provided in `descriptions/template/README.md`.
+ Provide a reference implementation for at least one system.
+ Update this `README.md` and add a new row to the benchmark availability table.

### System

If you wish to contribute a system `<awesome_system>`,

+ Add a new dockerfile at `systems/awesome_system/Dockerfile`.
+ Add a new workflow under `.github/workflows/system_<awesome_system>.yml`.
  It should build the system and run tests.
+ Update this `README.md` and add a new column to the benchmark availability table.
  Create a status badge and add it as well.
+ Update `Makefile` with commands that build, test, and benchmark the system.

Ideally, you will also add benchmarks to go with the new system.

Having a dockerfile aids reproducibility and ensures that we can build the system from
scratch natively on a machine if needed. The benchmarking chair will push the image
to [Docker Hub](https://hub.docker.com/repository/docker/effecthandlers/effect-handlers) so
that systems are easily available for wider use.

We use Ubuntu 22.04 as the base image for building the systems and
[hyperfine](https://github.com/sharkdp/hyperfine) to run the benchmarks.

### Artifacts

We curate software artifacts from papers related to effect
handlers. If you wish to contribute your artifacts, then please place
your artifact as-is under a suitable directory in `artifacts/`.

There is no review process for artifacts (other than that they must be
related to work on effect handlers). Whilst we do not enforce any
standards on artifacts, we do recommend that artifacts conform with
[the artifacts evaluation packaging guidelines used by various
programming language
conferences](https://artifact-eval.org/guidelines.html).
