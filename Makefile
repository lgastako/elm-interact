OUT=elm.js
NUKE=rm -rf

help:
	@cat Makefile

build: $(OUT)

clean:
	$(NUKE) $(OUT)

elm.js:
	elm make Examples/*.elm Interact.elm --warn --output=elm.js

demo-multi:
	node multi.js reverse toUpper < Makefile

b: build
r: run
