bench: build
	hyperfine --export-csv results.csv \
		'./countdown/main 200000000' \
		'./fibonacci_recursive/main 42' \
		'./product_early/main 100000' \
		'./iterator/main 40000000' \
		'./nqueens/main 12' \
		'./generator/main 25' \
		'./triples/main 300' \
		'./resume_nontail/main 10000'

test_cmd = cd $(1) ; ./main $(2) > actual ; echo $(3) > expected ; diff expected actual
build_cmd = cd $(1) ; cp -r ../HIA HIA ; ghc -O2 -o main Main.hs

test: build
	$(call test_cmd, countdown, 5, 0)
	$(call test_cmd, fibonacci_recursive, 5, 5)
	$(call test_cmd, product_early, 5, 0)
	$(call test_cmd, iterator, 5, 15)
	$(call test_cmd, nqueens, 5, 10)
	$(call test_cmd, generator, 5, 57)
	$(call test_cmd, triples, 10, 779312)
	$(call test_cmd, resume_nontail, 5, 37)

build:
	$(call build_cmd, countdown)
	$(call build_cmd, fibonacci_recursive)
	$(call build_cmd, product_early)
	$(call build_cmd, iterator)
	$(call build_cmd, nqueens)
	$(call build_cmd, generator)
	$(call build_cmd, triples)
	$(call build_cmd, resume_nontail)

clean:
	-rm */main
	-rm -r */HIA
	-rm */expected
	-rm */actual
	-rm */*.dyn_hi
	-rm */*.dyn_o
	-rm */*.hi
	-rm */*.o
