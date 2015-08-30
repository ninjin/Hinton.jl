# vim:set ft=julia ts=4 sw=4 sts=4 autoindent:

# Hinton diagram generation using text.
#
# Author:   Pontus Stenetorp    <pontus stenetorp se>
# Version:  2014-12-08

# TODO: Add a legend?

immutable HintonTextStyle
    bins::Vector{Char}
    pos ::UTF8String
    neg ::UTF8String
    bg  ::UTF8String
    function HintonTextStyle(syms, pos, neg, bg; mirror_syms=true)
        new(mirror_syms ? vcat(reverse(syms[2:end]), syms) : bins, pos, neg, bg)
    end
end
bins(o::HintonTextStyle) = o.bins
pos(o::HintonTextStyle)  = o.pos
neg(o::HintonTextStyle)  = o.neg
bg(o::HintonTextStyle)   = o.bg
const TEXTSTYLE = HintonTextStyle(
    [' ', '·', '▪', '■', '█'],
    "\033[97m",
    "\033[30m",
    "\033[47m",
    )

immutable HintonTextDiagram{T<:Real}
    data ::Matrix{T}
    style::HintonTextStyle
end
data(o::HintonTextDiagram)  = o.data
style(o::HintonTextDiagram) = o.style
import Base: show
function show(io::IO, o::HintonTextDiagram)
    w                = data(o)
    sty              = style(o)
    numbins          = length(bins(sty))
    (minval, maxval) = extrema(w)
    (m, n)           = size(w)
    for j in 1:m
        for i in 1:n
            v      = w[j, i]
            bin    = @compat let
                round(Int, (v - minval)/(maxval - minval)*(numbins - 1)) + 1
            end
            sym    = bins(sty)[bin]
            colour = bin < (numbins + 1)÷2 ? neg(sty) : pos(sty)
            print(io, "\033[1m$(bg(sty))$colour$sym\033[0m")
        end
        j >= m || println(io)
    end
end

function hintontxt{T<:Real}(w::AbstractMatrix{T},
        sty::HintonTextStyle=TEXTSTYLE)
    HintonTextDiagram(copy(w), sty)
end
