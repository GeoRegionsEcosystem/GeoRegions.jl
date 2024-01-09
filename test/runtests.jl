using GeoRegions
using Test

@testset "GeoRegions.jl" begin
    # Test in operator
    A = Point2(-20,5)
    B = Point2(340,5)
    C = Point2(-45,-7.5)
    geo = GeoRegion("AR6_EAO")

    @test in(A,geo)
    @test in(B,geo)
    @test !in(C,geo,throw=false)
end
