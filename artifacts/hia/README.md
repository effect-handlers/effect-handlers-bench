# Handlers in Action benchmark suite

This directory contains a script for downloading, compiling, and
running the benchmark suite from the ICFP 2013 paper "Handlers in
Action" by Ohad Kammar, Sam Lindley, Nicolas Oury. (The benchmark
suite has been adapted to run with GHC 8.6.5.)

To download, compile, and run the benchmark suite after the
appropriate Docker image has been built do:

```bash
$ make benchmark
```

Alternatively, you can just download the source code with:

```bash
$ make checkout
```
