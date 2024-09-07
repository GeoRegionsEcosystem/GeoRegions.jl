using GeoRegions
using Logging
using Test

@testset "Test Creation, Detection and Removal of GeoRegions" begin

    geo = RectRegion("TRP","GLB","Tropics",[30,-30,360,0])
    @test !isGeoRegion(geo,throw=false)
    @test add(geo) === nothing
    @test isGeoRegion(geo,throw=false)
    rm(geo)
    disable_logging(Logging.Debug)

    disable_logging(Logging.Warn)
    @test !isID("TRP",throw=false)
    geo1 = RectRegion("TRP","GLB","Tropics",[30,-30,360,0],save=true)
    geo2 = RectRegion("TRP_DTP","GLB","Deep Tropics",[10,-10,360,0],save=true)
    @test  isID("TRP",throw=false)
    @test  isGeoRegion(geo1,throw=false)
    @test  rm(geo1) === nothing
    @test !isGeoRegion(geo1,throw=false)
    @test  isGeoRegion(geo2,throw=false)
    @test  rmID("TRP_DTP") === nothing
    @test !isGeoRegion(geo2,throw=false)

end

@testset "Testing Directory Specification for Custom GeoRegions" begin

    disable_logging(Logging.Warn)
    @test !isID("TRP",path=pwd(),throw=false)
    geo1 = RectRegion("TRP","GLB","Tropics",[30,-30,360,0],path=pwd(),save=true)
    @test !isID("TRP",throw=false)
    @test  isID("TRP",path=pwd(),throw=false)
    @test  isGeoRegion(geo1,throw=false)
    @test !isGeoRegion(geo1,path=homedir(),throw=false)
    @test_throws "not a valid GeoRegion identifier" rm(geo1,path=homedir())
    @test  rm(geo1) === nothing
    @test !isGeoRegion(geo1,throw=false)
    disable_logging(Logging.Debug)

end

@testset "Testing isPointinGeoRegion" begin

    disable_logging(Logging.Warn)
    # Test in operator
    A = Point2(-20,5)
    B = Point2(340,5)
    C = Point2(-45,-7.5)
    geo = GeoRegion("AR6_EAO")

    @test  in(A,geo)
    @test  in(B,geo)
    @test !in(C,geo)
    disable_logging(Logging.Debug)

end

@testset "Test that all predefined GeoRegions work" begin

    disable_logging(Logging.Warn)
    IDvec,_,_ = GeoRegions.listall()
    for ID in IDvec
        @test isID(ID,throw=false);
        @test isGeoRegion(GeoRegion(ID),throw=false);
    end
    disable_logging(Logging.Debug)

end
