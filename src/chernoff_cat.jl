
struct ChernoffCat{T} <: AbstractChernoff
    ranges::Vector{Tuple{T,T}}
end

ChernoffCat() = ChernoffCat(default_ranges_cat())

function default_ranges_cat()
    return [
        (0.2,0.7),
    ]
end
