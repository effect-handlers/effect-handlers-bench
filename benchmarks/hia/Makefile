bench: build
	hyperfine --export-csv hia.csv \
		'./001_nqueens/001_nqueens 13' \
		'./002_generator/002_generator 25'

test: build
	cd 001_nqueens ; ./main 5 > actual ; echo 10 > expected ; diff expected actual && echo "ok" > result
	cd 002_generator ; ./main 5 > actual ; echo 57 > expected ; diff expected actual && echo "ok" > result

build:
	cd 001_nqueens ; cp -r ../HIA HIA ; ghc -O2 -o main Main.hs
	cd 002_generator ; cp -r ../HIA HIA ; ghc -O2 -o main Main.hs

clean:
	-rm */main
	-rm -r */HIA
	-rm */expected
	-rm */actual
	-rm */result
