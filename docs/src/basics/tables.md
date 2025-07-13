# Tabular Listings of GeoRegions

A list of GeoRegions and their basic properties can be called using the function `tableGeoRegions()`, which lists all available GeoRegions, both predefined and [user-defined](/basics/create). You can also choose to list only predefined or user-customized GeoRegions by setting their respective keywords arguments to `true/false`.

```julia
tableGeoRegions(predefined = true/false, custom = true/false)
```

!!! tip "Additional Functionality for `tableGeoRegions()`"
    It is possible to use `tableGeoRegions()` to list user-defined `GeoRegion`s in specific paths/directories. By default, it will list user-defined `GeoRegion`s saved into the path `joinpath(homedir(),".georegions")`. For more on user-defined GeoRegions and saving them as part of a larger project, refer to how to [setup](/tutorials/projects/setup) GeoRegions.jl for a project.

## Use Case Examples

```@example tablesimple
using GeoRegions
tableGeoRegions(warn=false,crop=true)
```

See the API [here](/api/tables)

## More specific Tabular Lists of GeoRegions

You may create tables of specific sets of predefined GeoRegions that come with GeoRegions.jl, as listed [here](/basics/predefined/listall).