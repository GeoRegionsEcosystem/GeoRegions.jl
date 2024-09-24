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

## 2. Adding custom `GeoRegion`s to your Project

If you wish to automatically save a new GeoRegions **as it is created**, specify the keyword argument `save = true`. To specify the directory to which the GeoRegion information is saved to, use the `path` keyword.

* `RectRegion(ID, pID, name, ..., save = true, path = ...)` writes to `$path/rectlist.txt`
* `TiltRegion(ID, pID, name, ..., save = true, path = ...)` writes to `$path/tiltlist.txt`
* `PolyRegion(ID, pID, name, ..., save = true, path = ...)` writes to `$path/polylist.txt`

!!! tip "Default `path` Directory"
    By default, `path = joinpath(DEPOT_PATH[1],"files","GeoRegions")`. If `path` is not specified, the information will be saved in the respective custom lists in this directory.

!!! warning "Modification of Custom Lists"
    While it is possible to do manually modify the lists, it is not recommended to do so, especially for `polylist.txt`, which is pretty complicated. Instead, you should let GeoRegions.jl do most of the heavy lifting.

You can also add a `GeoRegion` variable in the workspace that you have not yet saved into the custom lists

```julia
geo = PolyRegion(ID, pID, name, ...)
add(geo, path = ...)
```

```@example projects
RectRegion("TSR","GLB","Test Save RectRegion",[40,-20,14,-60],save=true,path=pwd())
geo = PolyRegion("TSP","GLB","Test Save PolyRegion",[10,100,-50,10],[20,10,0,20])
add(geo,path=pwd())
```

## 3. Listing out the custom `GeoRegion`s for your Project

You can create a table of all the `GeoRegion`s that have been saved to `path` using `tableGeoRegions()` as follows.

```julia
tableGeoRegions(;path = ...)
```

For example, we create a table of user-defined and predefined GeoRegions for the current directory `pwd()`.

!!! tip "Custom GeoRegions are always specified first"
    We always specify the custom user-defined GeoRegions first, because those are most relevant to a project.

```@example projects
tableGeoRegions(path=pwd())
```

## 4. Removing a the custom GeoRegions list from your Project

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

```@docs
setupGeoRegions
add
tableGeoRegions
deleteGeoRegions
```