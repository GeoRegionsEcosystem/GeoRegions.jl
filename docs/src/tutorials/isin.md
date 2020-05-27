# Is Point/Grid in Region?

When dealing with geographic data, we often wish to check if a point or the bounds of a grid is within a given `region`.  `GeoRegions.jl` allows you to perform this check easily with `ispointinregion` and `isgridinregion`.

This page goes through the following:
1. Ways to express a `Region`
2. How to use `ispointinregion()`
3. How to use `ispointinregion()`

## Expressing a `Region`

In both `ispointinregion()` and `ispointinregion()`, the `region` can be expressed in the form of the following:
* Grid Boundaries `regionbounds` which is a vector taking the form of `[N,S,E,W]` coordinates
* A pair of longitude and latitude vectors, `rlon` and `rlat`
* A `GeoRegion` `ID`

The first two methods are provided in order for the functions to be generally applicable when a `GeoRegion` has not been explicitly created for this particular `region`.

An example of each of the three different methods is as follows:

### Using the `regionbounds` method:

```
julia> plon = 79.5; plat = 1.76; regionbounds = [3,0,80,79];
julia> ispointinregion(plon,plat,regionbounds)
true
```

### Using `rlon` and `rlat`:

```
julia> plon = 79.5; rlon = collect(70:95);
julia> plat = 1.76; rlat = collect(0:5);
julia> ispointinregion(plon,plat,rlon,rlat)
true
```

### Using `GeoRegion` `ID`

```
julia> ID = "GF_WAF"; #regionbounds =  [20,-15,25,340]
julia> plon = 100; plat = 1.76; ispointinregion(plon,plat,ID)
ERROR: Requested coordinates [100,1.76] are not within the specified region boundaries.

julia> plon = 0;   plat = 1.76; ispointinregion(plon,plat,ID)
true
```

## Is Point in Region?

Text

More Text and examples

The following are the possible methods for `ispointinregion`:

```@docs
ispointinregion
```

## Is Grid in Regions?

Text

```@docs
isgridinregion
```
