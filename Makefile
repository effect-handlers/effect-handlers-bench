DOCKERHUB=effecthandlers/effect-handlers

all: bench_eff bench_hia bench_koka bench_links bench_ocaml

# Eff in ocaml
system_eff:
	docker build -t $(DOCKERHUB):eff systems/eff

bench_eff: system_eff
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff

test_eff: system_eff
	docker run -v $(shell pwd):/source $(DOCKERHUB):eff \
		make -C /source/benchmarks/eff test

# Effekt
system_effekt:
	docker build -t $(DOCKERHUB):effekt systems/effekt

bench_effekt: system_effekt
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):effekt \
		make -C /source/benchmarks/effekt

test_effekt: system_effekt
	docker run -v $(shell pwd):/source $(DOCKERHUB):effekt \
		make -C /source/benchmarks/effekt test

# Handlers in Action
system_hia:
	docker build -t $(DOCKERHUB):hia systems/hia

bench_hia: system_hia
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia

test_hia: system_hia
	docker run -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source/benchmarks/hia test

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

test_libmpeff: system_libmpeff
	docker run -v $(shell pwd):/source $(DOCKERHUB):libmpeff \
		make -C /source/benchmarks/libmpeff test

# Links
system_links:
	docker build -t $(DOCKERHUB):links systems/links

bench_links: system_links
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links

test_links: system_links
	docker run -v $(shell pwd):/source $(DOCKERHUB):links \
		make -C /source/benchmarks/links test

# libhandler
system_libhandler:
	docker build -t $(DOCKERHUB):libhandler systems/libhandler

bench_libhandler: system_libhandler
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):libhandler \
		make -C /source/benchmarks/libhandler

test_libhandler: system_libhandler
	docker run -v $(shell pwd):/source $(DOCKERHUB):libhandler \
		make -C /source/benchmarks/libhandler test

# Multicore OCaml
system_ocaml:
	docker build -t $(DOCKERHUB):ocaml systems/ocaml

bench_ocaml: system_ocaml
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml

test_ocaml: system_ocaml
	docker run -v $(shell pwd):/source $(DOCKERHUB):ocaml \
		make -C /source/benchmarks/ocaml test

clean:
	rm -f _results *~
