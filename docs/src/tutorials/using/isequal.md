# Equivalence between GeoRegions and their Properties

Now, suppose we have two different GeoRegions, we have constructed several different ways of testing various forms of equivalence.

```@example equivalence
using GeoRegions
```

## 1. Are two GeoRegions Equivalent

If you want to check that two GeoRegions are equivalent, we can use the `==` or `isequal()` functions.

For `==` or `isequal()` to return true, the following conditions must be satisfied:
* The `ID` and `pID` fields are the same
* The `shape` fields define exactly the same geographic region as per the function [`on()`](/tutorials/using/ison)

Let us consider the following example. First, we load a `GeoRegion` and extract its `lon` and `lat` coordinates

```@example equivalence
geo = GeoRegion("AR6_NWS")
lon,lat = coordinates(geo)
nothing
```

We define `GeoRegion`s that are of the same shape (note that because `save = false` that the same `ID` can be used to define these GeoRegions):
```@example equivalence
geo2 = GeoRegion(lon,     lat,ID="AR6_NWS",pID="GLB",name="TSTNWS") # Different name
geo3 = GeoRegion(lon,     lat,ID="TST_NWS",pID="GLB",name=geo.name) # Different ID
geo4 = GeoRegion(lon,     lat,ID="AR6_NWS",pID="TST",name=geo.name) # Different pID
geo5 = GeoRegion(lon.+360,lat,ID="AR6_NWS",pID="GLB",name=geo.name) # Shifted by 360º
```

And we perform the tests with `==`:

```@example equivalence
geo == geo2, # true,  name is not a factor in considering equivalence
geo == geo3, # false, different ID
geo == geo4, # false, different pID
geo == geo5  # true,  shape is same even if shifted by 360
```

See the API [here](/api/isinonequal#Equivalence-of-GeoRegions)

And we perform the tests with `isequal()`

```@example equivalence
isequal(geo,geo2), # true,  name is not a factor in considering equivalence
isequal(geo,geo3), # false, different ID
isequal(geo,geo4), # false, different pID
isequal(geo,geo5)  # true,  shape is same even if shifted by 360
```

See the API [here](/api/isinonequal#Equivalence-of-GeoRegions)

## 2. Does there already exist a GeoRegion?

Sometimes, we want to figure out if there exists a `GeoRegion` `geo` in a project we have defined (for more information on how to use GeoRegions.jl in projects, see [here](/tutorials/projects/setup) and [here](/tutorials/projects/addreadrm)). We can use the function `isgeo()` to determine if this is the case. For `isgeo()` to be true, there must exist another `GeoRegion` `ogeo` such that `isequal(geo,ogeo) = true`.

```@example equivalence
geo_NWS = GeoRegion(lon,lat,ID="AR6_NWS",pID="GLB",name="New Southeast Asia")
isgeo(geo_NWS)
```

We see here that `isgeo(geo_NWS) = true` because the `ID`, `pID` and `shape` of the newly defined `geo_NWS` is the same as `geo`.

See the API [here](/api/isinonequal#Does-this-GeoRegion-already-Exist?)

## 3. Property Checks for GeoRegions

Sometimes, we don't want to check if a `GeoRegion` specifically exists. Sometimes, we just want to check if an `ID` or a `shape` already exists in the current project.

### 3.1 Checking if an `ID` already exists

The function `isID()` allows us to check if an `ID` is already in use for a current project.

```@example equivalence
isID("GF_SEA"), isID("AR6_SEA")
```

See the API [here](/api/isinonequal#Equivalence-of-GeoRegion-IDs)

### 3.2 Checking if a GeoRegion has an equivalent `shape`

The function `isgeoshape()` allows us to check if another GeoRegion in the project has an equivalent `shape` to a GeoRegion that is currently defined in the workspace.

```@example equivalence
geo_tmp1 = GeoRegion(lon,lat) # lon,lat taken from above example
isgeo(geo_tmp1),                # should be false
isgeoshape(geo_tmp1) # should be true
```

See the API [here](/api/isinonequal#Equivalence-of-GeoRegion-Shapes)

### 3.3 Checking if a `shape` defined by (lon,lat) is defined in an existing GeoRegion

The function `isgeoshape()` also allows us to check if another GeoRegion in the project has an equivalent `shape` to a workspace-defined shape of longitude and latitude points

```@example equivalence
isgeoshape(lon,lat),                    # lon,lat taken from above example
isgeoshape([20,30,40,20],[10,30,10,10]) # Randomly defined lon,lat
```

The first is true but the second is false.

See the API [here](/api/isinonequal#Equivalence-of-GeoRegion-Shapes)