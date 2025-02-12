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

Abstract supertype for geographical regions. All `AbstractGeoRegion` types contain the following fields:
* `ID` - A `String` Type, the identifier for the GeoRegion.
* `pID` - A `String` Type, the identifier for the parent GeoRegion.
* `name` - A `String` Type, the full name of the GeoRegion.
* `path` - A `String` Type, the full name of the GeoRegion.
* `boundary` - A `Vector` Type, contains the [N, S, E, W] points that bound the GeoRegion
* `rotation` - A `Real` Type, the rotation projection for the data in the GeoRegion
* `geometry` - A `Geometry` or `Vector{Geometry}` Type
"""
abstract type AbstractGeoRegion end

"""
    AbstractJSONRegion

Abstract backend supertype for necessary GeoRegion information to be saved into JSON files. This is a backend and most likely need not be called upon except within the GeoRegions.jl package.
    
All `AbstractJSONRegion` types contain the following fields:
* `ID` - A `String` Type, the identifier for the GeoRegion.
* `pID` - A `String` Type, the identifier for the parent GeoRegion.
* `name` - A `String` Type, the full name of the GeoRegion.
* `rotation` - A `Real` Type, the rotation projection for the data in the GeoRegion.
* `geometry` - A `JSONGeometry` or `Vector{JSONGeometry}` Type.
"""
abstract type AbstractJSONRegion end

"""
    Geometry

Abstract supertype for geographical regions. All `GeoRegion` types contain the following fields:
* `level` - An `Int` type that determines the nested-level of this particular shape/polygon geometry within the GeoRegion.
* `shape` - A vector of `Point2` (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)) Types, defining a non-rectilinear shape of the GeoRegion.
* `polygon` - A `Polygon` Type (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)), which is useful when doing checks on polygons using [GeometryOps.jl](https://github.com/JuliaGeo/GeometryOps.jl).
"""
struct Geometry{FT<:Real}
    level   :: Int
    shape   :: Vector{Point2{FT}}
    polygon :: Polygon
end

"""
    JSONGeometry

Abstract supertype for geographical regions. All `GeoRegion` types contain the following fields:
* `level` - An `Int` type that determines the nested-level of this particular shape/polygon geometry within the GeoRegion.
* `longitude` - A vector of `Float`s that contain the longitudes.
* `latitude` - A vector of `Float`s that contain the latitudes.
"""
struct JSONGeometry{FT<:Real}
    level     :: Int
    longitude :: Vector{FT}
    latitude  :: Vector{FT}
end

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
geopath(path) = splitpath(path)[end] !== ".georegions" ? joinpath(path,".georegions") : path
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
