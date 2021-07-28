all:
	# Compile
	ghc -O2 001_nqueens.hs
	# Run benchmarks
	hyperfine --export-csv hia.csv \
		'./001_nqueens 22'
	#Cleanup
	#Copy results to the root of the repository
	mkdir -p ../../results
	mv hia.csv ../../results

