# API for Creating GeoRegions

## RectRegion

```@docs
RectRegion(
    ::AbstractString, ::AbstractString, ::AbstractString,
    ::Vector{<:Real}
)
```

## TiltRegion

```@docs
TiltRegion(
    ::AbstractString, ::AbstractString, ::AbstractString,
    ::Real, ::Real, ::Real, ::Real, ::Real
)
```

## PolyRegion

```@docs
PolyRegion(
    ::AbstractString, ::AbstractString, ::AbstractString,
    ::Vector{<:Real}, ::Vector{<:Real}
)
```