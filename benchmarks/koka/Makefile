bench: build
	hyperfine --export-csv results.csv \
		'./001_nqueens/main 13' \
		'./002_generator/main 25' \
		'./003_tree_explore/main 16' \
		'./004_triples/main 300 300' \
		'./007_simple_counter/main 20000'

build:
	cd 001_nqueens ; koka -O3 -o main main.kk ; chmod +x main
	cd 002_generator ; koka -O3 -o main main.kk ; chmod +x main
	cd 003_tree_explore ; koka -O3 -o main main.kk ; chmod +x main
	cd 004_triples ; koka -O3 -o main main.kk ; chmod +x main
	cd 007_simple_counter ; koka -O3 -o main main.kk ; chmod +x main

ci_test: compile_koka_file run_compiled_file

compile_koka_file:
	(cd $(BENCHMARK-NAME) ; koka -O3 main.kk ; chmod +x main)

run_compiled_file:
	./$(BENCHMARK-NAME)/main $(ARGS) > $(BENCHMARK-NAME).out

clean:
	-rm -r */.koka/
	-rm */main
	-rm results.csv
