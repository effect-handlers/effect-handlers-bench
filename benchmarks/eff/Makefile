all:
	# Compile to ocaml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/001_nqueens/001_nqueens.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/001_nqueens/generated_001_nqueens.ml
	eff.exe --no-stdlib --compile-plain-ocaml benchmarks/002_generator/002_generator.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > benchmarks/002_generator/generated_002_generator.ml
	# Build executables
	opam exec -- dune build
	hyperfine --export-csv eff.csv \
		'./_build/default/benchmarks/001_nqueens/nqueens.exe 13' \
		'./_build/default/benchmarks/002_generator/generator.exe 25'	 
	# Clean generated ocaml files
	make -C . clean
	# Move results to the root of the repository
	mkdir -p ../../results
	mv eff.csv ../../results

clean:
	opam exec -- dune clean
	rm -r benchmarks/*/generated_*.ml
