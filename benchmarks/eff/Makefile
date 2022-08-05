all:
	# TODO: generalize copy pasted code
	# Compile to ocaml
	rm benchmarks/*/generated_*.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/001_nqueens/001_nqueens.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/001_nqueens/generated_001_nqueens.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/002_generator/002_generator.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/002_generator/generated_002_generator.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/003_tree_explore/003_tree_explore.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/003_tree_explore/generated_003_tree_explore.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/004_triples/004_triples.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/004_triples/generated_004_triples.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/007_simple_counter/007_simple_counter.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/007_simple_counter/generated_007_simple_counter.ml
	# Build executables
	opam exec -- dune build
	hyperfine --export-csv eff.csv \
		'./_build/default/benchmarks/001_nqueens/wrapper_001_nqueens.exe 13' \
		'./_build/default/benchmarks/002_generator/wrapper_002_generator.exe 25' \
		'./_build/default/benchmarks/003_tree_explore/wrapper_003_tree_explore.exe 16' \
		'./_build/default/benchmarks/004_triples/wrapper_004_triples.exe 300 300' \
		'./_build/default/benchmarks/007_simple_counter/wrapper_007_simple_counter.exe 20000'
	# Clean generated ocaml files
	make -C . clean
	# Move results to the root of the repository
	mkdir -p ../../results
	mv eff.csv ../../results

ci_test: compile_eff_file compile_ocaml_files run_compiled_file

compile_eff_file:
	rm benchmarks/$(BENCHMARK-NAME)/generated_$(BENCHMARK-NAME).ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/$(BENCHMARK-NAME)/$(BENCHMARK-NAME).eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/$(BENCHMARK-NAME)/generated_$(BENCHMARK-NAME).ml

compile_ocaml_files:
	opam exec -- dune build

run_compiled_file:
	./_build/default/benchmarks/$(BENCHMARK-NAME)/wrapper_$(BENCHMARK-NAME).exe $(ARGS) > $(BENCHMARK-NAME).out

clean:
	opam exec -- dune clean
