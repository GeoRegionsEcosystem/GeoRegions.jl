# Is it on a GeoRegion Boundary?

Sometimes, we don't just want information on whether a point is _inside_ a `GeoRegion`. Sometimes, it is important to know if something is _on_ the boundary of a `GeoRegion`. This would prove useful in determining if the shapes of two different `GeoRegion`s are equivalent to each other.

!!! note "Point2 Type"
    We use the `Point2` Type from the package [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl), which is reexported by GeoRegions.jl, as an easy way to denote points.  This also allows us to use the package [GeometryOps.jl](https://github.com/JuliaGeo/GeometryOps.jl) to determine if a point is on a GeoRegion boundary.

```@example ison
using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing
```

## Is a Point on a GeoRegion Boundary?

As an example, let us test if a point is on the perimeter of the GeoRegion `AR6_EAO`, defined in the blue bounding box below.

```@example ison
geo = GeoRegion("AR6_EAO")
```

Next, we select a point along the border
```@example ison
A = Point(-25,7.6)
B = Point(335,7.6)
C = Point(-20,5)
D = Point(-45,-7.5)
```

Here, we note that A and B 

```@example ison
slon,slat = coordinates(geo)
aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))
fig = Figure()
ax = Axis(
    fig[1,1],width=750,height=750/aspect,
    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)
)
lines!(ax,clon,clat,color=:black,linewidth=3)
lines!(ax,slon,slat,linewidth=5)
scatter!(ax,A,markersize=20)
scatter!(ax,C,markersize=20)
scatter!(ax,D,markersize=20)
resize_to_layout!(fig)
fig
```

By eye it is easy to see that Point A is on the GeoRegion perimeter.  However, C and D are not.  Let us now see if we are able to corroborate this with GeoRegions.jl using the function `on()`

```@example ison
on(A,geo), # Point A
on(C,geo), # Point C
on(D,geo)  # Point D
```

But what about Point B?  Point B is also very obviously on the bounds of the GeoRegion, it is simply that the longitude of Point B is shifted by 360º from A such that it is now in the (0,360) coordinates frame.  We see that this is of no concern to GeoRegions.jl, which can detect that it is within the bounds of the GeoRegion anyway.

```@example ison
on(B,geo)
```

See the API [here](/api/isinon#GeoRegions.on-Tuple{Point2{%3C:Real},%20GeoRegion})

## Is a GeoRegion on a GeoRegion? (i.e., Are their Shapes the Same?)

We can also use the `on()` function to determine if the perimeter of a `GeoRegion` is on the perimeter of another. Or, in simpler terms, **_if two `GeoRegion`s define the same shape_**. For example:

```@example ison
on(geo,geo)
```

See the API [here](/api/isinon#GeoRegions.on-Tuple{GeoRegion,%20GeoRegion})

Which is obvious because we are comparing a `GeoRegion` against itself. However, let us try something a bit more complicated.

### 1. `circshift()` the points defining the `GeoRegion`

In this test case, we use `circshift()` to change the starting and ending coordinates of the `shape`. Therefore, we are defining the same region, just with different start and ending points.

```@example ison
lon,lat = coordinates(geo)
pop!(lon); lon = circshift(lon,2); lon = vcat(lon,lon[1])
pop!(lat); lat = circshift(lat,2); lat = vcat(lat,lat[1])
geo2 = PolyRegion("","","",lon,lat)
```

So here, we have circshifted the `lon` and `lat` values used to define the GeoRegion such that instead of the start/end points being at (-34,-10), now the start/end points are at (-50,0).

We compare the shapes of the two GeoRegions:
```@example ison
on(geo,geo2),
on(geo2,geo)
```

And see that the GeoRegions define the same area.

!!! tip "Order of GeoRegions does not matter in `on()`"
    The order should not matter, because in the `on()` function, the GeoRegions are both compared against each other. So `on(geo,geo2) = on(geo2,geo)`. If you find any edge cases where this is not the case, please let me know and I will look into it.

### 2. Shifting the `GeoRegion` by 360º

In this test case, we shift the `lon` of `geo` by 360º, so that it is on a (0,360) grid instead of a (-180,180) grid.

```@example ison
lon,lat = coordinates(geo); lon = lon .+ 360
geo3 = PolyRegion("","","",lon,lat)
```

We compare the shapes of the two GeoRegions:
```@example ison
on(geo,geo3)
```

And we see that the GeoRegions define the same area.