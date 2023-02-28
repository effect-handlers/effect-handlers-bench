all:
	# TODO: generalize copy pasted code
	# Compile to ocaml
	eff.exe --no-stdlib --compile-plain-ocaml 001_nqueens/001_nqueens.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > 001_nqueens/generated_001_nqueens.ml
	eff.exe --no-stdlib --compile-plain-ocaml 002_generator/002_generator.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > 002_generator/generated_002_generator.ml
	eff.exe --no-stdlib --compile-plain-ocaml 003_tree_explore/003_tree_explore.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > 003_tree_explore/generated_003_tree_explore.ml
	eff.exe --no-stdlib --compile-plain-ocaml 004_triples/004_triples.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > 004_triples/generated_004_triples.ml
	eff.exe --no-stdlib --compile-plain-ocaml 007_simple_counter/007_simple_counter.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > 007_simple_counter/generated_007_simple_counter.ml
	# Build executables
	opam exec -- dune build
	hyperfine --export-csv eff.csv \
		'./_build/default/001_nqueens/wrapper_001_nqueens.exe 13' \
		'./_build/default/002_generator/wrapper_002_generator.exe 25' \
		'./_build/default/003_tree_explore/wrapper_003_tree_explore.exe 16' \
		'./_build/default/004_triples/wrapper_004_triples.exe 300 300' \
		'./_build/default/007_simple_counter/wrapper_007_simple_counter.exe 20000'
	# Clean generated ocaml files
	make -C . clean
	# Move results to the root of the repository
	mkdir -p ../../results
	mv eff.csv ../../results

ci_test: compile_eff_file compile_ocaml_files run_compiled_file

compile_eff_file:
	rm $(BENCHMARK-NAME)/generated_$(BENCHMARK-NAME).ml
	eff.exe --no-stdlib --compile-plain-ocaml $(BENCHMARK-NAME)/$(BENCHMARK-NAME).eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > $(BENCHMARK-NAME)/generated_$(BENCHMARK-NAME).ml

compile_ocaml_files:
	opam exec -- dune build

run_compiled_file:
	./_build/default/$(BENCHMARK-NAME)/wrapper_$(BENCHMARK-NAME).exe $(ARGS) > $(BENCHMARK-NAME).out

clean:
	opam exec -- dune clean
