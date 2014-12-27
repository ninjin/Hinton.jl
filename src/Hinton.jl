# vim:set ft=julia ts=4 sw=4 sts=4 autoindent:

# Hinton diagram generation.
#
# Author:   Pontus Stenetorp    <pontus stenetorp se>
# Version:  2014-12-20

# TODO: How do we expose the variants more cleanly?
# TODO: Should we default to SVG/term depending on things like IJulia?

using Compose

module Hinton

export hintontxt, hintonvec

include("text.jl")
include("vector.jl")

end
