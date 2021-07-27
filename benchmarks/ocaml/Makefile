all:
	#Build OCaml benchmarks
	opam exec --switch=4.12.0+domains+effects -- dune build
	#Run OCaml benchmarks
	hyperfine --export-csv ocaml.csv \
		'./_build/default/001_nqueens/001_nqueens_ocaml.exe 22' \
		'./_build/default/002_generator/002_generator_ocaml.exe 25'
	#Cleanup
	opam exec --switch=4.12.0+domains+effects -- dune clean
	#Copy results to the root of the repository
	mkdir -p ../../results
	mv ocaml.csv ../../results
