OUT=elm.js
NUKE=rm -rf

help:
	@cat Makefile

build: $(OUT)

clean:
	$(NUKE) $(OUT)

elm.js:
	elm make Example.elm Interact.elm --warn --output=elm.js

run:
	node index.js < Makefile

b: build
r: run
