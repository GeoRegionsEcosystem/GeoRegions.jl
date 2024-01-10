using GeoRegions
using Test

@testset "Test that all predefined GeoRegions work" begin

    # Test all predefined GeoRegions
    geov,_,_ = listGeoRegions()
    for geo in geov
        @test isGeoRegion(geo);
    end

end

@testset "Test Creation, Detection and Removal of GeoRegions" begin

    @test !isGeoRegion("TRP",throw=false)
    geo = RectRegion("TRP","GLB","Tropics",[30,-30,360,0])
    geo = RectRegion("TRP_DTP","GLB","Tropics",[10,-10,360,0])
    @test isGeoRegion("TRP",throw=false)
    removeGeoRegion("TRP")
    @test isGeoRegion("TRP_DTP",throw=false)
    removeGeoRegion("TRP_DTP")
    @test !isGeoRegion("TRP_DTP",throw=false)

end

@testset "Testing isPointinGeoRegion" begin
    # Test in operator
    A = Point2(-20,5)
    B = Point2(340,5)
    C = Point2(-45,-7.5)
    geo = GeoRegion("AR6_EAO")

    @test in(A,geo)
    @test in(B,geo)
    @test !in(C,geo,throw=false)
end
