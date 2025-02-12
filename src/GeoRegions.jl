module GeoRegions

## Modules Used
using Dates
using GeometryBasics
using Glob
using JSON3
using Logging
using PrettyTables

import Base: show, rm, in, ==, !==, isequal
import GeometryOps: within, touches

## Exporting the following functions:
export
        GeoRegion, #MultipleRegion,

        ==, !==, isequal, isgeo, isgeoshape, isID,
        add, rm, rmID, overwrite,

        setupGeoRegions, readGeoRegions, addGeoRegions, deleteGeoRegions, tableGeoRegions,

        in, on, coordinates,
        Point, Point2, Polygon

## Abstract types
"""
    AbstractGeoRegion

Abstract supertype for geographical regions. All `GeoRegion` types contain the following fields:
* `ID` - A `String` Type, the identifier for the GeoRegion.
* `pID` - A `String` Type, the identifier for the parent GeoRegion.
* `name` - A `String` Type, the full name of the GeoRegion.
* `path` - A `String` Type, the full name of the GeoRegion.
* `rotation` - A `Geometry` Type
* `geometry` - A `Geometry` Type
"""
abstract type AbstractGeoRegion end

"""
    Geometry

Abstract supertype for geographical regions. All `GeoRegion` types contain the following fields:
* `level` - A vector of `Float` Types, defining the [North, South, East, West] boundaries of the GeoRegion.
* `shape` - A vector of `Point2` (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)) Types, defining a non-rectilinear shape of the GeoRegion
* `polygon` - A `Polygon` Type (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)), which is useful when doing checks on polygons using [GeometryOps.jl](https://github.com/JuliaGeo/GeometryOps.jl).
"""
struct Geometry{FT<:Real}
    level   :: Int
    shape   :: Vector{Point2{FT}}
    polygon :: Polygon
end

struct JSONGeometry{FT<:Real}
    level     :: Int
    longitude :: Vector{FT}
    latitude  :: Vector{FT}
end

"""
    RectRegion <: GeoRegion

A rectangular region on a rectilinear grid. Defined by its N,S,E,W boundaries.
"""
struct GeoRegion{ST<:AbstractString, FT<:Real} <: AbstractGeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    path     :: ST
    boundary :: Vector{FT}
    rotation :: FT
    geometry :: Geometry{FT}
end

struct JSONRegion{ST<:AbstractString, FT<:Real} <: AbstractGeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    rotation :: FT
    geometry :: JSONGeometry{FT}
end

struct MultiGeoRegion{ST<:AbstractString, FT<:Real} <: AbstractGeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    path     :: ST
    boundary :: Vector{FT}
    rotation :: FT
    geometry :: Vector{Geometry{FT}}
end

struct JSONMultiRegion{ST<:AbstractString, FT<:Real} <: AbstractGeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    path     :: ST
    rotation :: FT
    geometry :: Vector{JSONGeometry{FT}}
end

modulelog() = "$(now()) - GeoRegions.jl"
geopath(path) = joinpath(path,".georegions")
geopredefined = joinpath(@__DIR__,".files")

## Including other files in the module
# include("georegions/define.jl")
# include("georegions/add.jl")
# include("georegions/get.jl")
# include("georegions/is.jl")
# include("georegions/list.jl")
# include("georegions/project.jl")
# include("georegions/remove.jl")
# include("georegions/shape.jl")
# include("georegions/show.jl")
# include("georegions/tables.jl")

# include("isin/isin.jl")
# include("isin/ison.jl")
# include("isin/extrastuff.jl")

end # module
