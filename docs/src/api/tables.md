# API for Tables in GeoRegions.jl

```@docs
tableGeoRegions(;
    path :: AbstractString = homedir(),
    predefined :: Bool = true,
    custom     :: Bool = true,
    warn :: Bool = true,
    crop :: Bool = false
)
tableRectRegions
tableTiltRegions
tablePolyRegions
```