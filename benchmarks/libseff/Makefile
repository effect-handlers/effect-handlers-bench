LIBSEFF     := /home/ubuntu/libseff
LIBSEFF_H   := $(LIBSEFF)/src
LIBSEFF_LIB := $(LIBSEFF)/output/lib

CC               := clang-10
CC_COMPILE_FLAGS := -O2 -I$(LIBSEFF_H)
CC_LINK_FLAGS    := -O2

LD         := $(shell which ld.gold)
LD_FLAGS   := -fuse-ld=$(LD) -l:libseff.a -l:libutils.a -L$(LIBSEFF_LIB)

compile_cmd = $(CC)	$(CC_COMPILE_FLAGS) -o main.o -c main.c 
link_cmd    = $(CC) $(CC_LINK_FLAGS) -o main main.o $(LD_FLAGS)
build_cmd   = cd $(1) ; $(call compile_cmd, $(1)); $(call link_cmd, $(1))

# Only use the last line of actual output, the rest is libseff debugging info
test_cmd    = cd $(1) ; ./main $(2) > all_actual ; tail -1 all_actual > actual ; echo $(3) > expected ; diff expected actual

bench: build
	hyperfine --export-csv results.csv \
					'./countdown/main 200000000'

test: build
	$(call test_cmd, countdown, 5, 0)

build: 
	$(call build_cmd, countdown)

clean:
	-rm */main
	-rm */expected
	-rm */actual
	-rm */all_actual
	-rm */*.o
	-rm */*.out