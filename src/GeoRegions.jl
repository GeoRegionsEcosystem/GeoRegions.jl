module GeoRegions

## Modules Used
using Dates
using DelimitedFiles
using GeometryBasics
using Logging
using PrettyTables

import Base: show, rm, in, ==, !==, isequal
import GeometryOps: within, touches

## Exporting the following functions:
export
        GeoRegion,
        RectRegion, PolyRegion, TiltRegion,

        ==, !==, isequal, isgeo, isgeoshape, isID,
        add, rm, rmID, overwrite,

        setupGeoRegions, readGeoRegions, addGeoRegions, deleteGeoRegions,
        tableGeoRegions, tableRectRegions, tableTiltRegions, tablePolyRegions,

        in, on, coordinates,
        Point, Point2, Polygon

## Abstract types
"""
    GeoRegion

Abstract supertype for geographical regions. All `GeoRegion` types contain the following fields:
* `ID` - A `String` Type, the identifier for the GeoRegion.
* `pID` - A `String` Type, the identifier for the parent GeoRegion.
* `name` - A `String` Type, the full name of the GeoRegion.
* `bound` - A vector of `Float` Types, defining the [North, South, East, West] boundaries of the GeoRegion.
* `shape` - A vector of `Point2` (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)) Types, defining a non-rectilinear shape of the GeoRegion
* `geometry` - A `Polygon` Type (see [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl)), which is useful when doing checks on polygons using [GeometryOps.jl](https://github.com/JuliaGeo/GeometryOps.jl).
"""
abstract type GeoRegion end

"""
    RectRegion <: GeoRegion

A rectangular region on a rectilinear grid. Defined by its N,S,E,W boundaries.
"""
struct RectRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    path     :: ST
    bound    :: Vector{FT}
    shape    :: Vector{Point2{FT}}
    geometry :: Polygon
end

"""
    PolyRegion <: GeoRegion

A polygonal region on a rectilinear lon-lat grid, defined by the (lon,lat) coordinates of its vertices.
"""
struct PolyRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    path     :: ST
    bound    :: Vector{FT}
    shape    :: Vector{Point2{FT}}
    geometry :: Polygon
end

"""
    TiltRegion <: GeoRegion

A **tilted** rectangular region on a rectilinear grid. Defined by:
* the (lon,lat) coordinates of its centre.
* the width in both the longitude and latitude directions (pre-rotation).
* the angle of tilt in degrees (clockwise).

In addition to all the fields common to the `GeoRegion` `abstract type`, `TiltRegion`s will also contain the following field:
- `tilt` : A vector of `Float` Types, containing [X,Y,ΔX,ΔY,θ], where:
    * `X`  : A `Float` Type, the longitude coordinate of region centre.
    * `Y`  : A `Float` Type, the latitude coordinate of region centre.
    * `θ`  : A `Float` Type, the angle-tilt of rectangular region in **degrees** in the clockwise direction.
    * `ΔX` : A `Float` Type, the half-width in longitude coordinates (before tilting).
    * `ΔY` : A `Float` Type, the half-width in latitude coordinates (before tilting).
"""
struct TiltRegion{ST<:AbstractString, FT<:Real} <: GeoRegion
    ID       :: ST
    pID      :: ST
    name     :: ST
    path     :: ST
    bound    :: Vector{FT}
    shape    :: Vector{Point2{FT}}
    geometry :: Polygon
    tilt     :: Vector{FT}
end

modulelog() = "$(now()) - GeoRegions.jl"
geodir = joinpath(@__DIR__,"files")

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
