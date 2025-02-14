# Manipulation of User-Defined GeoRegions.jl for your Project

In this tutorial, we will show you the ropes of adding, retrieving the information of, and removing `GeoRegion`s for a project.

```@example addreadremove
using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing
```

We start off by defining a test directory:

```@example addreadremove
mkpath(joinpath(pwd(),"test"))
setupGeoRegions(path=joinpath(pwd(),"test"))
```

## 1. Adding custom `GeoRegion`s to your Project

If you wish to automatically save a new GeoRegions **as it is created**, specify the keyword argument `save = true`. To specify the directory to which the GeoRegion information is saved to, use the `path` keyword.

* `GeoRegion (ID, pID, name, ..., save = true, path = ...)` writes to `$path/.georegions/$ID.json`

!!! tip "Default `path` Directory"
    By default, `path = joinpath(homedir(),".georegions")`. If `path` is not specified, the information will be saved in the respective custom lists in this directory.

You can also add a `GeoRegion` variable in the workspace that you have not yet saved into the custom lists

```julia
geo = GeoRegion(lon, lat, ID = ..., pID = ..., name = ..., ...)
add(geo, path = ...)
```

For example, we can do

```@example addreadremove
geo = GeoRegion(
    [10,100,-50,10],[20,10,0,20],
    ID = "TST", pID = "GLB", name = "Test Save GeoRegion 1"
)
add(geo,path=joinpath(pwd(),"test"))
```

See the API [here](/api/createaddreadrm#Adding-Custom-GeoRegions)

Or we can just directly add the GeoRegion simultaneously when it is defined, as follows:

```@example addreadremove
GeoRegion(
    [3,8,5,3],[40,-20,14,40],
    ID = "TST2", pID = "GLB", name = "Test Save GeoRegion 2",
    save = true, path = joinpath(pwd(),"test")
)
```

See the API [here](/api/createaddreadrm#Creating-GeoRegions)

## 2. Check if GeoRegions have been added

Now that we have added some user-defined custom GeoRegions, let us see if they can be listed using `tableGeoRegions()`:

```@example addreadremove
tableGeoRegions(path=joinpath(pwd(),"test"),crop=true)
```

And we see that yes, we can confirm their addition to the files.

Alternatively, we can check if the `ID`s have been added using the function `isID`:

```@example addreadremove
isID("TST",path=joinpath(pwd(),"test"))
```

See the API [here](/api/isinonequal#Equivalence-of-GeoRegion-IDs)

## 3. Reading and Retrieving GeoRegions for your Project

So now that we have saved information on the abovementioned user-defined GeoRegions, let's see if we can retrieve the information on these GeoRegions:

```@example addreadremove
geo1 = GeoRegion("TST",path=joinpath(pwd(),"test"))
```

Let's try retrieving and plotting the shape of this `GeoRegion`

```@example addreadremove
lon,lat = coordinates(geo1)

aspect = (geo1.E-geo1.W+4)/(geo1.N-geo1.S+4)
fig = Figure()
ax = Axis(
    fig[1,1],width=750,height=750/aspect,
    limits=(geo1.W-2,geo1.E+2,geo1.S-2,geo1.N+2)
)
lines!(ax,clon,clat,color=:black,linewidth=3)
lines!(ax,lon,lat,linewidth=5)
resize_to_layout!(fig)
fig
```

See the API [here](/api/createaddreadrm#Retrieving-GeoRegions)

### 3.1 Loading all custom GeoRegions for your Project

If you have multiple GeoRegions saved in your project and you want to load all of them as a vector, you can use the `loadGeoRegions()` function

```@example addreadremove
geovec = loadGeoRegions(path=joinpath(pwd(),"test"))
```

Which returns a `Vector` of `GeoRegion` types.

!!! tip "`GLB` is automatically included"
    The `GLB` GeoRegion will automatically be included in this vector, so your vector will always have at least 1 element inside it.

See the API [here]()

## 4. Overwriting Information for a Previously Defined GeoRegion

Once a GeoRegion associated with an `ID` has been saved into the directory named `path`, this `ID` can no longer be used in association with another GeoRegion for this Project. Therefore, you cannot save another GeoRegion of this `ID` into the same project.

```@repl addreadremove
geo2 = GeoRegion(
    [10,90,-50,10],[20,10,0,20],
    ID = "TST", pID = "GLB", name = "Test Save PolyRegion 2"
)
add(geo2,path=joinpath(pwd(),"test"))
```

We see that we cannot add another GeoRegion with the `ID = TSP`. In order to replace the GeoRegion associated with this `ID` with another set of information, you need to _**overwrite**_ the preexisting information with `overwrite()`

```@example addreadremove
overwrite(geo2,path=joinpath(pwd(),"test"))
```

And we reload the GeoRegion associated with the `ID = TSP`

```@example addreadremove
geo3 = GeoRegion("TST",path=joinpath(pwd(),"test"))
```

See the API [here](/api/createaddreadrm#Overwriting-Custom-GeoRegions)

## 5. Removing a custom GeoRegions from your Project

Now, we've realized that you don't really need a `GeoRegion` anymore, or for some reason you want to delete the information of a particular `GeoRegion` associate with a certain `ID` and replace it with a new information, there are two ways to do it:

### 5.1 Removing a GeoRegion that has been loaded

THe first method is to remove a GeoRegion `geo` that has already been loaded into the workspace. We use the function `rm()` to do this

```@example addreadremove
rm(geo3,path=joinpath(pwd(),"test"))
```

And now we check if the `GeoRegion` `TSP` now exists:

```@repl addreadremove
isID("TST",path=joinpath(pwd(),"test"))
```

And we see that it does not.

See the API [here](/api/createaddreadrm#After-having-loaded-a-Custom-GeoRegion)

### 5.2 Removing a GeoRegion based on its `ID`

The second method is to remove a `GeoRegion` based on an `ID`, or its `string` identifier. We do this with the function `rmID()`

```@example addreadremove
rmID("TST2",path=joinpath(pwd(),"test"))
```

```@repl addreadremove
isID("TST2",path=joinpath(pwd(),"test"))
```

!!! tip "Predefined `GeoRegion`s cannot be removed"
    You cannot remove `GLB`, `GF_*`, `SRX_*` or `AR6_*` that have been predefined in GeoRegions.jl

See the API [here](/api/createaddreadrm#Based-on-the-ID-of-a-Custom-GeoRegion)

## 6. Removing a the custom GeoRegions lists from your Project

If you use `deleteGeoRegions()` to remove all the custom lists, you will remove **all** the custom GeoRegions for the projects and they cannot be retrieved.

```@example addreadremove
GeoRegion(
    [3,8,5,3],[40,-20,14,40],
    ID = "TST", pID = "GLB", name = "Test Save GeoRegion",
    save = true, path = joinpath(pwd(),"test")
)
```

```@example addreadremove
deleteGeoRegions(path=joinpath(pwd(),"test"))
```

Let's test and see if we can retrieve the user-defined GeoRegions now we have deleted their information from the project.

```@repl addreadremove
isID("TST",path=joinpath(pwd(),"test"),throw=false)
```