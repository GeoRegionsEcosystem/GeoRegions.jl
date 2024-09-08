module GeoRegions

## Modules Used
using Dates
using DelimitedFiles
using GeometryBasics
using Logging
using PolygonOps
using PrettyTables

import Base: show, rm, in, ==

## Exporting the following functions:
export
        GeoRegion,
        RectRegion, PolyRegion, TiltRegion,

        ==, isGeoRegion, isID,
        add, rm, rmID, overwrite,

        setupGeoRegions, readGeoRegions, addGeoRegions, resetGeoRegions, deleteGeoRegions,
        tableGeoRegions, tableRectRegions, tableTiltRegions, tablePolyRegions,

        isinGeoRegion, in,
        coordinates,
        Point2

## Abstract types
"""
    GeoRegion

Abstract supertype for geographical regions. All `GeoRegion` types contain the following fields:
* `ID` - A `String` Type, the identifier for the GeoRegion
* `pID` - A `String` Type, the identifier for the parent GeoRegion
* `name` - A `String` Type, the full name of the GeoRegion
* `N` - A `Float` Type, the north boundary of the GeoRegion
* `S` - A `Float` Type, the south boundary of the GeoRegion
* `E` - A `Float` Type, the east boundary of the GeoRegion
* `W` - A `Float` Type, the est boundary of the GeoRegion
* `is180` - A `Bool` Type, is `W` < 0
* `is360` - A `Bool` Type, is `E` > 180
"""
abstract type GeoRegion end

"""
    RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion

A rectangular region on a rectilinear grid. Defined by its N,S,E,W boundaries.
"""
struct RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID    :: ST
    pID   :: ST
    name  :: ST
    path  :: ST
    N     :: FT
    S     :: FT
    E     :: FT
    W     :: FT
    is180 :: Bool
    is360 :: Bool
end

"""
    PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion

A polygonal region on a rectilinear lon-lat grid, defined by the (lon,lat) coordinates of its vertices.

In addition to all the fields common to the `GeoRegion` `abstract type`, `PolyRegion`s will also contain the following field:
* `shape` - A vector of `Point2` Types, defining a non-rectilinear shape of the GeoRegion
"""
struct PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID    :: ST
    pID   :: ST
    name  :: ST
    path  :: ST
    N     :: FT
    S     :: FT
    E     :: FT
    W     :: FT
    is180 :: Bool
    is360 :: Bool
    shape :: Vector{Point2{FT}}
end

"""
    TiltRegion{ST<:AbstractString, FT<:Real} <: GeoRegion

A **tilted** rectangular region on a rectilinear grid. Defined by
* the (lon,lat) coordinates of its centre
* the width in both the longitude and latitude directions (pre-rotation)
* the angle of tilt in degrees (clockwise)

In addition to all the fields common to the `GeoRegion` `abstract type`, `TiltRegion`s will also contain the following field:
- `X`  : Longitude coordinate of region centre
- `Y`  : Latitude coordinate of region centre
- `θ`  : Tilt of rectangular region in **degrees** in the clockwise direction
- `ΔX` : Half-width in longitude coordinates (before tilting)
- `ΔY` : Half-width in latitude coordinates (before tilting)
"""
struct TiltRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID    :: ST
    pID   :: ST
    name  :: ST
    path  :: ST
    N     :: FT
    S     :: FT
    E     :: FT
    W     :: FT
    is180 :: Bool
    is360 :: Bool
    X     :: FT
    Y     :: FT
    θ     :: FT
    ΔX    :: FT
    ΔY    :: FT
end

modulelog = "$(now()) - GeoRegions.jl"
geodir = joinpath(@__DIR__,"files")

## Including other files in the module
include("georegions/define.jl")
include("georegions/add.jl")
include("georegions/get.jl")
include("georegions/is.jl")
include("georegions/list.jl")
include("georegions/project.jl")
include("georegions/remove.jl")
include("georegions/query.jl")
include("georegions/show.jl")
include("georegions/tables.jl")

include("isin/isin.jl")
include("isin/point.jl")
include("isin/georegion.jl")

end # module
