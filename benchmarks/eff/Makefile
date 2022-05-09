all:
	# Compile to ocaml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/001_nqueens/001_nqueens.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/001_nqueens/generated_001_nqueens.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/002_generator/002_generator.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/002_generator/generated_002_generator.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/003_tree_explore/003_tree_explore.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/003_tree_explore/generated_003_tree_explore.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/004_triples/004_triples.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/004_triples/generated_004_triples.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/006_simple_counter/006_simple_counter.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/006_simple_counter/generated_006_simple_counter.ml
	# Build executables
	opam exec -- dune build
	hyperfine --export-csv eff.csv \
		'./_build/default/benchmarks/001_nqueens/nqueens.exe 13' \
		'./_build/default/benchmarks/002_generator/generator.exe 25' \
		'./_build/default/benchmarks/003_tree_explore/tree_explore.exe 16' \
		'./_build/default/benchmarks/004_triples/triples.exe 300 300' \
		'./_build/default/benchmarks/006_simple_counter/simple_counter.exe 100000'
	# Clean generated ocaml files
	make -C . clean
	# Move results to the root of the repository
	mkdir -p ../../results
	mv eff.csv ../../results

clean:
	opam exec -- dune clean
	rm -r benchmarks/*/generated_*.ml
