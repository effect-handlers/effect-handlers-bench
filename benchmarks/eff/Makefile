bench: build
	hyperfine --export-csv results.csv \
		'001_nqueens/main 13' \
		'002_generator/main 25' \
		'003_tree_explore/main 16' \
		'004_triples/main 300 300' \
		'007_simple_counter/main 20000'

build:
	cd 001_nqueens ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 002_generator ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 003_tree_explore ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 004_triples ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml
	cd 007_simple_counter ; cp ../OcamlHeader.ml OcamlHeader.ml ; eff.exe --no-stdlib --compile-plain-ocaml main.eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > generated.ml ; opam exec -- ocamlopt -O3 -o main OcamlHeader.ml generated.ml wrapper.ml

compile_eff_file:
	rm $(BENCHMARK-NAME)/generated_$(BENCHMARK-NAME).ml
	eff.exe --no-stdlib --compile-plain-ocaml $(BENCHMARK-NAME)/$(BENCHMARK-NAME).eff | opam exec -- ocamlformat - --name=temp.ml --enable-outside-detected-project > $(BENCHMARK-NAME)/generated_$(BENCHMARK-NAME).ml

compile_ocaml_files:
	opam exec -- dune build

run_compiled_file:
	$(BENCHMARK-NAME)/wrapper_$(BENCHMARK-NAME).exe $(ARGS) > $(BENCHMARK-NAME).out

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

