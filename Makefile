BIN=bin
OUT=$(BIN)/elm.js
SRC=src
NUKE=rm -rf

EXAMPLE_FILE=README.md

SRCS=$(shell find $(SRC) -name \*.elm)

help:
	@cat Makefile

build: $(OUT)

clean:
	$(NUKE) $(OUT)

$(OUT):
	elm make $(SRCS) --warn --output=$(OUT)

demo-lower:
	node $(BIN)/toLower.js < $(EXAMPLE_FILE)

demo-multi:
	node $(BIN)/multi.js reverse toUpper < $(EXAMPLE_FILE)

demo-reverse:
	node $(BIN)/reverse.js < $(EXAMPLE_FILE)

demo-upper:
	node $(BIN)/toUpper.js < $(EXAMPLE_FILE)

demo-make-index:
	node $(BIN)/makeIndex.js "Examples.Multi" < template.js > made-index.js

b: build

dl: demo-lower
dm: demo-multi
dmi: demo-make-index
dr: demo-reverse
du: demo-upper
