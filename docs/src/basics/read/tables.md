# Tabular Listings of GeoRegions

A list of GeoRegions and their basic properties can be called using the function `tableGeoRegions()`, which lists all available GeoRegions, both predefined and [user-defined](/tutorials/overview). You can also choose to list only predefined or user-customized GeoRegions by setting their respective keywords arguments to `true/false`.

```julia
tableGeoRegions(predefined = true/false, custom = true/false)
```

!!! tip "Additional Functionality for `tableGeoRegions()`"
    It is possible to use `tableGeoRegions()` to list user-defined `GeoRegion`s in specific paths/directories. By default, it will list user-defined `GeoRegion`s saved into the path `joinpath(DEPOT_PATH[1],"files","GeoRegions")`. For more on user-defined GeoRegions and saving them as part of a larger project, refer to how to [setup](/tutorials/setup) GeoRegions.jl for a project. Full API documentation for `tableGeoRegions()` is given [here](/tutorials/overview#Table-of-user-defined-GeoRegions).

## More specific lists of GeoRegions

Besides listing all available GeoRegions, it is also possible to list a variety of different subtypes of GeoRegions with the `tableRectRegions()`, `tableTiltRegions()` and `tablePolyRegions()`.

```julia
tableRectRegions(giorgi = true/false, custom = true/false)
tableTiltRegions()
tablePolyRegions(srex = true/false, ar6 = true/false, custom = true/false)
```

!!! tip "`GLB` Region will always appear"
    The `GLB` GeoRegion will always appear in the table, because it is the ultimate parent GeoRegion. All other `GeoRegion`s will always in some manner be a subset of the `GLB` GeoRegion.

## Use Case Examples

:::tabs

== tableGeoRegions()

```@example tablesimple
using GeoRegions
tableGeoRegions()
```

== tableRectRegions()

```@example tablesimple
using GeoRegions
tableRectRegions()
```

== tablePolyRegions()

```@example tablesimple
using GeoRegions
tablePolyRegions()
```

== tableTiltRegions()

!!! info "No predefined `TiltRegion`s"
    There are no predefined `TiltRegion`s in GeoRegions.jl, so calling `tableTiltRegions()` will only return the `GLB` GeoRegion.

```@example tablesimple
using GeoRegions
tableTiltRegions()
```

:::