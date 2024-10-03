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

## Retrieving the Bounds of the GeoRegion

We can use the functions `GeoRegions.N()`, `GeoRegions.S()`, `GeoRegions.E()` and `GeoRegions.W()` to retrieve the north and south latitude bounds, and the east and west longitude bounds, of a `GeoRegion`.

!!! warning "`N()`, `S()`, `E()`, `W()` not exported"
    In order to prevent clashes with variable names, `N()`, `S()`, `E()`, `W()` are not exported, and thus must be prefixed with `GeoRegions.` (e.g., `GeoRegions.N()`).

```@example properties
GeoRegions.N(geo),
GeoRegions.S(geo),
GeoRegions.E(geo),
GeoRegions.W(geo)
```

Or you can also extract them all at the same time as follows:

```@example properties
N,S,E,W = geo.bound
```

See the API [here](/api/shape#GeoRegions.N)

## Retrieving the Tilt-Properties of a TiltRegion

Similar to above can use the functions `GeoRegions.X()`, `GeoRegions.Y()`, `GeoRegions.ΔX()`, `GeoRegions.ΔY()` and `GeoRegions.θ()` to respective tilt-properties, of a `TiltRegion`.

!!! warning "`X()`, `Y()`, `ΔX()`, `ΔY()`, `θ()` not exported"
    In order to prevent clashes with variable names, `X()`, `Y()`, `ΔX()`, `ΔY()`, `θ()` are not exported, and thus must be prefixed with `GeoRegions.` (e.g., `GeoRegions.X()`).

```@example properties
tlt = TiltRegion("TST_TILT","GLB","Test Tilt",20,0,50,10,13)
# [X,Y,ΔX,ΔY,θ] = [20,0,50,10,13]
```

```@example properties
GeoRegions.X(tlt),
GeoRegions.Y(tlt),
GeoRegions.ΔX(tlt),
GeoRegions.ΔY(tlt),
GeoRegions.θ(tlt)
```

See the API [here](/api/shape#GeoRegions.N)

Or you can also extract them all at the same time as follows:

```@example properties
X,Y,ΔX,ΔY,θ = geo.tilt
```

## Retrieving the coordinates of a GeoRegion

Using the function `coordinates()`, we are able to retrieve the coordinates of the vertices that define the shape of the `GeoRegion`. In the below example, we plot the longitude and latitude points.

```@example properties
lon,lat = coordinates(geo)

aspect = (E-W+4)/(N-S+4)
fig = Figure()
ax = Axis(
    fig[1,1],width=750,height=750/aspect,
    limits=(W-2,E+2,S-2,N+2)
)
lines!(ax,clon,clat,color=:black,linewidth=3)
lines!(ax,lon,lat,linewidth=5)
resize_to_layout!(fig)
fig
```

This plotting works on maps where the projection is equirectangular. However, there are many different map projections, and so we can specify the number of segments `n` on each side of the shape using the keyword argument `n` in order to ensure during plotting that is plotted correctly on the projection.

```@example properties
nlon,nlat = coordinates(geo,n=50)
length(lon), length(nlon)
```

!!! info "Number of Points"
    The shape is defined by 8 sides. Therefore there are by default 8 + 1 = 9 coordinate points to close the polygon. If we specify 50 segments a side, we therefore have 400 + 1 = 401 coordinate points to close the polygon.

See the API [here](/api/shape#GeoRegions.coordinates)