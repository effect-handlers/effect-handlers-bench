all: bench_ocaml bench_koka

sys_ocaml:
	docker build -t effecthandlers/effect-handlers:ocaml systems/ocaml

bench_ocaml: sys_ocaml
	docker run -v $(shell pwd):/source effecthandlers/effect-handlers:ocaml \
		make -C /source/benchmarks/ocaml

sys_koka:
	docker build -t effecthandlers/effect-handlers:koka systems/koka

bench_koka: sys_koka
	docker run -v $(shell pwd):/source effecthandlers/effect-handlers:koka \
		make -C /source/benchmarks/koka

clean:
	rm -f _results *~
