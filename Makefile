DOCKERHUB=effecthandlers/effect-handlers

all: bench_ocaml

sys_ocaml:
	docker build -t $(DOCKERHUB):ocaml systems/ocaml

bench_ocaml: sys_ocaml
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml

sys_koka:
	docker build -t effecthandlers/effect-handlers:koka systems/koka

bench_koka: sys_koka
	docker run -it --init -v $(shell pwd):/source effecthandlers/effect-handlers:koka \
		make -C /source/benchmarks/koka

sys_links:
	docker build -t $(DOCKERHUB):links systems/links

bench_links: sys_links
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links

sys_hia:
	docker build -t $(DOCKERHUB):hia systems/hia

bench_hia: sys_hia
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia

clean:
	rm -f _results *~
