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
        GeoRegion, RectRegion, PolyRegion, RegionGrid, RectGrid, PolyGrid,
        resetGeoRegions, templateGeoRegions, listGeoRegions, addGeoRegions,
        removeGeoRegion, coordGeoRegion,
        isPointinGeoRegion, isGeoRegioninGeoRegion,
        Point2

## Abstract types
"""
    GeoRegion

Abstract supertype for geographical regions.
"""
abstract type GeoRegion end

"""
    RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion

Structure containing information on a rectilinear (i.e. rectangular shape on a lon-lat grid) region `regID`, with parent ID `parID`, name `name`, and bounds `N`, `S`, `E`, `W`.

If `W` < 0º, then `is180` is true, and if `E` > 180, then `is360` is true.  Both `is180` and `is360` can simultaneously true, but they cannot both be false.
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
    PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion

Structure containing information on a polygonal (and non-rectangular) GeoRegion with ID `regID`, with parent ID `parID`, name `name`, and rectangular bounds `N`, `S`, `E`, `W`.  The actual shape within the rectangular bound is given by `shape`.

If `W` < 0º, then `is180` is true, and if `E` > 180, then `is360` is true.  Both `is180` and `is360` can simultaneously true, but they cannot both be false.
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
    RegionGrid

Abstract supertype for geographical regions.
"""
abstract type RegionGrid end

"""
    RectGrid{FT<:Real}

Structure containing information needed to extract data from a given lon-lat grid for a given RectRegion.
"""
struct RectGrid{FT<:Real} <: RegionGrid
    igrid :: Vector{Int}
    ilon  :: Vector{Int}
    ilat  :: Vector{Int}
    glon  :: Vector{FT}
    glat  :: Vector{FT}
end

"""
    PolyGrid{FT<:Real}

Structure containing information needed to extract data from a given lon-lat grid for a given PolyRegion with numeric elements of type `FT`. In addition to the information stored by the RectGrid type, it also has a `mask` that allows for non-rectilinear shape extraction.
"""
struct PolyGrid{FT<:Real} <: RegionGrid
    igrid :: Vector{Int}
    ilon  :: Vector{Int}
    ilat  :: Vector{Int}
    glon  :: Vector{FT}
    glat  :: Vector{FT}
    mask  :: Array{Bool,2}
end

## Including other files in the module
include("Read.jl")
include("Create.jl")
include("Query.jl")
include("IsIn.jl")
include("IsInGeoRegion.jl")
include("Extract.jl")
include("Show.jl")

end # module
