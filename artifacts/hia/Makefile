DOCKERHUB=effecthandlers/effect-handlers

system:
	docker build -t $(DOCKERHUB):hia ../../systems/hia

benchmark: system
	docker run -it --init -v $(shell pwd):/source $(DOCKERHUB):hia \
		make -C /source all

all: checkout compile run

checkout:
	test -s effect-handlers || \
		git clone --branch ghc865 --single-branch https://github.com/slindley/effect-handlers.git

compile:
	cd effect-handlers/; \
	ghc -O2 Benchmarks/TestState.hs; \
	ghc -O2 Benchmarks/TestQueens.hs; \
	ghc -O2 Benchmarks/TestPipes.hs; \
	ghc -O2 Benchmarks/TestAOP.hs

run:
	cd effect-handlers/; \
	Benchmarks/TestState; \
	Benchmarks/TestQueens; \
	Benchmarks/TestPipes; \
	Benchmarks/TestAOP

clean:
	rm -vf effect-handlers/Benchmarks/TestState
	rm -vf effect-handlers/Benchmarks/TestQueens
	rm -vf effect-handlers/Benchmarks/TestPipes
	rm -vf effect-handlers/Benchmarks/TestAOP
	find . -iname "*.dyn_o" -delete
	find . -iname "*.hi" -delete
	find . -iname "*.o" -delete
	find . -iname "*.dyn_hi" -delete
