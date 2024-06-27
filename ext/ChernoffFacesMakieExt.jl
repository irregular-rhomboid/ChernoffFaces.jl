module ChernoffFacesMakieExt

using Makie
using ChernoffFaces: lerp, ellipse_arc, solve_ellipse
using ChernoffFaces: AbstractChernoff, ChernoffFace, ChernoffCat
using ChernoffFaces: cf_ranges, chernoff_parts

import ChernoffFaces: chernoff, chernoff!

Makie.@recipe(Chernoff) do scene
    Theme(
        grid = false,
        ticks = false
    )
end


function Makie.plot!(cf::Chernoff{<:Tuple{AbstractVector{<:Real}, <:AbstractChernoff}})
    ranges = cf_ranges(cf[2])
    x = lerp.(cf[1][], ranges)

    chernoff_face_makie!(cf, x[], cf[2][])
end

function Makie.plot!(chernoff::Chernoff{<:Tuple{AbstractVector{<:Real}}})
    #hidedecorations!(chernoff, grid=false)
    cf = ChernoffFace()
    x = lerp.(chernoff[1][], cf_ranges(cf))

    chernoff_face_makie!(chernoff, x, cf)
end

function chernoff_face_makie!(ax, x::AbstractVector, cf::AbstractChernoff)
    paths, fills = chernoff_parts(x, cf)
    for shape in fills
        poly!(ax, shape, color=:black)
    end
    for path in paths
        lines!(ax, path, color=:black)
    end
end

end
