module ChernoffFacesPlotsExt

    using Plots
    using RecipesBase
    using ChernoffFaces
    using ChernoffFaces: lerp, ellipse_arc, solve_ellipse
    using ChernoffFaces: AbstractChernoff, ChernoffFace, ChernoffCat
    using ChernoffFaces: cf_ranges, chernoff_parts
    import ChernoffFaces: chernoff, chernoff!

    @userplot struct Chernoff{T<:Tuple}
        args::T
    end

    RecipesBase.@recipe function f(cp::Chernoff{<:Tuple{AbstractVector{<:Real}, <:AbstractChernoff}})
        framestyle --> :none
        aspect_ratio --> true
        seriestype --> :path
        linewidth := 2
        label --> ""
        color := :black

        x = lerp.(cp.args[1], cf_ranges(cp.args[2]))

        paths, fills = chernoff_parts(x, cp.args[2])
        for path in paths
            @series begin
                path
            end
        end
        for fill in fills
            @series begin
                seriestype := :shape
                fill
            end
        end
    end

   @recipe function f(cp::Chernoff{<:Tuple{AbstractVector{<:Real}}})
        framestyle --> :none
        aspect_ratio --> true
        seriestype --> :path
        linewidth := 2
        label --> ""
        color := :black
        cf = ChernoffFace()
        x = lerp.(cp.args[1], cf_ranges(cf))

        paths, fills = chernoff_parts(x, cf)
        for path in paths
            @series begin
                path
            end
        end
        for fill in fills
            @series begin
                seriestype := :shape
                fill
            end
        end
   end

end
