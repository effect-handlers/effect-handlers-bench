LIBSEFF     := /home/ubuntu/libseff
LIBSEFF_H   := $(LIBSEFF)/src
LIBSEFF_LIB := $(LIBSEFF)/output/lib

CC               := clang-14
CC_COMPILE_FLAGS := -std=gnu99 -O3 -I$(LIBSEFF_H) -fsplit-stack 
CC_WARN_FLAGS    := -Wall -Wextra \
									  -Wformat=2 -Wno-unused-parameter -Wshadow \
										-Wwrite-strings -Wstrict-prototypes -Wold-style-definition \
										-Wredundant-decls -Wnested-externs -Wmissing-include-dirs
CC_LINK_FLAGS    := -std=gnu99 -O3

LD         := $(shell which ld.gold)
LD_FLAGS   := -fuse-ld=$(LD) -l:libseff.a -l:libutils.a -L$(LIBSEFF_LIB)

compile_cmd = $(CC)	$(CC_COMPILE_FLAGS) $(CC_WARN_FLAGS) -o main.o -c main.c
link_cmd    = $(CC) $(CC_LINK_FLAGS) -o main main.o $(LD_FLAGS)
build_cmd   = cd $(1) ; $(call compile_cmd, $(1)); $(call link_cmd, $(1))
test_cmd    = cd $(1) ; ./main $(2) > actual ; echo $(3) > expected ; diff expected actual

bench: build
	hyperfine --export-csv results.csv \
					'./countdown/main 200000000' \
					'./fibonacci_recursive/main 42' \
					'./product_early/main 100000' \
					'./iterator/main 40000000' \
					'./generator/main 25' \
					'./parsing_dollars/main 20000' \
					'./resume_nontail/main 20000' \
					'./handler_sieve/main 60000'

test: build
	$(call test_cmd, countdown, 5, 0)
	$(call test_cmd, fibonacci_recursive, 5, 5)
	$(call test_cmd, product_early, 5, 0)
	$(call test_cmd, iterator, 5, 15)
	$(call test_cmd, generator, 5, 57)
	$(call test_cmd, parsing_dollars, 10, 55)
	$(call test_cmd, resume_nontail, 5, 37)
	$(call test_cmd, handler_sieve, 10, 17)

build: 
	$(call build_cmd, countdown)
	$(call build_cmd, fibonacci_recursive)
	$(call build_cmd, product_early)
	$(call build_cmd, iterator)
	$(call build_cmd, generator)
	$(call build_cmd, parsing_dollars)
	$(call build_cmd, resume_nontail)
	$(call build_cmd, handler_sieve)

clean:
	-rm */main
	-rm */expected
	-rm */actual
	-rm */*.o
	-rm */*.out