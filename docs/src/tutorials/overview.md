# Using GeoRegions.jl to specify custom GeoRegions

New GeoRegions can be no longer automatically saved if so specified. If you wish to automatically save a new GeoRegions **as it is created**, specify the keyword argument `save = true`. To specify the directory to which the GeoRegion information is saved to, use the `path` keyword.

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

```@example using

```

## Calling saved GeoRegions

If a GeoRegion has been saved to a `path`, it and its properties can be called using its `ID` using the function `GeoRegion()`. There is no need to specify the GeoRegion subtype, as `GeoRegion`s with the same `ID` **cannot** be saved to the same `path`, even if they are of different subtypes.

```julia
geo = GeoRegion(ID, path = "<directory>")
```

```@example using

```

## Table of user-defined GeoRegions

You can create a table of all the `GeoRegion`s that have been saved to `path` using `tableGeoRegions()` as follows.

```julia
tableGeoRegions(;path = ...)
```

```@example using

```