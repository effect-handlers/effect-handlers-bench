# XXX - Short benchmark name

*Short description of the benchmark in a few sentences.*

## Input

*Describe the type and shape of the input data.
Explicitly state default input to be used in the absence of input argument.
The default input value should be reasonably small so that benchmarks can be computed in a reasonable time (up to a few seconds).*

## Output

*Describe the type and shape of the output data. Prefer to use simple and small output that makes correctness testing easier.*

## Description

*A longer and more detailed description of the benchmark.*

*Clearly describe the algorithm of the benchmark and provide a small example if possible.
If the benchmark relies on more complicated input generated from input value (binary tree, random graph, ...), provide a code sample that generates it from the input parameters.*

*If a specific version of an algorithm is used, provide a detailed description and possible code sample to explain how it should be implemented.*

*Default benchmark size should target a runtime between a second and up to a few seconds.
If the generation of input data is time-consuming, it is ok to run the benchmark multiple times on the same generated input for more accurate results.
Be careful that a smart compiler will not optimize the multiple runs away and clearly state the number of times the computation should be repeated.*

## Sample explanation (optional)

*Optional explanation of benchmark computation on small sample input.*

## Benchmark rationale (optional)

*Provide a short rationale for the benchmark.
Describe what it measures and why it is important to measure it.*

Example:
This benchmark measures the performance of deeply nested handlers.
This is a good benchmark to measure the performance of selecting the correct handler for performed effect.

## Reference (optional)

*If necessary, provide a reference.*

## Output example

*Provide a larger set of input and output data that can be used to verify the correctness of the implementation.
Provide a reasonable range of output parameters and comment on the expected range that should be computed in a reasonable time.*

Example:

| Input param | Square of the input |
|--------|---------------------|
| 0 | 0 |
| 1 | 1 |
| 2 | 4 |
| 3 | 9 |
| 4 | 16 |
| 5 | 25 |
| 6 | 36 |
| 7 | 49 |
| 8 | 64 |
| 9 | 81 |
| 10 | 100 |
| 11 | 121 |
| 12 | 144 |
| 13 | 169 |
