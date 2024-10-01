# API for Tables in GeoRegions.jl

## All Regions
```@docs
tableGeoRegions(;
    path :: AbstractString = homedir(),
    predefined :: Bool = true,
    custom     :: Bool = true,
    warn :: Bool = true,
    crop :: Bool = false
)
```

## Only RectRegions

```@docs
tableRectRegions
```

## Only TiltRegions

```@docs
tableTiltRegions
```

## Only PolyRegions

```@docs
tablePolyRegions
```