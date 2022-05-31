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

runs the OCaml benchmarks and produces `_results/ocaml.csv` which contains the
result of running the Multicore OCaml benchmarks.

## Benchmark availability

|              | [Eff](https://github.com/matijapretnar/eff)<br><br>[![Eff](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_eff.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_eff.yml) | [Handlers in Action](https://github.com/slindley/effect-handlers)<br>[![Handlers in Action](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_hia.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_hia.yml) | [Koka](https://github.com/koka-lang/koka)<br><br>[![Koka](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_koka.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_koka.yml) | [libhandler](https://github.com/koka-lang/libhandler)<br><br>[![libhandler](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libhandler.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libhandler.yml) | [libmpeff](https://github.com/koka-lang/libmprompt)<br><br>[![libmpeff](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libmpeff.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_libmpeff.yml) | [Links](https://github.com/links-lang/links)<br><br>[![Links](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_links.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_links.yml) | [Multicore OCaml](https://github.com/ocaml-multicore/ocaml-multicore)<br>[![Multicore OCaml](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_ocaml.yml/badge.svg)](https://github.com/effect-handlers/effect-handlers-bench/actions/workflows/system_ocaml.yml) |
| :----------- | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: | :----------------: |
| **N-queens**<br>Counts the number of solutions to the N queens problem for board size N x N     | :white_check_mark: | :white_check_mark: | :white_check_mark:                | :x: | :x: | :x: | :white_check_mark: |
| **Generator**<br>Count the sum of elements in a complete binary tree using a generator         | :white_check_mark: | :white_check_mark: | :white_check_mark:                | :x: | :x: | :x: | :white_check_mark: |
| **Tree explore**<br>Nondeterministically explore a complete binary tree with additional state   | :white_check_mark: | :x:                | :white_check_mark:                | :x: | :x: | :x: | :white_check_mark:                |
| **Triples**<br>Nondeterministically calculate triples that sum up to specified number   | :white_check_mark: | :x:                | :white_check_mark:                | :x: | :x: | :x: | :white_check_mark:                |
| **Simple counter**<br>Repeatedly apply operation in a non tail position.                | :white_check_mark: | :x:                | :white_check_mark:                | :x: | :x: | :x: | :white_check_mark:                |

Legend:

+ :white_check_mark: : Benchmark is implemented
+ :x: : Benchmark is not implemented
+ :heavy_minus_sign: : Benchmark is unsuitable for this system, and there is no sense in implementing it (eg. benchmarking the speed of file transfer in a language that does not support networking)

## Directory structure

+ `systems/<system_name>/Dockerfile` is the `Dockerfile` in order to build
  the system.
+ `benchmarks/<system_name>/NNN_<benchmark_name>/` contains the source for the
  benchmark `<benchmark_name>` for the system `<system_name>`.
+ `benchmark_descriptions/NNN_<benchmark_name>/` contains the description of
  the benchmark, the input and outputs, and any special considerations.
+ `Makefile` is used to build the systems and benchmarks, and run the
  benchmarks. For each `system`, the Makefile has the following rules:
  - `sys_<system_name>`: Builds the `<system_name>` docker image.
  - `bench_<system_name>`: Runs the benchmarks using the docker image for the
    `<system_name>`.
+ `LABELS.md` contains a list of available benchmark labels.
  Each benchmark can be assigned multiple labels.

## Contributing

### Benchmarking chairs

The role of the benchmarking chairs is to curate the repository,
monitor the quality of benchmarks, and to solicit new benchmarks and
fixes to existing benchmarks. Each benchmarking chair serves two
consecutive terms. Each term is 6 months.

The current co-chairs are

* [Filip Koprivec](https://github.com/jO-Osko) (2022/01/21 - 2022/07/22 - 2023/01/21)
* [Daniel Hillerström](https://github.com/dhil) (In augural chair, 2021/07/23 - 2022/01/22 - 2022/07/23)

### Benchmark

If you wish to add a new benchmark `goat_benchmark` for system `awesome_system`,

+ Pick the next serial number for the benchmark `NNN`.
+ Add the benchmark sources under `benchmarks/<awesome_system>/NNN_<goat_benchmark>`, use the template provided in `benchmark_descriptions/000_template/`.
+ Update the `Makefile` to build and run the benchmark.
+ Add a benchmark description under `benchmark_description/NNN_<goat_benchmark>/readme.md`
  clearly stating the input, output and the expectation from the benchmark. Make sure
  you mention the default input argument for the benchmark.
  Add benchmark inputs and outputs (with their default values) to input/output files.
+ Update this `README.md` file to add the new benchmark to the table of benchmarks and to the benchmark availability table.
+ Add the benchmark to CI testing script.

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
+ create a status badge for the new workflow and add it to to the availability table in
  lexicographic order.

Ideally, you will also add benchmarks to go with the new system and update the benchmark availability table.

Having a dockerfile aids reproducibility and ensures that we can build the system from
scratch natively on a machine if needed. The benchmarking chair will push the image
to [Docker Hub](https://hub.docker.com/repository/docker/effecthandlers/effect-handlers) so
that systems are easily available for wider use.

We use Ubuntu 20.04 as the base image for building the systems and
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
