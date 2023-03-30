bench: build
	hyperfine --export-csv hia.csv \
		'./nqueens/main 13' \
		'./generator/main 25'

test: build
	cd nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual
	cd generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual

build:
	cd nqueens ; cp -r ../HIA HIA ; ghc -O2 -o main Main.hs
	cd generator ; cp -r ../HIA HIA ; ghc -O2 -o main Main.hs

clean:
	-rm */main
	-rm -r */HIA
	-rm */expected
	-rm */actual
