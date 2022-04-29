all:
	koka -O2 benchmarkNQueens.kk -o benchmarkNQueens.kk-out
	koka -O2 benchmarkGenerator.kk -o benchmarkGenerator.kk-out
	koka -O2 benchmarkTreeExplore.kk -o benchmarkTreeExplore.kk-out
	chmod +x *.kk-out
	hyperfine --export-csv koka.csv \
		'./benchmarkNQueens.kk-out 13' \
		'./benchmarkGenerator.kk-out 25' \
		'./benchmarkTreeExplore.kk-out 16'
	# Clean generated files
	make -C . clean
	# Move results to the root of the repository
	mkdir -p ../../results
	mv koka.csv ../../results

clean:
	rm -r .koka/
	rm *.kk-out
