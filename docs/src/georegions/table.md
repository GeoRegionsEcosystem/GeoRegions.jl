# A Table of GeoRegions

A list of GeoRegions and their basic properties can be called using the function `tableGeoRegions()`, which lists all available GeoRegions, both predefined and custom/user-defined.

```@repl
using GeoRegions
resetGeoRegions(allfiles=true)
tableGeoRegions()
```

## More specific lists of GeoRegions

Besides listing all available GeoRegions, it is also possible to list a variety of different specifications of GeoRegions with the `tableGeoRegions()` function, as well as `tableRectRegions()` and `tablePolyRegions()`.
