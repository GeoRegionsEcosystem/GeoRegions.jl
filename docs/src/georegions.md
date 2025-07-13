# What is a GeoRegion?

In essence, a `GeoRegion` is:
* a geographical region of interest
* identified by an `ID`
* a subregion of a **parent** `GeoRegion` (identified by `pID`, which must also be a valid `ID`)

!!! tip "Default GeoRegions"
    When using GeoRegions.jl, the default `GeoRegion` should generally be the global domain, specified by `GLB` and given by the `[N,S,E,W]` coordinates `[90,-90,360,0]`.  The Global GeoRegion `GLB` is considered to be a subset of itself.

```@docs
GeoRegions.AbstractGeoRegion
```

## The `GeoRegion` Type

In GeoRegions.jl v8 and above, we have standardized the usage of the struct type `GeoRegion` for all simple polygonal shapes.

**Current Limitations:**
* A `GeoRegion` supports only one shape/polygon per GeoRegion
* A `GeoRegion` shape/polygon cannot have holes within it 

Work is currently in progress to determine how best to include multiple shapes in a single `GeoRegion` type.

!!! warning "`Types` of GeoRegions for versions ≤v7"
    Previous versions of GeoRegions.jl used to differentiate between Rectilinear (`RectRegion`) and Polygonal (`PolyRegion`) Types of GeoRegions. This is no longer supported in ≥v8.

```@docs
GeoRegions.GeoRegion
```

## The `Geometry` Type

All `GeoRegion`s are defined based on a `Geometry` struct type that contains information on the geometry of a GeoRegion.

```@docs
GeoRegions.Geometry
```

GeoRegions.jl extracts the `Polygon` and `Vector{Point}` information from this `Geometry` type and use the functionalities of [GeometryOps.jl](https://github.com/JuliaGeo/GeometryOps.jl) to perform checks on polygons.