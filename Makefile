BIN=bin
OUT=$(BIN)/elm.js
SRC=src
NUKE=rm -rf

EXAMPLE_FILE=README.md
TEMPLATE=template.js

SRCS=$(shell find $(SRC) -name \*.elm)

help:
	@cat Makefile

build: $(OUT)

clean:
	$(NUKE) $(OUT)

$(OUT):
	elm make $(SRCS) --warn --output=$(OUT)

demo-fail:
	node $(BIN/fail.sj < $(EXAMPLE_FILE)

demo-lower:
	node $(BIN)/toLower.js < $(EXAMPLE_FILE)

demo-multi:
	node $(BIN)/multi.js reverse toUpper < $(EXAMPLE_FILE)

demo-reverse:
	node $(BIN)/reverse.js < $(EXAMPLE_FILE)

demo-upper:
	node $(BIN)/toUpper.js < $(EXAMPLE_FILE)

demo-make-index:
	node $(BIN)/makeIndex.js "Examples.Multi" < $(TEMPLATE) > made-index.js

make-indexes:
	node $(BIN)/makeIndex.js "Examples.MakeIndex" < $(TEMPLATE) > $(BIN)/makeIndex.js.tmp
	mv $(BIN)/makeIndex.js.tmp $(BIN)/makeIndex.js
	node $(BIN)/makeIndex.js "Examples.Fail" < $(TEMPLATE) > $(BIN)/fail.js
	node $(BIN)/makeIndex.js "Examples.Multi" < $(TEMPLATE) > $(BIN)/multi.js
	node $(BIN)/makeIndex.js "Examples.Reverse" < $(TEMPLATE) > $(BIN)/reverse.js
	node $(BIN)/makeIndex.js "Examples.ToLower" < $(TEMPLATE) > $(BIN)/toLower.js
	node $(BIN)/makeIndex.js "Examples.ToUpper" < $(TEMPLATE) > $(BIN)/toUpper.js

b: build

df: demo-fail
dl: demo-lower
dm: demo-multi
dmi: demo-make-index
dr: demo-reverse
du: demo-upper
mi: make-indexes
