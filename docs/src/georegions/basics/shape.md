# The Shape of a GeoRegion

In this section, we go through process of extracting information on the shape of the `GeoRegion`.

Let us now setup the example

```@example properties
using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing
```

We load a predefined AR6 GeoRegion for Northwest North America:

```@example properties
geo = GeoRegion("AR6_NWN")
```

## Retrieving the coordinates of a GeoRegion

Using the function `coordinates()`, we are able to retrieve the coordinates of the vertices that define the shape of the `GeoRegion`. In the below example, we plot the longitude and latitude points.

```@example properties
lon,lat = coordGeoRegion(geo)

aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))
fig = Figure()
ax = Axis(
    fig[1,1],width=750,height=750/aspect,
    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)
)
lines!(ax,clon,clat,color=:black,linewidth=3)
lines!(ax,lon,lat,linewidth=5)
resize_to_layout!(fig)
fig
```

This plotting works on maps where the projection is equirectangular. However, there are many different map projections, and so we can specify the number of points on each side of the shape using the keyword argument `n` in order to ensure during plotting that is plotted correctly on the projection.

```@example properties
nlon,nlat = coordGeoRegion(geo,n=50)
length(lon), length(nlon)
```

## API

```@docs
coordinates
```
