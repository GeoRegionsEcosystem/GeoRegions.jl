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
        add, addGeoRegion,
        rm, rmID,
        overwrite,

        templateGeoRegions, readGeoRegions, addGeoRegions, resetGeoRegions,
        tableGeoRegions, tableRectRegions, tableTiltRegions, tablePolyRegions,

        isinGeoRegion, in,
        coordinates,
        Point2

## Abstract types
"""
    GeoRegion

Abstract supertype for geographical regions, with the following subtypes:
    
    RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    TiltRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion

All `GeoRegion` types contain the following fields:
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

A `TiltRegion` type will also contain the following field:
- `X`  : Longitude coordinate of region centre
- `Y`  : Latitude coordinate of region centre
- `θ`  : Tilt of rectangular region in **degrees** in the clockwise direction
- `ΔX` : Half-width in longitude coordinates (before tilting)
- `ΔY` : Half-width in latitude coordinates (before tilting)
"""
abstract type GeoRegion end

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

modulelog() = "$(now()) - GeoRegions.jl"
geodir = joinpath(DEPOT_PATH[1],"files","GeoRegions")

function __init__()
    mkpath(geodir);
    flist  = [
        "rectlist.txt","polylist.txt","tiltlist.txt",
        "giorgi.txt","srex.txt","ar6.txt"
    ]

    for fname in flist
        if !isfile(joinpath(geodir,fname))
            copygeoregions(fname,geodir)
            @info "$(modulelog()) - $(fname) does not exist in $(geodir), copying ..."
        end
    end
end

## Including other files in the module
include("georegions/create.jl")
include("georegions/add.jl")
include("georegions/get.jl")
include("georegions/is.jl")
include("georegions/list.jl")
include("georegions/read.jl")
include("georegions/remove.jl")
include("georegions/query.jl")
include("georegions/show.jl")
include("georegions/tables.jl")

include("isin/isin.jl")
include("isin/point.jl")
include("isin/georegion.jl")

end # module
