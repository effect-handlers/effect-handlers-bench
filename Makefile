all: bench_ocaml

sys_ocaml:
	docker build -t effect-handlers:ocaml systems/ocaml

OCAML_BENCH_DIR=/source/benchmarks/ocaml
OCAML_EXE_BASEDIR=$(OCAML_BENCH_DIR)/_build/default

bench_helper_ocaml:
	$(eval DIR := $(shell pwd))
	#Build OCaml benchmarks
	cd $(OCAML_BENCH_DIR)
	opam exec --switch=4.12.0+domains+effects -- dune build
	#Run OCaml benchmarks
	hyperfine --export-csv ocaml.csv --show-output \
		'$(OCAML_EXE_BASEDIR)/001_nqueens/001_nqueens_ocaml.exe 22' \
		'$(OCAML_EXE_BASEDIR)/002_generator/002_generator_ocaml.exe 25'
	#Cleanup
	dune clean
	cp ocaml.csv $(DIR)

bench_ocaml: sys_ocaml
	docker run -v $(shell pwd):/source effect-handlers:ocaml \
		make -C /source bench_helper_ocaml

clean:
	rm -f *.csv *~
