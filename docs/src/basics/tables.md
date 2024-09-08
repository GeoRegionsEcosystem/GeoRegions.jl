# Tabular Listings of GeoRegions

A list of GeoRegions and their basic properties can be called using the function `tableGeoRegions()`, which lists all available GeoRegions, both predefined and [custom/user-defined](/custom/overview). You can also choose to list only predefined or user-customized GeoRegions by setting their respective keywords arguments to `true/false`.

```julia
tableGeoRegions()
```

!!! tip "Additional Functionality for `tableGeoRegions()`"
    It is possible to use `tableGeoRegions()` to list user-defined `GeoRegion`s in specific paths/directories. By default, it will list user-defined `GeoRegion`s saved into the path `joinpath(DEPOT_PATH[1],"files","GeoRegions")`. For more on user-defined GeoRegions and saving them as part of a larger project, refer to how to [setup](/custom/setup) GeoRegions.jl for a project. Full API documentation for `tableGeoRegions()` is given [here](/custom/overview).

## More specific lists of GeoRegions

Besides listing all available GeoRegions, it is also possible to list a variety of different subtypes of GeoRegions with the `tableRectRegions()`, `tableTiltRegions()` and `tablePolyRegions()`.

```@docs
tableRectRegions
tableTiltRegions
tablePolyRegions
```