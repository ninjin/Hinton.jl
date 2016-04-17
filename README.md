[![0.5 status][0.5_badge]][pkg]
[![0.6 status][0.6_badge]][pkg]
[![Nightly status][nightly_badge]][pkg]
[![Build status][travis_badge]][travis]
[![Coverage status][coveralls_badge]][coveralls]

**Hinton** is a small [Julia][julia] library for generating Hinton diagrams.
It supports standard graphics formats such as PNG, SVG, and PDF, as well as
generating diagrams in a terminal with Unicode and colour support.

[julia]: http://julialang.org/

# Installation #

To install Hinton and its dependencies, simply type the following
into the Julia REPL:

```julia
    Pkg.add("Hinton")
```

# Usage #

Hinton diagrams are commonly used to analyse the relative values of matrices.
The diagram consists of rectangles whose area corresponds to the magnitude
of the given element.  White/black rectangles correspond to positive/negative
values respectively.  This visualisation makes it possible to gain an intuition
about the matrix structure at a glance.

To demonstrate, we will generate a random matrix and visualise it.

```julia
    srand(0x4711) # Fix the random seed.
    w = eye(17, 17) + randn(17, 17)
```

First, we generate a terminal-friendly text-only version:

```julia
    using Hinton
    println(hintontxt(w))
```

![An example Hinton diagram plotted in a terminal.][example_txt]

While the text-only version is good for quick analysis, it is hardly of
"publication quality".  Thus, there is also a vector graphics version that
draws upon [Compose][compose]:

```julia
    using Hinton
    draw(SVG("example_vec.svg", 256px, 256px), hintonvec(w))
```

![An example Hinton diagram using vector graphics.][example_vec]

[compose]: http://composejl.org/
[coveralls]: https://coveralls.io/r/ninjin/Hinton.jl
[coveralls_badge]: https://img.shields.io/coveralls/ninjin/Hinton.jl/master.svg?style=flat
[example_txt]: https://raw.githubusercontent.com/ninjin/Hinton.jl/master/examples/example_txt.png
[example_vec]: https://raw.githubusercontent.com/ninjin/Hinton.jl/master/examples/example_vec.png
[pkg]: http://pkg.julialang.org/?pkg=Hinton
[0.5_badge]: http://pkg.julialang.org/badges/Hinton_0.5.svg
[0.6_badge]: http://pkg.julialang.org/badges/Hinton_0.6.svg
[travis]: https://travis-ci.org/ninjin/Hinton.jl
[travis_badge]: https://img.shields.io/travis/ninjin/Hinton.jl/master.svg?style=flat
