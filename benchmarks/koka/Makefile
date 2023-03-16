bench: build
	hyperfine --export-csv results.csv \
		'./001_nqueens/main 13' \
		'./002_generator/main 25' \
		'./003_tree_explore/main 16' \
		'./004_triples/main 300 300' \
		'./007_simple_counter/main 20000'

test: build
	cd 001_nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd 002_generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual
	cd 003_tree_explore ; ./main 5 > actual ; echo 946 > expected ; diff expected actual
	cd 004_triples ; ./main 10 10 > actual ; echo 779312 > expected ; diff expected actual
	cd 007_simple_counter ; ./main 5 > actual ; echo 37 > expected ; diff expected actual

build:
	cd 001_nqueens ; koka -O3 -o main main.kk ; chmod +x main
	cd 002_generator ; koka -O3 -o main main.kk ; chmod +x main
	cd 003_tree_explore ; koka -O3 -o main main.kk ; chmod +x main
	cd 004_triples ; koka -O3 -o main main.kk ; chmod +x main
	cd 007_simple_counter ; koka -O3 -o main main.kk ; chmod +x main

clean:
	-rm -r */.koka/
	-rm */main
	-rm results.csv
	-rm */expected
	-rm */actual
