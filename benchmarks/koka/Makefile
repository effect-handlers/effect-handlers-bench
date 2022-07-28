all:
	(cd 001_nqueens ; koka -O3 benchmark.kk -o ../001_nqueens.kk-out)
	(cd 002_generator ; koka -O3 benchmark.kk -o ../002_generator.kk-out)
	(cd 003_tree_explore ; koka -O3 benchmark.kk -o ../003_tree_explore.kk-out)
	(cd 004_triples ; koka -O3 benchmark.kk -o ../004_triples.kk-out)
	(cd 007_simple_counter ; koka -O3 benchmark.kk -o ../007_simple_counter.kk-out)
	chmod +x *.kk-out
	hyperfine --export-csv koka.csv \
		'./001_nqueens.kk-out 13' \
		'./002_generator.kk-out 25' \
		'./003_tree_explore.kk-out 16' \
		'./004_triples.kk-out 300 300' \
		'./007_simple_counter.kk-out 20000'
	# Clean generated files
	make -C . clean
	# Move results to the root of the repository
	mkdir -p ../../results
	mv koka.csv ../../results

ci_test: compile_koka_file run_compiled_file

compile_koka_file:
	(cd $(BENCHMARK-NAME) ; koka -O3 benchmark.kk -o ../$(BENCHMARK-NAME).kk-out)
	chmod +x $(BENCHMARK-NAME).kk-out

run_compiled_file:
	./$(BENCHMARK-NAME).kk-out $(ARGS) > $(BENCHMARK-NAME).out

clean:
	rm -r */.koka/
	rm *.kk-out
