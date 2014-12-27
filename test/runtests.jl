# vim:set ft=julia ts=4 sw=4 sts=4 autoindent:

# Run the test suite.
#
# Author:   Pontus Stenetorp    <pontus stenetorp se>
# Version:  2014-12-23

using Hinton

function runtests()
    srand(0x4711)
    w = eye(7, 17) + randn(7, 17)
    open("/dev/null", "w") do f
        println(f, hintontxt(w))
        println(f, hintonvec(w))
    end
end
runtests()
