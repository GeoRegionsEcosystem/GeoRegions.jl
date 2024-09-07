# Defining new GeoRegions

Recall that there are three different types of `GeoRegion`s: (a) `RectRegion`s, (b) `TiltRegion`s and (c) `PolyRegion`s.

We use the functions `RectRegion()`, `TiltRegion()` and `PolyRegion` to create new `GeoRegion`s of their respective types.
!!! warn "saving GeoRegions"
    As of GeoRegions.jl ≥v7, the abovementioned functions no longer automatically save GeoRegions.jl into the directory `joinpath(DEPOT_PATH[1],"files","GeoRegions")`. If you wish to automatically save new GeoRegions **as they are created** by these functions, specify the keyword argument `save = true`.

Regardless of `GeoRegion` type, the **first three inputs are always the same**, in respective order:
1. The ID (`ID`)
2. parent `GeoRegion` ID, (`pID`)
3. Name of the GeoRegion (`name`)

!!! note "`ID` and `pID`"
    When `save = true`, the GeoRegion `pID` must already have been previously defined, and the region defined by the GeoRegion `ID` must be entirely within the region defined by the GeoRegion `pID`.

## Defining a new RectRegion

Out of all three `GeoRegion` types currently available, the `RectRegion` is the easiest to define. All you need to do is specify the `[N, S, E, W]` boundaries, in that order.

```@docs
RectRegion(
    ::AbstractString,::AbstractString,::AbstractString,
    ::Vector{<:Real}
)
```