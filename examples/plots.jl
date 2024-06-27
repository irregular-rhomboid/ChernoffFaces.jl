
using Pkg; Pkg.activate(".")

using Plots
using ChernoffFaces

chernoff(rand(18), ChernoffFace(), title="Foo")

begin
    p = plot(layout=(4,4), size=(700,700))
    for i in 1:4, j in 1:4
        chernoff!(p, rand(18), ChernoffFace(), subplot=4*(i-1) + j)
    end
    p
end
