# Reading in Defined GeoRegion Information

In this section, we go through process of extracting information regarding a GeoRegion.

### Setup

```@example read
using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing
```

## Retrieving Information about a Previously Defined GeoRegion

We use the function `GeoRegion(ID)`, where `ID` is the ID of the GeoRegion, in order to extract the information for the GeoRegion.

```@example read
GeoRegion("AR6_NWN")
```

```@docs
GeoRegion(::AbstractString)
```

## The Difference between Bounds and Shape in a `PolyRegion`

What is the difference between the fields `bound` and `shape` in a `PolyRegion`?  The answer is simple: a `bound` is a rectilinear-region in the lon-lat coordinate system, while the `shape` denotes the actual `PolyRegion`.  We retrieve the longitude and latitude coordinates for the `bound` and `shape` fields using the function `coordGeoRegion()`.

!!! note "Bound and Shape in `RectRegion`"
    There is no field `shape` in a `RectRegion` because the `shape` of a `RectRegion` is defined by its rectilinear bound.

```@example read
blon,blat,slon,slat = coordGeoRegion(GeoRegion("AR6_NWN"))
```

From plotting the bounds (blon,blat) and the shape(slon,slat), we see that the bound is the region defined by the westernmost, easternmost, northernmost and southernmost coordinates of the shape.

```@example read
aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))
fig = Figure()
ax = Axis(
    fig[1,1],width=750,height=750/aspect,
    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)
)
lines!(ax,clon,clat,color=:black,linewidth=3)
lines!(ax,slon,slat,linewidth=5)
lines!(ax,blon,blat,linewidth=5)
resize_to_layout!(fig)
fig
```

```@docs
coordGeoRegion(::RectRegion)
coordGeoRegion(::PolyRegion)
```
