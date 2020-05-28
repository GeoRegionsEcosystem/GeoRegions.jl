# Is Point/Grid in Region?

When dealing with geographic data, we often wish to check if a point or the bounds of a grid is within a given `region`.  `GeoRegions.jl` allows you to perform this check easily with `ispointinregion` and `isgridinregion`.

This page goes through the following:
1. Ways to express a `Region`
2. How to use `ispointinregion()`
3. How to use `ispointinregion()`

## Expressing a `Region`

In both `ispointinregion()` and `ispointinregion()`, the `region` can be expressed in the form of the following:
1. Grid Boundaries `regionbounds` which is a vector taking the form of `[N,S,E,W]` coordinates
2. A pair of longitude and latitude vectors, `rlon` and `rlat`
3.  A `GeoRegion` `ID`

!!! warning "Thresholds"
    You might have noticed that for methods (1) and (3), there are variables defining the threshold of error `tlon` and `tlat`.  For method (2), these variables are defined to be half the steps in `rlon` and rlat respectively.  For example, if `rlon = collect(18:25)` and `rlat = collect(0.1:0.1:10)`, then `tlon` and `tlat` are given by:
    ```
    tlon = (rlon[2]-rlon[1])/2 = 0.5;
    tlat = (rlat[2]-rlat[1])/2 = 0.05;
    ```

    Note that for method 2, it is assumed that the points in `rlon` and `rlat` are evenly spaced.


The first two methods are provided in order for the functions to be generally applicable when a `GeoRegion` has not been explicitly created for this particular `region`.

An example of each of the three different methods is as follows:

#### Using the `regionbounds` method:

```
julia> plon = 79.5; plat = 1.76; regionbounds = [3,0,80,79];
julia> ispointinregion(plon,plat,regionbounds)
true
```

#### Using `rlon` and `rlat`:

```
julia> plon = 79.5; rlon = collect(70:95);
julia> plat = 1.76; rlat = collect(0:5);
julia> ispointinregion(plon,plat,rlon,rlat)
true
```

#### Using `GeoRegion` `ID`

```
julia> ID = "GF_WAF"; #regionbounds =  [20,-15,25,340]
julia> plon = 100; plat = 1.76; ispointinregion(plon,plat,ID)
ERROR: Requested coordinates [100,1.76] are not within the specified region boundaries.

julia> plon = 0;   plat = 1.76; ispointinregion(plon,plat,ID)
true
```

## Is Point in Region?

There are six different methods of querying if a point is in a given region using `ispointinregion`.  This is a combination of having **three** different methods to express the `region` (as mentioned above), and **two** different methods of expressing a `point`.

The two different methods of expression a `point` are:
* a pair of longitude and latitude points `plon` and `plat`
* a coordinate vector `pcoord = (plon,plat)`

#### Examples

Text

#### Methods

```@docs
ispointinregion
```

## Is Grid in Regions?

There are three different methods of querying if a point is in a given region using `isgridinregion`, because of the **three** different methods to express the `region` (as mentioned above).

#### Examples

Text

#### Methods

```@docs
isgridinregion
```
