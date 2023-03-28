bench: build
	hyperfine --export-csv results.csv \
		'nqueens/main 13' \
		'generator/main 25' \
		'tree_explore/main 16' \
		'triples/main 300 300' \
		'simple_counter/main 20000'

test: build
	cd nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual
	cd tree_explore ; ./main 5 > actual ; echo 946 > expected ; diff expected actual
	cd triples ; ./main 10 10 > actual ; echo 779312 > expected ; diff expected actual
	cd simple_counter ; ./main 5 > actual ; echo 37 > expected ; diff expected actual

build:
	cd nqueens ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd generator ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd tree_explore ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd triples ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml
	cd simple_counter ; opam exec --switch=4.12.0+domains+effects -- ocamlopt -O3 -o main main.ml

clean:
	-rm */main.cmi
	-rm */main.cmx
	-rm */main.o
	-rm */main
	-rm */expected
	-rm */actual
