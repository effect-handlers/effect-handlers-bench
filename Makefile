DOCKERHUB=effecthandlers/effect-handlers

all: bench_eff bench_hia bench_koka bench_links bench_ocaml

# Eff in ocaml
system_eff:
	docker build -t $(DOCKERHUB):eff systems/eff

bench_eff: system_eff
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff

ci_bench_eff: system_eff
	docker run -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff

ci_test_eff:
	docker run -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff ci_test BENCHMARK-NAME=$(BENCHMARK-NAME) ARGS='$(ARGS)'

# Handlers in Action
system_hia:
	docker build -t $(DOCKERHUB):hia systems/hia

bench_hia: system_hia
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia

ci_bench_hia: system_hia
	docker run -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia

ci_test_hia: system_hia
	docker run -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia ci_test BENCHMARK-NAME=$(BENCHMARK-NAME) ARGS='$(ARGS)'

# Koka
system_koka:
	docker build -t effecthandlers/effect-handlers:koka systems/koka

bench_koka: system_koka
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):koka \
		make -C /source/benchmarks/koka

test_koka: system_koka
	docker run -v $(shell pwd):/source $(DOCKERHUB):koka \
		make -C /source/benchmarks/koka test

# libmpeff
system_libmpeff:
	docker build -t $(DOCKERHUB):libmpeff systems/libmpeff

bench_libmpeff: system_libmpeff
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):libmpeff \
		make -C /source/benchmarks/libmpeff

ci_bench_libmpeff: system_libmpeff
	docker run -v $(shell pwd):/source $(DOCKERHUB):libmpeff \
		make -C /source/benchmarks/libmpeff

# Links
system_links:
	docker build -t $(DOCKERHUB):links systems/links

bench_links: system_links
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links

ci_bench_links: system_links
	docker run -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links

# libhandler
system_libhandler:
	docker build -t $(DOCKERHUB):libhandler systems/libhandler

bench_libhandler: system_libhandler
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):libhandler \
		make -C /source/benchmarks/libhandler

ci_bench_libhandler: system_libhandler
	docker run -v $(shell pwd):/source $(DOCKERHUB):libhandler \
		make -C /source/benchmarks/libhandler

# Multicore OCaml
system_ocaml:
	docker build -t $(DOCKERHUB):ocaml systems/ocaml

bench_ocaml: system_ocaml
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml

ci_bench_ocaml: system_ocaml
	docker run -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml

ci_test_ocaml: system_ocaml
	docker run -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml ci_test BENCHMARK-NAME=$(BENCHMARK-NAME) ARGS='$(ARGS)'

clean:
	rm -f _results *~
