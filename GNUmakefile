# vim:set ft=make ts=4 sw=4 sts=4 autoindent:

# Makefile.
#
# Author:	Pontus Stenetorp	<pontus stenetorp se>
# Version:	2014-12-23

JULIA_CMD=julia

SRC=${shell find src test -name '*.jl'}

.DEFAULT_GOAL:=test
.PHONY: test
test: JULIA_CMD+=--check-bounds=yes --load src/Hinton.jl
test:
	${JULIA_CMD} test/runtests.jl

.PHONY: coverage
coverage: JULIA_CMD+=--code-coverage
coverage: test

define EXAMPLE_JL
using Hinton

srand(0x4711)
w = eye(17, 17) + randn(17, 17)
println(hintontxt(w))
println("Make a screenshot of the diagram above (use font size 19).")
draw(PNG("example_vec.png", 256px, 256px), hintonvec(w))
endef
export EXAMPLE_JL
example_vec.png: JULIA_CMD+=--load src/Hinton.jl
example_vec.png: ${SRC}
	${JULIA_CMD} -e "$${EXAMPLE_JL}"
	optipng $@

.PHONY: example
example: example_vec.png

.PHONY: clean
clean:
	rm -f example_vec.png
