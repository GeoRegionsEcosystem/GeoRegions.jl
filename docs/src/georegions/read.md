# Reading in Defined GeoRegion Information

In this section, we go through process of extracting information regarding a GeoRegion.

## Extracting GeoRegion Information

We use the function `GeoRegion(ID)`, where `ID` is the ID of the GeoRegion, in order to extract the information for the GeoRegion.

```@repl
using GeoRegions
PolyRegion("TPL","GLB","Test Polygonal Region",[30,40,50,40,30],[20,30,20,10,20])
GeoRegion("TPL")
```

## The Difference between Bounds and Shape in a `PolyRegion`

What is the difference between the fields `bound` and `shape` in a `PolyRegion`?  The answer is simple: a `bound` is a rectilinear-region in the lon-lat coordinate system, while the `shape` denotes the actual `PolyRegion`

```@repl
using GeoRegions
blon,blat,slon,slat = coordGeoRegion(GeoRegion("TPL"))
```

This is illustrated by plotting the bounds (blon,blat) and the shape(slon,slat), we see that the bound is the region defined by the westernmost, easternmost, northernmost and southernmost coordinates of the shape.

![boundvshape](boundvshape.png)

## Reading in GeoRegions from a custom file

We can read in GeoRegions from a custom file using the function `addGeoRegions()`, which will then read all the GeoRegion information in the file and add it to the list of GeoRegions.

```@repl
using GeoRegions
addGeoRegions("recttest.txt")
GeoRegion("TRP")

```

## APIs

```@docs
GeoRegion(::AbstractString)
coordGeoRegion(::RectRegion)
coordGeoRegion(::PolyRegion)
addGeoRegions(::AbstractString)
```

```@repl
using GeoRegions
resetGeoRegions()
```
