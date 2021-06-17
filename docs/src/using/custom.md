# Adding GeoRegions from Templates

So you have a list of areas that you want to define, but you don't want to enter them in one by one.  What to do?

## Template GeoRegion Files

**Fear not!**  I have template files that one can use to define `RectRegion`s and `PolyRegion`s.  Simply use the `templateGeoRegion()` to copy the templates into a directory of your choice.

!!! note "Defining PolyRegions"
    When defining `PolyRegion`s, the first and last set of (lon,lat) coordinates must be the same (i.e. a **closed** polygon must be defined)

```julia
using GeoRegions
templateGeoRegion("your-file-path-here")
```

```@docs
templateGeoRegions
```

## Reading in GeoRegions from a custom file

We can then read in GeoRegions from your custom file using the function `addGeoRegions()`, which will then read all the GeoRegion information in the file and add it to the list of GeoRegions.

```@repl
using GeoRegions
addGeoRegions("recttest.txt")
GeoRegion("TRP")
```

```@docs
addGeoRegions
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
resetGeoRegions
```
