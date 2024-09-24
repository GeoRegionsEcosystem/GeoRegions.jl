# Manipulation of User-Defined GeoRegions.jl for your Project

In this tutorial, we will show you the ropes of adding, retrieving the information of, and removing `GeoRegion`s for a project.

```@example addreadremove
using GeoRegions
mkpath(joinpath(pwd(),"test"))
setupGeoRegions(path=joinpath(pwd(),"test"))
```

## 1. Adding custom `GeoRegion`s to your Project

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

For example, we can do

```@example addreadremove
geo = PolyRegion("TSP","GLB","Test Save PolyRegion",[10,100,-50,10],[20,10,0,20])
add(geo,path=joinpath(pwd(),"test"))
```

Or we can just directly add the GeoRegion simultaneously when it is defined, as follows:

```@example addreadremove
RectRegion("TSR","GLB","Test Save RectRegion",[40,-20,14,-60],save=true,path=joinpath(pwd(),"test"))
```

## 2. Check if GeoRegions have been added

Now that we have added some user-defined custom GeoRegions, let us see if they can be listed using `tableGeoRegions()`:

```@example addreadremove
tableGeoRegions(path=joinpath(pwd(),"test"),crop=true)
```

And we see that yes, we can confirm their addition to the files.

## 3. Reading and Retrieving GeoRegions for your Project

So now that we have saved information on the abovementioned user-defined GeoRegions, let's see if we can retrieve the information on these GeoRegions:

```@example addreadremove
ply = GeoRegion("TSP",path=joinpath(pwd(),"test"))
```

Let's try retrieving the shape of this `PolyRegion`

```@example addreadremove
lon,lat = coordinates(ply)
```

## 4. Removing a the custom GeoRegions list from your Project

Say you want to completely clear your project of custom GeoRegions, replacing them with new lists. You can just delete the files directly, or you can do `deleteGeoRegions()`.

!!! tip "Default `path` is `pwd()`"
    For `deleteGeoRegions()`, the default `path` is the current directory `pwd()`.

```@example addreadremove
deleteGeoRegions(path=joinpath(pwd(),"test"))
```

Let's test and see if we can retrieve the user-defined GeoRegions now we have deleted their information from the project.

```@example addreadremove
GeoRegion("TSR",path=joinpath(pwd(),"test"))
```