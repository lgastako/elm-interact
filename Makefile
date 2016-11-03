OUT=elm.js
NUKE=rm -rf

help:
	@cat Makefile

build: $(OUT)

clean:
	$(NUKE) $(OUT)

elm.js:
	elm make Interact.elm --warn --output=elm.js

b: build
