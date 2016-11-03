BIN=bin
OUT=$(BIN)/elm.js
SRC=src
NUKE=rm -rf

SRCS=$(shell find $(SRC) -name \*.elm)

help:
	@cat Makefile

build: $(OUT)

clean:
	$(NUKE) $(OUT)

$(OUT):
	elm make $(SRCS) --warn --output=$(OUT)

demo-lower:
	node $(BIN)/toLower.js < Makefile

demo-multi:
	node $(BIN)/multi.js reverse toUpper < Makefile

demo-reverse:
	node $(BIN)/reverse.js < Makefile

demo-upper:
	node $(BIN)/toUpper.js < Makefile

b: build
r: run

dl: demo-lower
dm: demo-multi
dr: demo-reverse
du: demo-upper
