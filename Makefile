all: bench_ocaml

DOCKERHUB=effecthandlers/effect-handlers

sys_ocaml:
	docker build -t $(DOCKERHUB):ocaml systems/ocaml

bench_ocaml: sys_ocaml
	docker run -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml

sys_links:
	docker build -t $(DOCKERHUB):links systems/links

bench_links:
	docker run -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links

clean:
	rm -f _results *~
