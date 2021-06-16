# Creating GeoRegions

In this section, we go through the basic steps of creating a GeoRegion, and removing it once defined so it can be redefined.

## Defining a new GeoRegion

We use the functions `RectRegion` and `PolyRegion` to define rectilinear and polygonal regions respectively. For example, we construct the sample `RectRegion` `TRC`
```@repl
using GeoRegions
RectRegion("TRC","GLB","Test Rectangle Region",[30,20,50,10])
```

The GeoRegions will be automatically added to the following files in `joinpath(DEPOT_PATH[1],"files","GeoRegions")`:
* RectRegions will be added to `rectlist.txt`
* PolyRegions will be added to `polylist.txt`

## Removing an existing GeoRegion

If the GeoRegion ID `TRC` already exists, however, this will throw an error
```@repl
using GeoRegions
RectRegion("TRC","GLB","Test Rectangle Region2",[40,20,52,10])
```

To remove an existing GeoRegion, we can use the function `removeGeoRegion`
```@repl
using GeoRegions
removeGeoRegion("TRC")
```

!!! tip "Global GeoRegion"
    The Global GeoRegion `GLB` is considered to be an integral part of the GeoRegions.jl package and therefore it cannot be removed.
```@repl
using GeoRegions
removeGeoRegion("GLB")
```

## Reset the list of GeoRegions

Should one wish to entirely reset the list of GeoRegions, one can call `resetGeoRegions()`:
```@repl
using GeoRegions
resetGeoRegions()
```

And if one wishes to reset the predefined list of GeoRegions, we can do:
```@repl
using GeoRegions
resetGeoRegions(allfiles=true)
```

## APIs

```@docs
RectRegion(
    ::AbstractString,::AbstractString,::AbstractString,
    ::Vector{<:Real}
)
PolyRegion(
    ::AbstractString,::AbstractString,::AbstractString,
    ::Vector{<:Real},::Vector{<:Real}
)
removeGeoRegion(::AbstractString)
```
