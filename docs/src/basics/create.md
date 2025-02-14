# Creating Custom GeoRegions

We use the function `GeoRFegion()` to create new `GeoRegion`s.

```@example createbasics
using GeoRegions
lon = collect(10cos.((0:0.01:1).*2pi))
lat = collect(10sin.((0:0.01:1).*2pi))
GeoRegion(lon,lat)
```

See the API [here](/api/createaddreadrm#Creating-GeoRegions)