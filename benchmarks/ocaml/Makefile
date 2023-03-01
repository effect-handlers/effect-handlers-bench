bench: build
	hyperfine --export-csv results.csv \
		'001_nqueens/main 13' \
		'002_generator/main 25' \
		'003_tree_explore/main 16' \
		'004_triples/main 300 300' \
		'007_simple_counter/main 20000'

build:
	cd 001_nqueens ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd 002_generator ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd 003_tree_explore ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd 004_triples ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd 007_simple_counter ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml

clean:
	-rm */main.cmi
	-rm */main.cmx
	-rm */main.o
	-rm */main

ci_test:
	# Build everything
	opam exec --switch=4.12.0+domains+effects -- dune build
	$(BENCHMARK-NAME)/$(BENCHMARK-NAME)_ocaml.exe $(ARGS) > $(BENCHMARK-NAME).out
