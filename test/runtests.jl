using ChernoffFaces
using Test
using Aqua
using JET

@testset "ChernoffFaces.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(ChernoffFaces; ambiguities = false, stale_deps=false,)
    end
    @testset "Code linting (JET.jl)" begin
        JET.test_package(ChernoffFaces; target_defined_modules = true)
    end
    # Write your tests here.
end
