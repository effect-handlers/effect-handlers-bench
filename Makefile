all: bench_ocaml

sys_ocaml:
	docker build -t effecthandlers/effect-handlers:ocaml systems/ocaml

bench_ocaml: sys_ocaml
	docker run -v $(shell pwd):/source effecthandlers/effect-handlers:ocaml \
		make -C /source/benchmarks/ocaml

clean:
	rm -f _results *~
