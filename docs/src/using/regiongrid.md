# From GeoRegions to RegionGrid

But how do we go from defining a GeoRegion, to **extracting data** for that GeoRegion?  The answer is with the information in the `RegionGrid` types, which maps gridded lon-lat data to a given GeoRegion
* Mapping gridded lon-lat data to a **`RectRegion`** gives a `RectGrid` structure
* Mapping gridded lon-lat data to a **`PolyRegion`** gives a `PolyGrid` structure

However, the basic uses of `RectGrid` and `PolyGrid` are the same, and as such their differences are largely transparent to the user, except for one field found in `PolyGrid`, the `mask`, which will be elaborated upon later.

```@repl
using GeoRegions
geo   = GeoRegion("AR6_SAS")
lon   = collect(-180:5:180)[1:(end-1)];
lat   = collect(-90:2:90);
ginfo = RegionGrid(geo,lon,lat)
```

And using the field mask, we plot the points that are in the region (blue), and out of the region (red).

```julia
inlon = mask .* ginfo.glon;              inlon = inlon[.!iszero.(mask)]
inlat = mask .* reshape(ginfo.glat,1,:); inlat = inlat[.!iszero.(mask)]
otlon = (1 .- mask) .* ginfo.glon;              otlon = otlon[iszero.(mask)]
otlat = (1 .- mask) .* reshape(ginfo.glat,1,:); otlat = otlat[iszero.(mask)]
blon,blat,slon,slat = coordGeoRegion(geo)
```

![regiongrid](regiongrid.png)
