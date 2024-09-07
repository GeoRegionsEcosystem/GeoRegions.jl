# Reading Predefined `GeoRegion`s

The most basic functionality is to retrieve the information of a `GeoRegion`. There are several sets of predefined GeoRegions in GeoRegions.jl, listed [here](predefined).

You can read and retrieve the properties of a `GeoRegion` using the function `GeoRegion()` for a given `ID`.

```julia
geo = GeoRegion(ID)
```

For example, the default `GeoRegion` spans the whole globe, and therefore has the ID `GLB`.

```@example readpredefined
using GeoRegions
geo = GeoRegion("GLB")
```

This is the most basic, and yet the most important, functionality of GeoRegions.jl. For the full API of the function `GeoRegion()` that talks about more advanced uses, see the section on [reading custom GeoRegions](/custom/read)