module GeoRegions

## Modules Used
using Dates
using DelimitedFiles
using GeometryBasics
using Logging
using PrettyTables

import Base: show, read

## Exporting the following functions:
export
        GeoRegion, RectRegion, PolyRegion

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

## Including other files in the module
# include("isin.jl")
# include("query.jl")
# include("extract.jl")
include("Read.jl")
include("Create.jl")

end # module
