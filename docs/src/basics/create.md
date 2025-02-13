# Creating Custom GeoRegions

We use the function `GeoRFegion()` to create new `GeoRegion`s.

```@example createbasics
using GeoRegions
lon = collect(10cos.((0:0.01:1).*2pi))
lat = collect(10sin.((0:0.01:1).*2pi))
GeoRegion(lon,lat)
```

See the API [here](/api/create#GeoRegions.TiltRegion-Tuple{AbstractString,%20AbstractString,%20AbstractString,%20Vararg{Real,%205}})