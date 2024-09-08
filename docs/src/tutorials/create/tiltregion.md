# Defining New `TiltRegion`s

Text

```julia
TiltRegion(ID, pID, name, X, Y, ΔX, ΔY, θ)
```

## Example

As an example construct the sample `TiltRegion`, with `ID` `TTR`, `pID` `GLB` and with the `name` as `Test Rectangle Region`

```@repl
using GeoRegions
RectRegion("TTR","GLB","Test Rectangle Region",10,5,50,20,30)
```

## API

```@docs
TiltRegion(
    ::AbstractString, ::AbstractString, ::AbstractString,
    ::Real, ::Real, ::Real, ::Real, ::Real
)
```