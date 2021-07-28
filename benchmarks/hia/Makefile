all:
	# Compile
	ghc -O2 001_nqueens.hs
	# Run benchmarks
	hyperfine --export-csv hia.csv \
		'./001_nqueens 22'
	#Cleanup
	rm *.hi *.dyn_hi *.o *.dyn_o
	rm HIA/*.hi HIA/*.dyn_hi HIA/*.o HIA/*.dyn_o
	rm 001_nqueens
	#Copy results to the root of the repository
	mkdir -p ../../results
	mv hia.csv ../../results

