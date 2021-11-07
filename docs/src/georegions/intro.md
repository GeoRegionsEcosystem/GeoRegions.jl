# What is a GeoRegion?

Simply put, a GeoRegion is a geographic region.  In v1 of GeoRegions.jl, a GeoRegion could only be rectilinear in shape.  However, as of GeoRegions.jl v2, we use Julia `types` to differentiate between rectilinear GeoRegions, and GeoRegions of arbitrary polygonal shape:
* Rectilinear GeoRegions are denoted by the `RectRegion` type
* Polygonal GeoRegions are denoted by the `PolyRegion` type

The main difference between a `PolyRegion` and a `RectRegion`, is that a `PolyRegion` also contains a `mask` field which allows us to extract a data field of a polygonal shape from the rectilinear bounds that are the natural result of a rectilinear grid.

```@docs
GeoRegion
```

In essence, a `GeoRegion` is:
* a geographical region that can be either rectilinear region, or a polygonal shape within a specified rectilinear bound.
* identified by a `regID`
* itself a subregion of a **parent** `GeoRegion` (identified by `parID`, which must itself be a valid `ID`)

!!! tip "Default GeoRegions"
    When using `GeoRegions.jl`, the default `GeoRegion` should generally be the global domain, specified by `GLB` and given by the `[N,S,E,W]` coordinates `[90,-90,360,0]`.  The Global GeoRegion `GLB` is considered to be a subset of itself.
