# What is a RegionGrid?

But how do we go from defining a GeoRegion, to **extracting data** for that GeoRegion?  The answer is with the information in the `RegionGrid` types, which maps gridded lon-lat data to a given GeoRegion as follows:
* Mapping gridded lon-lat data to a **`RectRegion`** gives a `RectGrid` structure
* Mapping gridded lon-lat data to a **`PolyRegion`** gives a `PolyGrid` structure
* Mapping non-rectilinear gridded lon-lat data to a **`RegionMask`** gives a `RegionMask` structure

However, the basic uses of `RectGrid` and `PolyGrid` are the same, and as such their differences are largely transparent to the user, except for one field found in `PolyGrid`, the `mask`, which will be elaborated upon later.

```@docs
RegionGrid
```

So basically a `RegionGrid` contains information on the indices of the gridded data that are part of the `GeoRegion`, thus helping us extract the relevant data for a given `GeoRegion`.