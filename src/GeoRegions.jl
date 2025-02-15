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
* `path` - A `String` Type, the path of the file containing information on this GeoRegion.
* `N` - A `Float` Type, contains the northernmost latitude bound.
* `S` - A `Float` Type, contains the southernmost latitude bound.
* `E` - A `Float` Type, contains the easternmost longitude bound.
* `W` - A `Float` Type, contains the westernmost longitude bound.
* `θ` - A `Float` Type, the rotation projection for the data in the GeoRegion
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

Struct containing the geometry/shape properties of a GeoRegion. All `Geometry` types contain the following fields:
* `level` - An `Int` type that determines the nested-level of this particular shape/polygon geometry within the GeoRegion.
* `shape` - A vector of `Point2` (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)) Types, defining a non-rectilinear shape of the GeoRegion.
* `polygon` - A `Polygon` Type (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)), which is useful when doing checks on polygons using [GeometryOps.jl](https://github.com/JuliaGeo/GeometryOps.jl).
"""
struct Geometry{FT<:Real}
    shape   :: Vector{Point2{FT}}
    polygon :: Polygon
end

"""
    JSONGeometry

Struct containing the geometry/shape properties of a GeoRegion that are needed to be saved into JSON files. All `JSONGeometry` types contain the following fields:
* `level` - An `Int` type that determines the nested-level of this particular shape/polygon geometry within the GeoRegion.
* `longitude` - A vector of `Float`s that contain the longitudes.
* `latitude` - A vector of `Float`s that contain the latitudes.
"""
struct JSONGeometry{FT<:Real}
    longitude :: Vector{FT}
    latitude  :: Vector{FT}
end

"""
    GeoRegion

A `struct` containing geometric information on a geographic regions defined in `Geometry`. We note the following:
* `geometry` - currently is a singular `Geometry`
"""
struct GeoRegion{ST<:AbstractString, FT<:Real} <: AbstractGeoRegion
      ID :: ST
     pID :: ST
    name :: ST
    path :: ST
       N :: FT
       S :: FT
       E :: FT
       W :: FT
       θ :: FT
    geometry :: Geometry{FT}
end

struct JSONRegion{ST<:AbstractString, FT<:Real} <: AbstractGeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    rotation :: FT
    geometry :: JSONGeometry{FT}
end

modulelog() = "$(now()) - GeoRegions.jl"
geopath(path) = splitpath(path)[end] !== ".georegions" ? joinpath(path,".georegions") : path

geopredefined = joinpath(@__DIR__,".files")
gfdir   = joinpath(geopredefined,"GF")
srexdir = joinpath(geopredefined,"SREX")
ar6dir  = joinpath(geopredefined,"AR6")

# Including other files in the module
include("georegions/define.jl")
include("georegions/add.jl")
include("georegions/is.jl")
include("georegions/list.jl")
include("georegions/project.jl")
include("georegions/remove.jl")
include("georegions/shape.jl")
include("georegions/show.jl")
include("georegions/tables.jl")

include("isin/isin.jl")
include("isin/ison.jl")
# include("isin/extrastuff.jl")

end # module
