# Creating GeoRegions

In this section, we go through the basic steps of creating a GeoRegion, and removing it once defined so it can be redefined.

## Defining a new GeoRegion

We use the functions `RectRegion` and `PolyRegion` to define rectilinear and polygonal regions respectively. For example, we construct the sample `RectRegion` `TRC`
```@repl
using GeoRegions
RectRegion("TRC","GLB","Test Rectangle Region",[30,20,50,10])
PolyRegion("TPL","GLB","Test Polygonal Region",[30,40,50,40,30],[20,30,20,10,20])
```

!!! note "Defining PolyRegions"
    When defining `PolyRegion`s, the first and last set of (lon,lat) coordinates must be the same (i.e. a **closed** polygon must be defined)

The GeoRegions will be automatically added to the following files in `joinpath(DEPOT_PATH[1],"files","GeoRegions")`:
* RectRegions will be added to `rectlist.txt`
* PolyRegions will be added to `polylist.txt`

If the GeoRegion ID `TRC` already exists, however, this will throw an error
```@repl
using GeoRegions
RectRegion("TRC","GLB","Test Rectangle Region2",[40,20,52,10])
```
```@docs
RectRegion(
    ::AbstractString,::AbstractString,::AbstractString,
    ::Vector{<:Real}
)
PolyRegion(
    ::AbstractString,::AbstractString,::AbstractString,
    ::Vector{<:Real},::Vector{<:Real}
)
```

## Is it already a GeoRegion?

Sometimes we would like to independently check if an `ID` has already been used.  We can use the function `isGeoRegion()` to perform this check`
If the GeoRegion ID `TRC` already exists, however, this will throw an error

```@docs
isGeoRegion
```

```@repl
using GeoRegions
isGeoRegion("AR6_SEA")
isGeoRegion("RND",throw=false)
isGeoRegion("RND")
```

## Removing an existing GeoRegion

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

```@docs
removeGeoRegion(::AbstractString)
```

## List of All GeoRegions

If you want to check the list of all GeoRegions that have been defined, use the function `listGeoRegions()`
```@repl
using GeoRegions
geovec,filevec,typevec = listGeoRegions();
geovec
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

```@docs
listGeoRegions
```
