# Defining New `PolyRegion`s

Out of all three `GeoRegion` types currently available, the `PolyRegion` grants the most flexibility in terms of specification of the domain shape. With it, you can specify any closed polygon on a rectilinear grid using two vectors, for `lon` and `lat` respectively.

!!! tip "Longitude and Latitude Vectors must be the same length"
    As state in the header, the `lon` and `lat` vectors must be of the same length.

```julia
PolyRegion(ID, pID, name, lon, lat)
```

## Example

For example, we construct the sample `RectRegion` `TPR`, with longitude (`lon`) and latitude (`lat`) vectors of `[30,40,50,40,30]` and `[20,30,20,10,20]`

```@repl
using GeoRegions
PolyRegion("TPR","GLB","Test Polygonal Region",[30,40,50,40,30],[20,30,20,10,20])
```

## API

```@docs
PolyRegion(
    ::AbstractString, ::AbstractString, ::AbstractString,
    ::Vector{<:Real}, ::Vector{<:Real}
)
```