bench: build
	hyperfine --export-csv results.csv \
		'001_nqueens/main 13' \
		'002_generator/main 25' \
		'003_tree_explore/main 16' \
		'004_triples/main 300 300' \
		'007_simple_counter/main 20000'

test: build
	cd 001_nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd 002_generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual
	cd 003_tree_explore ; ./main 5 > actual ; echo 946 > expected ; diff expected actual
	cd 004_triples ; ./main 10 10 > actual ; echo 779312 > expected ; diff expected actual
	cd 007_simple_counter ; ./main 5 > actual ; echo 37 > expected ; diff expected actual

build:
	cd 001_nqueens ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 002_generator ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 003_tree_explore ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 004_triples ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 007_simple_counter ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml

clean:
	-rm */main
	-rm */generated.ml
	-rm */generated.cmi
	-rm */generated.o
	-rm */generated.cmx
	-rm */wrapper.cmi
	-rm */wrapper.o
	-rm */wrapper.cmx
	-rm */OcamlHeader.ml
	-rm */OcamlHeader.cmi
	-rm */OcamlHeader.o
	-rm */OcamlHeader.cmx
	-rm */expected
	-rm */actual
