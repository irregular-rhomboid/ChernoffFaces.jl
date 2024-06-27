using GLMakie
using ChernoffFaces

chernoff(rand(18))

begin
    fig = Figure(size=(700,700))
    for i in 1:4, j in 1:4
        ax = Axis(fig[i,j])
        x = rand(18)
        chernoff!(ax, x)
    end
    fig
end
