# Creating Custom GeoRegions

Recall that there are three different types of `GeoRegion`s: (a) `RectRegion`s, (b) `TiltRegion`s and (c) `PolyRegion`s.

## Creating new GeoRegions

We use the functions `RectRegion()`, `TiltRegion()` and `PolyRegion` to create new `GeoRegion`s of their respective types. Regardless of `GeoRegion` type, the **first three inputs are always the same**, in respective order:
1. The ID (`ID`)
2. parent `GeoRegion` ID, (`pID`)
3. Name of the GeoRegion (`name`)

```julia
RectRegion(ID, pID, name, ...)
TiltRegion(ID, pID, name, ...)
PolyRegion(ID, pID, name, ...)
```

## Defining New `RectRegion`s

Out of all three `GeoRegion` types currently available, the `RectRegion` is most straightforward to define. All you need to do is specify the `[N, S, E, W]` boundaries, in that order.

!!! tip "Constraints on N, S, E, W bounds"
    The following are the constraints on the North, South, East and West bounds:
    1. N > S
    2. E > W
    3. -90 ≤ N,S ≤ 90
    4. -180 ≤ E,W ≤ 360
    5. (E - W) < 360

```julia
RectRegion(ID, pID, name, [N, S, E, W])
```

As an example construct the sample `RectRegion`, with `ID` `TRR`, `pID` `GLB` and with the `name` as `Test Rectangle Region`

```@repl
using GeoRegions
RectRegion("TRR","GLB","Test Rectangle Region",[30,20,50,10])
```

## Defining New `PolyRegion`s

Out of all three `GeoRegion` types currently available, the `PolyRegion` grants the most flexibility in terms of specification of the domain shape. With it, you can specify any closed polygon on a rectilinear grid using two vectors, for `lon` and `lat` respectively.

!!! tip "Longitude and Latitude Vectors must be the same length"
    As state in the header, the `lon` and `lat` vectors must be of the same length.

```julia
PolyRegion(ID, pID, name, lon, lat)
```

For example, we construct the sample `RectRegion` `TPR`, with longitude (`lon`) and latitude (`lat`) vectors of `[30,40,50,40,30]` and `[20,30,20,10,20]`

```@repl
using GeoRegions
PolyRegion("TPR","GLB","Test Polygonal Region",[30,40,50,40,30],[20,30,20,10,20])
```

## Defining New `TiltRegion`s

Text

```julia
TiltRegion(ID, pID, name, X, Y, ΔX, ΔY, θ)
```

As an example construct the sample `TiltRegion`, with `ID` `TTR`, `pID` `GLB` and with the `name` as `Test Rectangle Region`

```@repl
using GeoRegions
RectRegion("TTR","GLB","Test Rectangle Region",10,5,50,20,30)
```
