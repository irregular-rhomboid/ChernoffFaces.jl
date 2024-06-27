module ChernoffFaces

using RecipesBase

abstract type AbstractChernoff end

include("utils.jl")

include("chernoff_classic.jl")
include("chernoff_cat.jl")
export ChernoffFace, ChernoffCat

export chernoff
export chernoff!

function chernoff end
function chernoff! end

end
