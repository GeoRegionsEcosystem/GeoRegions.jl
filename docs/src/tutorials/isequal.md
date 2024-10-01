# Equivalence between GeoRegions and their Properties

Now, suppose we have two different GeoRegions, we have constructed several different ways of testing various forms of equivalence.

```@example equivalence
using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing
```

## 1. Are two GeoRegions Equivalent

If you want to check that two GeoRegions are equivalent, we can use the `==` or `isequal()` functions.


### 1. Strict Equivalence

For `==` or `isequal(geo1,geo2,strict = true)` to return true, the following conditions must be satisfied:
* The `ID` and `pID` fields are the same
* The `shape` fields define exactly the same geographic region as per the function [`on()`](/basics/using/ison)
* The `GeoRegion` must be of the same `type` (i.e., a `RectRegion` will not considered to be equivalent to a `PolyRegion` even if they have the same shape)

Let us consider the following example. First, we load a `RectRegion` and extract its `lon` and `lat` coordinates

```@example equivalence
geo = GeoRegion("GF_SEA")
lon,lat = coordinates(geo)
nothing
```

We define `RectRegion`s that are of the same shape (note that because `save = false` that the same `ID` can be used to define these GeoRegions):
```@example equivalence
geo2 = RectRegion("GF_SEA","GLB","",geo.bound) # Different name
geo3 = RectRegion("SEA","GLB",geo.name,geo.bound) # Different ID
geo4 = PolyRegion("GF_SEA","GLB",geo.name,lon,lat) # Different ID
geo5 = PolyRegion("GF_SEA","GLB","",lon,lat) # Different ID
geo6 = PolyRegion("GF_SEA","GLB",geo.name,lon.+360,lat) # Shifted by 360º
```

And we perform the tests with `==`:

```@example equivalence
geo == geo2, # true,  name is not a factor in considering equivalence
geo == geo3, # false, different ID
geo == geo4  # false, different GeoRegion type
```

See the API nfor `==` [here](/api/isinonequal#Base.==)

And we perform the tests with `isequal()`

```@example equivalence
isequal(geo,geo2), # true,  name is not a factor in considering equivalence
isequal(geo,geo3), # false, different ID
isequal(geo,geo4)  # false, different GeoRegion type
```

See the API nfor `isequal()` [here](/api/isinonequal#Base.isequal)

### 1.2 Non-Strict Equivalence

`isequal()` also has a `strict = false` option, where we do not care if the `GeoRegion`s being compared are of the same `type` (i.e., a `RectRegion` can be equivalent to a `PolyRegion` as long as the `ID`, `pID` and `shape` fields are equivalent).

So, we can see that

```@example equivalence
isequal(geo,geo4,strict=false), # true, the shape is the same even though the GeoRegions are of differen types
isequal(geo,geo5,strict=false), # false, the ID is different
isequal(geo,geo6,strict=false) # true, shape is same even tho shift is by 360º
```

## 2. Does there already exist a GeoRegion?

Sometimes, we want to figure out if there exists a `GeoRegion` `geo` in a project we have defined (for more information on how to use GeoRegions.jl in projects, see [here](/tutorials/projects)). We can use the function `isgeo()` to determine if this is the case. For `isgeo()` to be true, there must exist another `GeoRegion` `ogeo` such that `isequal(geo,ogeo) = true`.

```@example equivalence
geo_SEA = RectRegion("GF_SEA","GLB","New Southeast Asia",geo.bound)
isgeo(geo_SEA)
```

We see here that `isgeo(geo,geo_SEA) = true` because the `ID`, `pID` and `shape` of the newly defined `geo_SEA` is the same as `geo`.

## 3. Property Checks for GeoRegions

Sometimes, we don't want to check if a `GeoRegion` specifically exists. Sometimes, we just want to check if an `ID` or a `shape` already exists in the current project.

### 3.1 Checking if an `ID` already exists

The function `isID()` allows us to check if an `ID` is already in use for a current project.

```@example equivalence
geo_SEA = RectRegion("GF_SEA","GLB","New Southeast Asia",geo.bound)
isgeo(geo_SEA)
```

### 3.1 Checking if a GeoRegion has an equivalent `shape`

The function `isgeoshape()` allows us to check if another GeoRegion in the project has an equivalent `shape`.

```@example equivalence
geo_tmp1 = PolyRegion("TST","GLB","",lon,lat)
isgeoshape("TST",path=pwd())
```

### 3.1 Checking if a `shape` defined by (lon,lat) is defined in an existing GeoRegion

The function `isgeoshape()` also allows us to check if another GeoRegion in the project has an equivalent `shape` to that which would be defined by a set of `lon` and `lat` vectors.

```@example equivalence
isgeoshape(lon,lat,path=pwd())
isgeoshape([20,30,40,20],[10,30,10,10],path=pwd())
```