BUILD_DIRS = HIA 001_nqueens
BUILD_DIRS_CLEAN = $(addsuffix clean,$(BUILD_DIRS))

all:
	# Compile
	ghc -O2 001_nqueens/NQueens.hs
	# Run benchmarks
	hyperfine --export-csv hia.csv \
		'./001_nqueens/NQueens 13'
	#Cleanup
	make -C . clean
	#Copy results to the root of the repository
	mkdir -p ../../results
	mv hia.csv ../../results

clean: $(BUILD_DIRS_CLEAN)
	rm -fv 001_nqueens/NQueens

clean-build-dir:
	rm -fv *.hi *.o *.dyn_hi *.dyn_o

%clean: %
	$(MAKE) -C $< -f $(shell pwd)/Makefile clean-build-dir
