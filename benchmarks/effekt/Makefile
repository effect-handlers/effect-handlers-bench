bench: build
	hyperfine --export-csv results.csv \
		'countdown/out/main 200000000' \
		'fibonacci_recursive/out/main 42' \
		'product_early/out/main 100000' \
		'iterator/out/main 40000000' \
		'nqueens/out/main 12' \
		'tree_explore/out/main 16' \
		'triples/out/main 300' \
		'parsing_dollars/out/main 20000' \
		'resume_nontail/out/main 20000'

test: build
	cd countdown ; ./out/main 5 > actual ; echo 0 > expected ; diff expected actual
	cd fibonacci_recursive ; ./out/main 5 > actual ; echo 5 > expected ; diff expected actual
	cd product_early ; ./out/main 5 > actual ; echo 0 > expected ; diff expected actual
	cd iterator ; ./out/main 5 > actual ; echo 15 > expected ; diff expected actual
	cd nqueens ; ./out/main 5 > actual ; echo 10 > expected ; diff expected actual
	cd tree_explore ; ./out/main 5 > actual ; echo 946 > expected ; diff expected actual
	cd triples ; ./out/main 10 > actual ; echo 779312 > expected ; diff expected actual
	cd parsing_dollars ; ./out/main 10 > actual ; echo 55 > expected ; diff expected actual
	cd resume_nontail ; ./out/main 5 > actual ; echo 37 > expected ; diff expected actual

build:
	cd countdown ; effekt.sh --backend llvm --build main.effekt
	cd fibonacci_recursive ; effekt.sh --backend llvm --build main.effekt
	cd product_early ; effekt.sh --backend llvm --build main.effekt
	cd iterator ; effekt.sh --backend llvm --build main.effekt
	cd nqueens ; effekt.sh --backend llvm --build main.effekt
	cd tree_explore ; effekt.sh --backend llvm --build main.effekt
	cd triples ; effekt.sh --backend llvm --build main.effekt
	cd parsing_dollars ; effekt.sh --backend llvm --build main.effekt
	cd resume_nontail ; effekt.sh --backend llvm --build main.effekt

clean:
	-rm -r */out/
	-rm results.csv
	-rm */expected
	-rm */actual
