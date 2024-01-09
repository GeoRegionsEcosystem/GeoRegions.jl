using GeoRegions
using Test

@testset "GeoRegions.jl" begin
    # Test in operator
    A = Point2(-20,5)
    B = Point2(340,5)
    C = Point2(-45,-7.5)
    geo = GeoRegion("AR6_EAO")

    @test A in geo
    @test B in geo
    @test !(C in geo)
    @test filter(in(geo),[A,B,C]) == [A,B]
end
