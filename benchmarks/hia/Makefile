BUILD_DIRS = HIA 001_nqueens 002_generator
BUILD_DIRS_CLEAN = $(addsuffix clean,$(BUILD_DIRS))

all:
	# Compile
	ghc -O2 001_nqueens/NQueens.hs
	ghc -O2 002_generator/Generator.hs
	# Run benchmarks
	hyperfine --export-csv hia.csv \
		'./001_nqueens/NQueens 13' \
                './002_generator/Generator 25'
	#Cleanup
	make -C . clean
	#Copy results to the root of the repository
	mkdir -p ../../results
	mv hia.csv ../../results

clean: $(BUILD_DIRS_CLEAN)
	rm -fv 001_nqueens/NQueens 002_generator/Generator

clean-build-dir:
	rm -fv *.hi *.o *.dyn_hi *.dyn_o

%clean: %
	$(MAKE) -C $< -f $(shell pwd)/Makefile clean-build-dir
