bench: build
	hyperfine --export-csv results.csv \
		'countdown/main 200000000' \
		'fibonacci_recursive/main 42' \
		'product_early/main 100000' \
		'iterator/main 40000000' \
		'nqueens/main 12' \
		'tree_explore/main 16' \
		'triples/main 300' \
		'parsing_dollars/main 20000' \
		'resume_nontail/main 20000'

test: build
	cd countdown ; ./main 5 > actual ; echo 0 > expected ; diff expected actual
	cd fibonacci_recursive ; ./main 5 > actual ; echo 5 > expected ; diff expected actual
	cd product_early ; ./main 5 > actual ; echo 0 > expected ; diff expected actual
	cd iterator ; ./main 5 > actual ; echo 15 > expected ; diff expected actual
	cd nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd tree_explore ; ./main 5 > actual ; echo 946 > expected ; diff expected actual
	cd triples ; ./main 10 > actual ; echo 779312 > expected ; diff expected actual
	cd parsing_dollars ; ./main 10 > actual ; echo 55 > expected ; diff expected actual
	cd resume_nontail ; ./main 5 > actual ; echo 37 > expected ; diff expected actual

build:
	cd countdown ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd fibonacci_recursive ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd product_early ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd iterator ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd nqueens ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd tree_explore ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd triples ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd parsing_dollars ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml
	cd resume_nontail ; effekt.sh --backend ml --compile main.effekt ; mlton -default-type int64 -output main out/main.sml

clean:
	-rm -r */out/
	-rm */main
	-rm results.csv
	-rm */expected
	-rm */actual
