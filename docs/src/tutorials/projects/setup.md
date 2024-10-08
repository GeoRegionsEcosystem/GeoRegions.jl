# GeoRegions.jl for your Research Project

In previous version of GeoRegions.jl (≤v6), we assume that all user-defined GeoRegions were meant to be universally shared. However, we have come to realize that this can cause problems if different projects have similar identifiers (`ID`) for different regions.

Therefore in `v7` and above, GeoRegions.jl explicitly works on a **_project_** basis. This means that:
    * Predefined GeoRegions (GF, SREX and AR6) will still be available as part of the GeoRegions package.
    * All user-defined GeoRegions for a project should entail specification of a project directory using the keyword `path`, so that the GeoRegion can be saved specifically for the project.
    * Retrieving a GeoRegion for a particular project will require specification of the project directory using `path`.
    * By default `path` is the variable `homedir()`

## 1. Setup GeoRegions.jl for your Project

The best way to get started, is to use `setupGeoRegions(path = "<directory>")` in order to copy over the necessary files that will store your custom user-defined GeoRegions.

```@example projects
using GeoRegions
setupGeoRegions(path=pwd())
```

This will copy over the following files: `rectlist.txt`, `polylist.txt`, `tiltlist.txt`, which will stored `RectRegion`s, `PolyRegion`s and `TiltRegion`s respectively.

```@example projects
isfile(joinpath(pwd(),"rectlist.txt")),
isfile(joinpath(pwd(),"polylist.txt")),
isfile(joinpath(pwd(),"tiltlist.txt"))
```

If any of these files already exist in `path`, they will not be overwritten. To specifically overwrite all preexisting user-defined GeoRegions, use the keyword `overwrite = true`.

```@example projects
setupGeoRegions(path=pwd(),overwrite=true)
```

See the API [here](/api/project#GeoRegions.setupGeoRegions)

## 2. Listing out the custom `GeoRegion`s for your Project

You can create a table of all the `GeoRegion`s that have been saved to `path` using `tableGeoRegions()` as follows.

```julia
tableGeoRegions(;path = ...)
```

For example, we create a table of user-defined and predefined GeoRegions for the current directory `pwd()`.

!!! tip "Custom GeoRegions are always specified first"
    We always specify the custom user-defined GeoRegions first, because those are most relevant to a project.

```@example projects
tableGeoRegions(path=pwd(),predefined=false)
```

Note, we have no custom GeoRegions added, so there is nothing to list right now even though the files exist. If any of `rectlist.txt`, `polylist.txt` and `tiltlist.txt` are not present, a warning will be shown unless the keyword `warn = false` is set.

See the API [here](/api/project#GeoRegions.tableGeoRegions)

## 3. Removing a the custom GeoRegions list from your Project

Say you want to completely clear your project of custom GeoRegions, replacing them with new lists. You can just delete the files directly, or you can do `deleteGeoRegions()`.

!!! tip "Default `path` is `pwd()`"
    For `deleteGeoRegions()`, the default `path` is the current directory `pwd()`.

```@example projects
deleteGeoRegions()
```

And then we see if `rectlist.txt` exists!

```@example projects
isfile(joinpath(pwd(),"rectlist.txt")),
isfile(joinpath(pwd(),"polylist.txt")),
isfile(joinpath(pwd(),"tiltlist.txt"))
```

See the API [here](/api/project#GeoRegions.deleteGeoRegions)