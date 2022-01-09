# Tabular Listings of GeoRegions

A list of GeoRegions and their basic properties can be called using the function `tableGeoRegions()`, which lists all available GeoRegions, both predefined and custom/user-defined.

```@repl
using GeoRegions
resetGeoRegions(allfiles=true)
tableGeoRegions(onlycustom=true)
```

```@docs
tableGeoRegions(; onlycustom::Bool)
```

## More specific lists of GeoRegions

Besides listing all available GeoRegions, it is also possible to list a variety of different specifications of GeoRegions with the `tableGeoRegions()` function, as well as `tableRectRegions()` and `tablePolyRegions()`.

```@docs
tableRectRegions
tablePolyRegions
```

## Listing GeoRegions inside a Custom File

Similarly, it is also possible to list the GeoRegions in custom files. The template for these files can be retrieved using the function `templateGeoRegions()`

```@docs
tableGeoRegions(fname::AbstractString)
```

## Master List of All Predefined GeoRegions
```@repl
using GeoRegions
resetGeoRegions(allfiles=true)
tableGeoRegions()
```