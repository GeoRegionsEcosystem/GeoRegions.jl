#=
# From GeoRegions to RegionGrid

But how do we go from defining a GeoRegion, to **extracting data** for that GeoRegion?  The answer is with the information in the `RegionGrid` types, which maps gridded lon-lat data to a given GeoRegion
* Mapping gridded lon-lat data to a **`RectRegion`** gives a `RectGrid` structure
* Mapping gridded lon-lat data to a **`PolyRegion`** gives a `PolyGrid` structure
* Mapping non-rectilinear gridded lon-lat data to a **`RegionMask`** gives a `RegionMask` structure
```@docs
RegionGrid
```

However, the basic uses of `RectGrid` and `PolyGrid` are the same, and as such their differences are largely transparent to the user, except for one field found in `PolyGrid`, the `mask`, which will be elaborated upon later.

### Setup
=#

using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing

# ## `RectGrid` Example

geo  = GeoRegion("GF_SSA")
lon  = -180:5:180
lat  = -90:5:90
ggrd = RegionGrid(geo,lon[1:(end-1)],lat)

# ## `PolyGrid` Example

geo  = GeoRegion("AR6_NWS")
lon  = -180:5:180;
lat  = -90:5:90;
ggrd = RegionGrid(geo,lon[1:(end-1)],lat)

#=
## The Mask of a `PolyGrid`

The `PolyGrid` type derived from a `PolyRegion` allows us to apply a mask to filter out data that is within the `shape` of a `PolyRegion` on a rectilinear lon-lat grid defined by the `bound` of a PolyRegion.  We consider the following example of an AR6 region over South Asia:
=#

geo  = GeoRegion("AR6_SAS")
lon  = -180:5:180;
lat  = -90:2:90;
ggrd = RegionGrid(geo,lon[1:(end-1)],lat)

# And using the field mask, we plot the points that are in the region (blue), and out of the region (red).

mask = ggrd.mask
grid = ones(size(mask))
inlon = grid .* ggrd.lon;  inlon = inlon[.!isnan.(mask)]
inlat = grid .* ggrd.lat'; inlat = inlat[.!isnan.(mask)]
otlon = grid .* ggrd.lon;  otlon = otlon[isnan.(mask)]
otlat = grid .* ggrd.lat'; otlat = otlat[isnan.(mask)]
blon,blat,slon,slat = coordGeoRegion(geo)

fig = Figure()
aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))
ax = Axis(
    fig[1,1],width=750,height=750/aspect,
    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)
)

lines!(ax,clon,clat,color=:black)
lines!(ax,blon,blat)
lines!(ax,slon,slat)
scatter!(ax,otlon,otlat)
scatter!(ax,inlon,inlat)

resize_to_layout!(fig)
fig

#=
## API

```@docs
RegionGrid(::RectRegion,::Vector{<:Real},::Vector{<:Real})
RegionGrid(::GeoRegion,::Array{<:Real,2},::Array{<:Real,2})
```
=#