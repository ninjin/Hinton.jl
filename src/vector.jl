# vim:set ft=julia ts=4 sw=4 sts=4 autoindent:

# Hinton diagram generation using vector graphics.
#
# Author:   Pontus Stenetorp    <pontus stenetorp se>
# Version:  2014-12-24

# TODO: Consider a version with JavaScript injection.

using Colors
using Compose

immutable HintonVecStyle
    pos   ::Color
    neg   ::Color
    bg    ::Color
    margin::Float64
end
pos(o::HintonVecStyle)    = o.pos
neg(o::HintonVecStyle)    = o.neg
bg(o::HintonVecStyle)     = o.bg
margin(o::HintonVecStyle) = o.margin
const VECSTYLE = HintonVecStyle(
    colorant"white",
    RGB(map(x -> x/255, (51 , 51 , 50 ))...), # Dark grey, "almost" black.
    RGB(map(x -> x/255, (132, 132, 130))...), # Battleship grey.
    0.002,
    )

function hintonvec{T<:Real}(w::AbstractMatrix{T}, sty::HintonVecStyle=VECSTYLE)
    mabs   = maximum(abs(w))
    (m, n) = size(w)
    mgn    = margin(sty)
    step   = (1 - (max(m, n) + 1)*mgn)/max(m, n)
    cont   = compose(context(),
        rectangle(0, 0, (n + 1)*mgn + n*step, (m + 1)*mgn + m*step),
        fill(bg(sty)),
        )
    for i in 1:n, j in 1:m
        v      = w[j, i]/mabs
        colour = v < 0.0 ? neg(sty) : pos(sty)
        cont   = compose(cont, compose(
            context(i*mgn + (i - 1)step, j*mgn + (j - 1)step, step, step),
            rectangle((1 - v)/2, (1 - v)/2, v, v),
            fill(colour),
            ))
    end
    cont
end
