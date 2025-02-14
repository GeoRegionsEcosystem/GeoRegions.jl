using Dates
using GeoRegions
using Test

@testset "Test Creation, Detection and Removal of GeoRegions" begin

    geo = GeoRegion(
        [0,360,360,0,0], [-30,-30,30,30,-30],
        ID = "TRP", pID = "GLB", name = "Tropics",
    )
    @test !isgeo(geo,throw=false)
    @test add(geo) === nothing
    @test isgeo(geo,throw=false)
    rm(geo)
    @test !isID("TRP",throw=false)

    geo1 = GeoRegion(
        [0,360,360,0,0], [-30,-30,30,30,-30],
        ID = "TRP", pID = "GLB", name = "Tropics", save = true
    )
    geo2 = GeoRegion(
        [0,360,360,0,0], [-10,-10,10,10,-10],
        ID = "TRP_DTP", pID = "GLB", name = "Deep Tropics", save = true
    )
    @test  isID("TRP",throw=false)
    @test  isgeo(geo1,throw=false)
    @test  rm(geo1) === nothing
    @test !isgeo(geo1,throw=false)
    @test  isgeo(geo2,throw=false)
    @test  rmID("TRP_DTP") === nothing
    @test !isgeo(geo2,throw=false)

end

@testset "Testing Directory Specification for Custom GeoRegions" begin

    @test !isID("TRP",path=pwd(),throw=false)
    geo1 = GeoRegion(
        [0,360,360,0,0], [-30,-30,30,30,-30],
        ID = "TRP", pID = "GLB", name = "Tropics",
        path = pwd(), save = true
    )
    @test !isID("TRP",throw=false)
    @test  isID("TRP",path=pwd(),throw=false)
    @test  isgeo(geo1,throw=false)
    @test !isgeo(geo1,path=homedir(),throw=false)
    @test_throws "not a valid GeoRegion identifier" rm(geo1,path=homedir())
    @test  rm(geo1) === nothing
    @test !isgeo(geo1,throw=false)

end

# @testset "Testing GeoRegion in GeoRegion" begin

#     disable_logging(Logging.Warn)

#     # Test in RectRegion
    

#     # Test in PolyRegion

    
#     disable_logging(Logging.Debug)

# end

@testset "Test that all predefined GeoRegions work" begin

    IDvec,_ = GeoRegions.listall()
    for ID in IDvec
        @test isID(ID,throw=false);
        @test isgeo(GeoRegion(ID),throw=false);
    end

end
