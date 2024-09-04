# What is a GeoRegion?

In essence, a `GeoRegion` is:
* a geographical region of interest
* identified by an `ID`
* itself a subregion of a **parent** `GeoRegion` (identified by `pID`, which must itself be a valid `ID`)

!!! tip "Default GeoRegions"
    When using `GeoRegions.jl`, the default `GeoRegion` should generally be the global domain, specified by `GLB` and given by the `[N,S,E,W]` coordinates `[90,-90,360,0]`.  The Global GeoRegion `GLB` is considered to be a subset of itself.

In GeoRegions.jl, we differentiate between several different types of GeoRegions:
* Rectilinear GeoRegions are denoted by the `RectRegion` type, available in all version of GeoRegions.jl
* Tilted rectangular GeoRegions are denoted by the `TiltRegion` type, available in ≥v6
* Polygonal GeoRegions are denoted by the `PolyRegion` type, available in ≥v2
```@docs
GeoRegion
```

