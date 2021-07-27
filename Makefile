all: bench_ocaml

sys_ocaml:
	docker build -t effecthandlers/effect-handlers:ocaml systems/ocaml

bench_ocaml: sys_ocaml
	ls -l
	whoami
	docker run --privileged \
		-v $(shell pwd):/source effecthandlers/effect-handlers:ocaml \
		make -C /source/benchmarks/ocaml

clean:
	rm -f _results *~
