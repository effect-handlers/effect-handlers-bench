bench: build
	hyperfine --export-csv results.csv \
		'./nqueens/main 13' \
		'./generator/main 25' \
		'./tree_explore/main 16' \
		'./triples/main 300 300' \
		'./resume_nontail/main 20000'

test: build
	cd nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual
	cd tree_explore ; ./main 5 > actual ; echo 946 > expected ; diff expected actual
	cd triples ; ./main 10 10 > actual ; echo 779312 > expected ; diff expected actual
	cd resume_nontail ; ./main 5 > actual ; echo 37 > expected ; diff expected actual

build:
	cd nqueens ; koka -O3 -o main main.kk ; chmod +x main
	cd generator ; koka -O3 -o main main.kk ; chmod +x main
	cd tree_explore ; koka -O3 -o main main.kk ; chmod +x main
	cd triples ; koka -O3 -o main main.kk ; chmod +x main
	cd resume_nontail ; koka -O3 -o main main.kk ; chmod +x main

clean:
	-rm -r */.koka/
	-rm */main
	-rm results.csv
	-rm */expected
	-rm */actual
