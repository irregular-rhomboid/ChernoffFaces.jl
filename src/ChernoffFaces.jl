module ChernoffFaces

using RecipesBase
using MakieCore
using LinearAlgebra

abstract type AbstractChernoff end

include("utils.jl")

export ChernoffFace, ChernoffCat

export chernoff
export chernoff!

function chernoff end
function chernoff! end


end
