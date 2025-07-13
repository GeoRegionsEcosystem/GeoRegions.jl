# Reading Predefined `GeoRegion`s

The most basic functionality is to retrieve the information of a `GeoRegion`. There are several sets of predefined GeoRegions in GeoRegions.jl, listed [here](/basics/predefined/listall).

You can read and retrieve the properties of a `GeoRegion` using the function `GeoRegion()` for a given `ID`, which is a `String` type.

```julia
geo = GeoRegion(ID)
```

For example, the default `GeoRegion` spans the whole globe. Its ID is `ID = "GLB"`.

```@example readpredefined
using GeoRegions
geo = GeoRegion("GLB")
```

This is the most basic, and yet the most important, functionality of GeoRegions.jl. For the full API of the function `GeoRegion()` that talks about more advanced uses, see the section on [reading custom GeoRegions](/tutorials/projects/addreadrm#3.-Reading-and-Retrieving-GeoRegions-for-your-Project)

See the API [here](/api/createaddreadrm#Retrieving-GeoRegions)