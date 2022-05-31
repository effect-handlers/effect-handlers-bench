DOCKERHUB=effecthandlers/effect-handlers

all: bench_eff bench_hia bench_koka bench_links bench_ocaml

# Eff in ocaml
sys_eff:
	docker build -t $(DOCKERHUB):eff systems/eff

bench_eff: sys_eff
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff

ci_bench_eff: sys_eff
	docker run -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff

ci_test_eff:
	docker run -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff ci_test BENCHMARK-NAME=$(BENCHMARK-NAME) ARGS='$(ARGS)'

# Handlers in Action
sys_hia:
	docker build -t $(DOCKERHUB):hia systems/hia

bench_hia: sys_hia
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia

ci_bench_hia: sys_hia
	docker run -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia

# Koka
sys_koka:
	docker build -t effecthandlers/effect-handlers:koka systems/koka

bench_koka: sys_koka
	docker run -it --init -v $(shell pwd):/source effecthandlers/effect-handlers:koka \
		make -C /source/benchmarks/koka

ci_bench_koka: sys_koka
	docker run -v $(shell pwd):/source effecthandlers/effect-handlers:koka \
		make -C /source/benchmarks/koka

# libmpeff
sys_libmpeff:
	docker build -t effecthandlers/effect-handlers:libmpeff systems/libmpeff

bench_libmpeff: sys_libmpeff
	docker run -it --init -v $(shell pwd):/source effecthandlers/effect-handlers:libmpeff \
		make -C /source/benchmarks/libmpeff

ci_bench_libmpeff: sys_libmpeff
	docker run -v $(shell pwd):/source effecthandlers/effect-handlers:libmpeff \
		make -C /source/benchmarks/libmpeff

# Links
sys_links:
	docker build -t $(DOCKERHUB):links systems/links

bench_links: sys_links
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links

ci_bench_links: sys_links
	docker run -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links

# libhandler
sys_libhandler:
	docker build -t $(DOCKERHUB):libhandler systems/libhandler

bench_libhandler: sys_libhandler
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):libhandler \
		make -C /source/benchmarks/libhandler

ci_bench_libhandler: sys_libhandler
	docker run -v $(shell pwd):/source $(DOCKERHUB):libhandler \
		make -C /source/benchmarks/libhandler

# Multicore OCaml
sys_ocaml:
	docker build -t $(DOCKERHUB):ocaml systems/ocaml

bench_ocaml: sys_ocaml
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml

ci_bench_ocaml: sys_ocaml
	docker run -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml

clean:
	rm -f _results *~
