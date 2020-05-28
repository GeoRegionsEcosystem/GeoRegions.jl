# GeoRegions

The key purpose of `GeoRegions.jl` is to predefine a set of regions, known as `GeoRegion`s, whose properties are saved in a list and can be called upon at moment's notice.  This combined with the data extraction features present in `GeoRegions.jl`, this allows for systematic extraction of rectilinear-gridded geographic data.

This page goes through the following:
1. What is a `GeoRegion`?
2. Getting started with using `GeoRegion`s
3. Finding the properties of a `GeoRegion`
4. Adding custom `GeoRegion`s to the default.

## 1. What is a `GeoRegion`?

In essence, a `GeoRegion` is:
* a **rectilinear** region specified by `[N,W,S,E]` boundaries
* identified by an `ID`
* itself a subregion of a **parent** `GeoRegion` (identified by `pID`, which must themselves be a valid `ID`)

!!! tip "Default GeoRegions"
    When using `GeoRegions.jl`, the default `GeoRegion` should generally be the global domain, specified by `GLB` and given by the `[N,W,S,E]` coordinates `[90,0,-90,360]`.  The Global GeoRegion `GLB` is considered to be a subset of itself.

!!! tip "Predefined GeoRegions"
    `GeoRegions.jl` has itself a list of predefined `GeoRegion`s, which can be found in the directory `$JULIA_DEPOT_PATH/files/GeoRegions/gregions.txt`.  You can query the properties of these `GeoRegion`s using `gregioninfoall()`.  More details below.

## 2. Getting Started

To see a list of predefined `GeoRegion`s, as well as their properties, you can use `gregioninfoall()`, which will return all available `GeoRegions` in tabular format.  This list is also found [here].

```
julia> gregioninfoall()
[ Info: 2020-05-27T21:54:48.08 - The following GeoRegions and their properties are offered in the GeoRegions.jl
 -------- ----- ----- ----- ----- ----- ------------------------------ -----------------------------------------
    ID     pID    N     W     S     E    Full Name                      Notes                                    
 -------- ----- ----- ----- ----- ----- ------------------------------ -----------------------------------------
   GLB     GLB   90     0    -90   360   Global                         Default                                  
  GF_AUS   GLB   -10   110   -45   155   Australia                      Adapated from Giorgi & Francisco [2000]  
  GF_AMZ   GLB   15    275   -20   330   Amazon Basin                   Adapated from Giorgi & Francisco [2000]  
  GF_SSA   GLB   -20   280   -60   320   Southern South America         Adapated from Giorgi & Francisco [2000]  
  GF_CAM   GLB   30    240   10    280   Central America                Adapated from Giorgi & Francisco [2000]  
...
 -------- ----- ----- ----- ----- ----- ------------------------------ -----------------------------------------
```

To see if a particular `GeoRegion` exists, use `isgeoregion(ID)`.  For example:

```
julia> isgeoregion.(["GLB","TRP","GF_AUS","AUS","SGP"],throw=false)
┌ Warning: 2020-05-27T22:46:34.448 - The GeoRegion ID AUS has not been added to gregions.txt.
└ @ GeoRegions ~/.julia/dev/GeoRegions/src/query.jl:67
┌ Warning: 2020-05-27T22:46:34.469 - The GeoRegion ID SGP has not been added to gregions.txt.
└ @ GeoRegions ~/.julia/dev/GeoRegions/src/query.jl:67
5-element BitArray{1}:
 1
 1
 1
 0
 0
```

## 3. Finding the Properties of a `GeoRegion`

The following properties of a `GeoRegion` can be queried by using its `ID`:
* The bounds of the `GeoRegion` in `[N,S,E,W]` `Vector` format
* The **name** of the `GeoRegion` in `String` format
* The `ID` of the parent `GeoRegion` (called `pID` for clarity)
* A list of child `GeoRegion`s of the current `GeoRegion`

#### Querying the bounds of a `GeoRegion`

We query the `[N,S,E,W]` bounds of a `GeoRegion` using the function `gregionbounds(ID)`

```
julia> gregionbounds.(["SEA","TRP","GF_MED"])
3-element Array{Array{Int64,1},1}:
 [20, -15, 165, 90]
 [30, -30, 360, 0]
 [50, 30, 40, 350]
```

#### Querying the name of a `GeoRegion`

We query the name that describes a `GeoRegion` using the function `gregionfullname(ID)`

```
julia> gregionfullname.(["ISM","GF_EAF","GF_TIB"])
3-element Array{SubString{String},1}:
 "Indian Summer Monsoon Region"
 "Eastern Africa"
 "Tibet"
```

#### Querying the Parent ID (`pID`) of a `GeoRegion`

We query the `ID` of the Parent of a `GeoRegion` using the function `gregionparent(ID)`

```
julia> gregionparent.(["GLB","GF_EAF","SEA"])
3-element Array{SubString{String},1}:
 "GLB"
 "GLB"
 "TRP"
```

We can query the next-level Parent using the keyword `levels`

```
julia> gregionparent.(["GLB","GF_EAF","SEA"],levels=2)
3-element Array{SubString{String},1}:
 "GLB"
 "GLB"
 "GLB"
```

!!! note "Parent of the Global GeoRegions"
    The parent `GeoRegion` of the Global GeoRegion `GLB` is itself.
    ```
    julia> gregionparent("SEA",levels=1000000)
     "GLB"
    ```

#### Querying the Children of a `GeoRegion`

We can query the direct children `GeoRegion`s of a given `GeoRegion` via:

```
julia> gregionchild("GLB",throw=false)
 -------- ----- ----- ----- ----- ----- ------------------------------ -----------------------------------------
    ID     pID    N     W     S     E    Full Name                      Notes                                    
 -------- ----- ----- ----- ----- ----- ------------------------------ -----------------------------------------
   GLB     GLB   90     0    -90   360   Global                         Default                                  
  GF_AUS   GLB   -10   110   -45   155   Australia                      Adapated from Giorgi & Francisco [2000]  
   ...
   EAM     GLB   50    90     0    150   East Asian Monsoon Region      Predefined in GeoRegions v1.0            
 -------- ----- ----- ----- ----- ----- ------------------------------ -----------------------------------------
25-element Array{Any,1}:
 "GLB"
 "GF_AUS"
 ...
 "EAM"
```

## 4. Adding Custom `GeoRegion`s

When you use any function that deals with `GeoRegion`s, `GeoRegion.jl` will retrieve the list of predefined `GeoRegion`s from the textfile in the path (See the tip above on predefined `GeoRegion`s):
```
$JULIA_DEPOT_PATH/files/GeoRegions/gregions.txt
```

If this file does not exist, then `GeoRegions.jl` will make a file in this location using `gregioncopy()`.  If you want to overwrite the old file in this location and replace it with a fresh file, then use the keyword `overwrite = true`
```
julia> gregioncopy(overwrite=true)
┌ Warning: 2020-05-28T02:22:00.977 - Overwriting gregions.txt in /Users/natgeo-wong/.julia/files/GeoRegions/ ...
└ @ GeoRegions ~/.julia/dev/GeoRegions/src/query.jl:26
"/Users/natgeo-wong/.julia/files/GeoRegions/gregions.txt"
```

!!! note "Just a note:"
    `gregioncopy()` will also return the path of the file `gregions.txt`.
