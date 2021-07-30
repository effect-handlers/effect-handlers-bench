# Handlers in Action benchmark suite

This directory contains a script for downloading, compiling, and
running the benchmark suite from the ICFP 2012 paper "Handlers in
Action" by Ohad Kammar, Sam Lindley, Nicolas Oury. However, do note
that the benchmark suite has been adapted to be runnable with GHC
8.6.5.

To download, compile, and run the benchmark suite simply run the
prepared Handlers in Action Docker image as follows.

```bash
$ docker run -v $(pwd):/source effecthandlers/effect-handlers:hia make -C /source all
```

Alternatively, you can simply download the source code by invoking the
`checkout` command.

```bash
$ make checkout
```
