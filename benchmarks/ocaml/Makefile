all:
	#Build OCaml benchmarks
	opam exec --switch=4.12.0+domains+effects -- dune build
	#Run OCaml benchmarks
	hyperfine --export-csv ocaml.csv \
		'./_build/default/001_nqueens/001_nqueens_ocaml.exe 13' \
		'./_build/default/002_generator/002_generator_ocaml.exe 25' \
		'./_build/default/003_tree_explore/003_tree_explore.exe 16' \
		'./_build/default/004_triples/004_triples.exe 300 300'
	#Cleanup
	opam exec --switch=4.12.0+domains+effects -- dune clean
	#Copy results to the root of the repository
	mkdir -p ../../results
	mv ocaml.csv ../../results
