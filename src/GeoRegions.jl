module GeoRegions

## Modules Used
using Dates
using DelimitedFiles
using GeometryBasics
using Logging
using PolygonOps
using PrettyTables

import Base: show, read

## Exporting the following functions:
export
        GeoRegion, RectRegion, PolyRegion, GeoRegionInfo,
        resetGeoRegions, templateGeoRegions, listGeoRegions, removeGeoRegion,
        coordGeoRegion,
        isPointinGeoRegion,
        Point2

## Abstract types
"""
    GeoRegion

Abstract supertype for geographical regions.
"""
abstract type GeoRegion end

"""
    RectRegion{ST<:AbstractString, FT<:Real}

Structure containing information on regions that are rectilinear (i.e. rectangular shape) on a lon-lat grid with string elements of type `ST` and numeric elements of type `FT`.
"""
struct RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    regID :: ST
    parID :: ST
    name  :: ST
    N     :: FT
    S     :: FT
    E     :: FT
    W     :: FT
    is180 :: Bool
    is360 :: Bool
end

"""
    PolyRegion{ST<:AbstractString, FT<:Real}

Structure containing information on regions that have a polygonal (and non-rectangular) shape on a lon-lat grid, with string elements of type `ST`, numeric elements of type `FT`, and points on a 2D plane of type Point2D{FT}.
"""
struct PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    regID :: ST
    parID :: ST
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
    GeoRegion

Abstract supertype for geographical regions.
"""
abstract type RegionInfo end

"""
    RectInfo{FT<:Real}

Structure containing information needed to extract data from a given lon-lat grid for a given RectRegion with numeric elements of type `FT`.
"""
struct RectInfo{FT<:Real} <: RegionInfo
    igrid :: Vector{Int}
    ilon  :: Vector{Int}
    ilat  :: Vector{Int}
    glon  :: Vector{FT}
    glat  :: Vector{FT}
end

"""
    PolyInfo{FT<:Real}

Structure containing information needed to extract data from a given lon-lat grid for a given PolyRegion with numeric elements of type `FT`. In addition to the information stored by the RectInfo type, it also has a `mask` that allows for non-rectilinear shape extraction.
"""
struct PolyInfo{FT<:Real} <: RegionInfo
    igrid :: Vector{Int}
    ilon  :: Vector{Int}
    ilat  :: Vector{Int}
    glon  :: Vector{FT}
    glat  :: Vector{FT}
    mask  :: Array{Bool,2}
end

## Including other files in the module
# include("isin.jl")
# include("query.jl")
# include("extract.jl")
include("Read.jl")
include("Create.jl")
include("Query.jl")
include("IsIn.jl")
include("IsInGeoRegion.jl")
include("Extract.jl")

end # module
