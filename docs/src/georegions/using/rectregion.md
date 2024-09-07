# Defining New `RectRegion`s

Out of all three `GeoRegion` types currently available, the `RectRegion` is most straightforward to define. All you need to do is specify the `[N, S, E, W]` boundaries, in that order.

```julia
RectRegion(ID, pID, name, [N, S, E, W])
```
## Example

As an example construct the sample `RectRegion`, with `ID` `TRR`, `pID` `GLB` and with the `name` as `Test Rectangle Region`

```@repl
using GeoRegions
RectRegion("TRR","GLB","Test Rectangle Region",[30,20,50,10])
```

!!! tip "Constraints on N, S, E, W bounds"
    The following are the constraints on the North, South, East and West bounds:
    1. N > S
    2. E > W
    3. -90 ≤ N,S ≤ 90
    4. -180 ≤ E,W ≤ 360
    5. (E - W) < 360

## API

```@docs
RectRegion(
    ::AbstractString, ::AbstractString, ::AbstractString,
    ::Vector{<:Real}
)
```