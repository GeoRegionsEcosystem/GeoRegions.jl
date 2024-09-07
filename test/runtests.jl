using GeoRegions
using Test

@testset "Test that all predefined GeoRegions work" begin

    # Test all predefined GeoRegions
    IDvec,_,_ = GeoRegions.listall()
    for ID in IDvec
        @test isID(ID,throw=false);
        @test isGeoRegion(GeoRegion(ID),throw=false);
    end

end

@testset "Test Creation, Detection and Removal of GeoRegions" begin

    @test !isID("TRP",throw=false)
    geo1 = RectRegion("TRP","GLB","Tropics",[30,-30,360,0])
    geo2 = RectRegion("TRP_DTP","GLB","Deep Tropics",[10,-10,360,0])
    @test  isID("TRP",throw=false)
    @test  isGeoRegion(geo1,throw=false)
    @test  rm(geo1) === nothing
    @test !isGeoRegion(geo1,throw=false)
    @test  isGeoRegion(geo2,throw=false)
    @test  rmID("TRP_DTP") === nothing
    @test !isGeoRegion(geo2,throw=false)

    geo = RectRegion("TRP","GLB","Tropics",[30,-30,360,0],save=false)
    @test !isGeoRegion(geo,throw=false)
    @test add(geo) === nothing
    @test isGeoRegion(geo,throw=false)
    rm(geo)

end

@testset "Testing Directory Specification for Custom GeoRegions" begin

    @test !isID("TRP",path=pwd(),throw=false)
    geo1 = RectRegion("TRP","GLB","Tropics",[30,-30,360,0],path=pwd())
    @test !isID("TRP",throw=false)
    @test  isID("TRP",path=pwd(),throw=false)
    @test  isGeoRegion(geo1,throw=false)
    @test !isGeoRegion(geo1,path=homedir(),throw=false)
    @test_throws "not a valid GeoRegion identifier" rm(geo1,path=homedir())
    @test  rm(geo1) === nothing
    @test !isGeoRegion(geo1,throw=false)

end

@testset "Testing isPointinGeoRegion" begin
    # Test in operator
    A = Point2(-20,5)
    B = Point2(340,5)
    C = Point2(-45,-7.5)
    geo = GeoRegion("AR6_EAO")

    @test  in(A,geo)
    @test  in(B,geo)
    @test !in(C,geo)
end
