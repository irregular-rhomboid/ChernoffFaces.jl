
struct ChernoffCat <: AbstractChernoff{T}
    ranges::Vector{Tuple{T,T}}
end

ChernoffCat() = ChernoffCat(default_ranges_cat())

function default_ranges_cat()

end
