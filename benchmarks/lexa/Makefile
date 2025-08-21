bench: build
	hyperfine --export-csv results.csv \
		'countdown/main 200000000' \
		'fibonacci_recursive/main 42' \
		'product_early/main 100000' \
		'iterator/main 40000000' \
		'nqueens/main 12' \
		'generator/main 25' \
		'tree_explore/main 16' \
		'triples/main 300' \
		'parsing_dollars/main 20000' \
		'resume_nontail/main 20000' \
		'handler_sieve/main 60000'

test: build
	cd countdown ; ./main 5 > actual ; echo 0 > expected ; diff expected actual
	cd fibonacci_recursive ; ./main 5 > actual ; echo 5 > expected ; diff expected actual
	cd product_early ; ./main 5 > actual ; echo 0 > expected ; diff expected actual
	cd iterator ; ./main 5 > actual ; echo 15 > expected ; diff expected actual
	cd nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual
	cd tree_explore ; ./main 5 > actual ; echo 946 > expected ; diff expected actual
	cd triples ; ./main 10 > actual ; echo 779312 > expected ; diff expected actual
	cd parsing_dollars ; ./main 10 > actual ; echo 55 > expected ; diff expected actual
	cd resume_nontail ; ./main 5 > actual ; echo 37 > expected ; diff expected actual
	cd handler_sieve ; ./main 10 > actual ; echo 17 > expected ; diff expected actual

build:
	cd countdown ; lexa main.lx -o main
	cd fibonacci_recursive ; lexa main.lx -o main
	cd product_early ; lexa main.lx -o main
	cd iterator ; lexa main.lx -o main
	cd nqueens ; lexa main.lx -o main
	cd generator ; lexa main.lx -o main
	cd tree_explore ; lexa main.lx -o main
	cd triples ; lexa main.lx -o main
	cd parsing_dollars ; lexa main.lx -o main
	cd resume_nontail ; lexa main.lx -o main
	cd handler_sieve ; lexa main.lx -o main

clean:
	-rm */clue_table.txt
	-rm */main.c
	-rm */offset_functions.h
	-rm */main
	-rm results.csv
	-rm */expected
	-rm */actual
