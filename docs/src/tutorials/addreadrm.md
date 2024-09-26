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

See the API [here](/api/addreadrm#GeoRegions.add)

Or we can just directly add the GeoRegion simultaneously when it is defined, as follows:

```@example addreadremove
RectRegion("TSR","GLB","Test Save RectRegion",[40,-20,14,-60],save=true,path=joinpath(pwd(),"test"))
```

See the API [here](/api/create)

## 2. Check if GeoRegions have been added

Now that we have added some user-defined custom GeoRegions, let us see if they can be listed using `tableGeoRegions()`:

```@example addreadremove
tableGeoRegions(path=joinpath(pwd(),"test"),crop=true)
```

And we see that yes, we can confirm their addition to the files.

Alternatively, we can check if the `ID`s have been added using the function `isID`:

```@example addreadremove
isID("TSR",path=joinpath(pwd(),"test")),
isID("TSP",path=joinpath(pwd(),"test"))
```

See the API [here](/api/addreadrm#GeoRegions.isID)

## 3. Reading and Retrieving GeoRegions for your Project

So now that we have saved information on the abovementioned user-defined GeoRegions, let's see if we can retrieve the information on these GeoRegions:

```@example addreadremove
ply = GeoRegion("TSP",path=joinpath(pwd(),"test"))
```

Let's try retrieving the shape of this `PolyRegion`

```@example addreadremove
lon,lat = coordinates(ply)
```

See the API [here](/api/addreadrm#GeoRegions.GeoRegion-Tuple{AbstractString})

## 4. Overwriting Information for a Previously Defined GeoRegion

Once a GeoRegion associated with an `ID` has been saved into the directory named `path`, this `ID` can no longer be used in association with another GeoRegion for this Project. Therefore, you cannot save another GeoRegion of this `ID` into the same project.

```@repl addreadremove
geo = PolyRegion("TSP","GLB","Test Save PolyRegion 2",[10,90,-50,10],[20,10,0,20])
add(geo,path=joinpath(pwd(),"test"))
```

We see that we cannot add another GeoRegion with the `ID = TSP`. In order to replace the GeoRegion associated with this `ID` with another set of information, you need to _**overwrite**_ the preexisting information with `overwrite()`

```@example addreadremove
overwrite(geo,path=joinpath(pwd(),"test"))
```

And we reload the GeoRegion associated with the `ID = TSP`

```@example addreadremove
ply = GeoRegion("TSP",path=joinpath(pwd(),"test"))
```

See the API [here](/api/addreadrm#GeoRegions.overwrite)

## 5. Removing a custom GeoRegions from your Project

Now, we've realized that you don't really need a `GeoRegion` anymore, or for some reason you want to delete the information of a particular `GeoRegion` associate with a certain `ID` and replace it with a new information, there are two ways to do it:

### 5.1 Removing a GeoRegion that has been loaded

THe first method is to remove a GeoRegion `geo` that has already been loaded into the workspace. We use the function `rm()` to do this

```@example addreadremove
rm(ply,path=joinpath(pwd(),"test"))
```

And now we check if the `GeoRegion` `TSP` now exists:

```@example addreadremove
isID("TSP",path=joinpath(pwd(),"test"))
```

And we see that it does not.

See the API [here](/api/addreadrm#Base.Filesystem.rm)

### 5.2 Removing a GeoRegion based on its `ID`

The second method is to remove a `GeoRegion` based on an `ID`, or its `string` identifier. We do this with the function `rmID()`

```@example addreadremove
rmID("TSR",path=joinpath(pwd(),"test"))
```

```@repl addreadremove
isID("TSR",path=joinpath(pwd(),"test"))
```

!!! tip "Predefined `GeoRegion`s cannot be removed"
    You cannot remove `GLB`, `GF_*`, `SRX_*` or `AR6_*` that have been predefined in GeoRegions.jl

See the API [here](/api/addreadrm#GeoRegions.rmID)

## 6. Removing a the custom GeoRegions lists from your Project

If you use `deleteGeoRegions()` to remove all the custom lists, you will remove **all** the custom GeoRegions for the projects and they cannot be retrieved.

```@example addreadremove
TiltRegion("TST","GLB","Test Save TiltRegion",10,5,50,20,30,path=joinpath(pwd(),"test"))
```

```@example addreadremove
deleteGeoRegions(path=joinpath(pwd(),"test"))
```

Let's test and see if we can retrieve the user-defined GeoRegions now we have deleted their information from the project.

```@repl addreadremove
isID("TST",path=joinpath(pwd(),"test"),throw=false)
```