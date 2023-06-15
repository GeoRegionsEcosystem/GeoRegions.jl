module GeoRegions

## Modules Used
using Dates
using DelimitedFiles
using GeometryBasics
using ImageFiltering
using Logging
using NCDatasets
using PolygonOps
using PrettyTables

import Base: show, read

## Exporting the following functions:
export
        GeoRegion, RectRegion, PolyRegion,
        RegionGrid, RectGrid, PolyGrid, RegionMask,
        AbstractLandSea, LandSeaTopo, LandSeaFlat,

        resetGeoRegions, templateGeoRegions, listGeoRegions, readGeoRegions,
        isGeoRegion, addGeoRegions, removeGeoRegion, coordGeoRegion, isinGeoRegion,
        tableGeoRegions, tableRectRegions, tablePolyRegions,

        extractGrid, extractGrid!,

        getLandSea, smooth, smooth!,
        
        Point2

## Abstract types
"""
    GeoRegion

Abstract supertype for geographical regions, with the following subtypes:
    
    RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion

Both `RectRegion` and `PolyRegion` types contain the following fields:
* `ID` - A `String` Type, the identifier for the GeoRegion
* `pID` - A `String` Type, the identifier for the parent GeoRegion
* `name` - A `String` Type, the full name of the GeoRegion
* `N` - A `Float` Type, the north boundary of the GeoRegion
* `S` - A `Float` Type, the south boundary of the GeoRegion
* `E` - A `Float` Type, the east boundary of the GeoRegion
* `W` - A `Float` Type, the est boundary of the GeoRegion
* `is180` - A `Bool` Type, is `W` < 0
* `is360` - A `Bool` Type, is `E` > 180

A `PolyRegion` type will also contain the following field:
* `shape` - A vector of `Point2` Types, defining a non-rectilinear shape of the GeoRegion
"""
abstract type GeoRegion end

struct RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID    :: ST
    pID   :: ST
    name  :: ST
    N     :: FT
    S     :: FT
    E     :: FT
    W     :: FT
    is180 :: Bool
    is360 :: Bool
end

struct PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID    :: ST
    pID   :: ST
    name  :: ST
    N     :: FT
    S     :: FT
    E     :: FT
    W     :: FT
    shape :: Vector{Point2{FT}}
    is180 :: Bool
    is360 :: Bool
end

"""
    RegionGrid

Abstract supertype for geographical region gridded information, with the following subtypes:
    
    RectGrid{FT<:Real} <: RegionGrid
    PolyGrid{FT<:Real} <: RegionGrid
    RegionMask{FT<:Real} <: RegionGrid

Both `RectGrid` and `PolyGrid` types contain the following fields:
* `grid` - A vector of `Int`s defining the gridpoint indices of the [N,S,E,W] points respectively
* `lon` - A vector of `Float`s defining the latitude vector describing the region
* `lat` - A vector of `Float`s defining the latitude vector describing the region
* `ilon` - A vector of `Int`s defining indices of the parent longitude vector describing the region
* `ilat` - A vector of `Int`s defining indices of the parent latitude vector describing the region

A `PolyGrid` type will also contain the following field:
* `mask` - An array of 0s and 1s defining a non-rectilinear shape within a rectilinear grid where data is valid (only available in PolyGrid types)

A `RegionMask` type will contain the following fields:
* `lon` - An array of longitude points
* `lat` - An array of latitude points
* `mask` - An array of NaNs and 1s defining the region within the original field in which data points are valid
"""
abstract type RegionGrid end

struct RectGrid{FT<:Real} <: RegionGrid
    grid :: Vector{Int}
     lon :: Vector{FT}
     lat :: Vector{FT}
    ilon :: Vector{Int}
    ilat :: Vector{Int}
end

struct PolyGrid{FT<:Real} <: RegionGrid
    grid :: Vector{Int}
     lon :: Vector{FT}
     lat :: Vector{FT}
    ilon :: Vector{Int}
    ilat :: Vector{Int}
    mask :: Array{FT,2}
end

struct RegionMask{FT<:Real} <: RegionGrid
     lon :: Array{FT,2}
     lat :: Array{FT,2}
    mask :: Array{FT,2}
end

"""
    AbstractLandSea

Abstract supertype for LandSea Datasets, with the following subtypes:

    LandSeaTopo <: AbstractLandSea
    LandSeaFlat <: AbstractLandSea

Both `LandSeaTopo` and `LandSeaFlat` types contain the following fields:
* `lon` - Vector containing the longitude points for the Land-Sea Dataset
* `lat` - Vector containing the latitude points for the Land-Sea Dataset
* `lsm` - Array containing data regarding the Land-Sea Mask.  1 is Land, 0 is Ocean, NaN is outside the bounds of the GeoRegion
* `mask` - Mask determining if point is within the GeoRegion or not. 1 is `true`, 0 is `false`.

A `LandSeaTopo` type will also contain the following field:
* `z` - Array containing data regarding the Orographic Height in meters.  NaN is outside the bounds of the GeoRegion
"""
abstract type AbstractLandSea end

abstract type LandSeaTopo <: AbstractLandSea end

abstract type LandSeaFlat <: AbstractLandSea end

"""
    GeoRegion.LandSea <: LandSeaTopo

Object containing information on the ETOPO 2022 Land Sea mask for a GeoRegion.
"""
struct LandSea{FT<:Real} <: LandSeaTopo
    lon  :: Vector{Float32}
    lat  :: Vector{Float32}
    lsm  :: Array{Float32,2}
    z    :: Array{Float32,2}
    mask :: Array{Int16,2}
end

modulelog() = "$(now()) - GeoRegions.jl"

function __init__()
    jfol = joinpath(DEPOT_PATH[1],"files","GeoRegions"); mkpath(jfol);
    flist   = ["rectlist.txt","polylist.txt","giorgi.txt","srex.txt","ar6.txt"]

    for fname in flist
        if !isfile(joinpath(jfol,fname))
            copygeoregions(fname)
            @info "$(modulelog()) - $(fname) does not exist in $(jfol), copying ..."
        end
    end
end

## Including other files in the module
include("georegions/read.jl")
include("georegions/create.jl")
include("georegions/query.jl")
include("georegions/show.jl")
include("georegions/tables.jl")

include("isin/isin.jl")
include("isin/isingeoRegion.jl")

include("extract/extract.jl")
include("extract/grid.jl")

include("landsea/landsea.jl")
include("landsea/smooth.jl")

end # module
