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
	node bin/makeIndex.js "Examples.Fail" < $(TEMPLATE) > bin/fail.js
	node bin/makeIndex.js "Examples.MakeIndex" < $(TEMPLATE) > bin/makeIndex.js
	node bin/makeIndex.js "Examples.Multi" < $(TEMPLATE) > bin/multi.js
	node bin/makeIndex.js "Examples.Reverse" < $(TEMPLATE) > bin/reverse.js
	node bin/makeIndex.js "Examples.ToLower" < $(TEMPLATE) > bin/toLower.js
	node bin/makeIndex.js "Examples.ToUpper" < $(TEMPLATE) > bin/toUppwer.js

b: build

dl: demo-lower
dm: demo-multi
dmi: demo-make-index
dr: demo-reverse
du: demo-upper
