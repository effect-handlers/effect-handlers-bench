BUILD_DIRS = HIA 001_nqueens 002_generator
BUILD_DIRS_CLEAN = $(addsuffix clean,$(BUILD_DIRS))

all:
	# Compile
	ghc -O2 001_nqueens/001_nqueens.hs
	ghc -O2 002_generator/002_generator.hs
	# Run benchmarks
	hyperfine --export-csv hia.csv \
		'./001_nqueens/001_nqueens 13' \
                './002_generator/002_generator 25'
	#Cleanup
	make -C . clean
	#Copy results to the root of the repository
	mkdir -p ../../results
	mv hia.csv ../../results

ci_test: compile_hs_file run_compiled_file

compile_hs_file:
	ghc -O2 $(BENCHMARK-NAME)/$(BENCHMARK-NAME).hs

run_compiled_file:
	./$(BENCHMARK-NAME)/$(BENCHMARK-NAME) $(ARGS) > $(BENCHMARK-NAME).out

clean: $(BUILD_DIRS_CLEAN)
	rm -fv 001_nqueens/001_nqueens 002_generator/002_generator

clean-build-dir:
	rm -fv *.hi *.o *.dyn_hi *.dyn_o

%clean: %
	$(MAKE) -C $< -f $(shell pwd)/Makefile clean-build-dir
