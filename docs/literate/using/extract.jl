#=
# Extracting Gridded Data using RegionGrid

Suppose we have Global Data.  However, we are only interested in a specific region (say, the North Central American region as defined in AR6), how do we extract data for this region?

The simple answer is, we use the `extractGrid()` function, which takes in a `RegionGrid` and a data array, and returns a new data array for the GeoRegion.

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

# ## Let us define the GeoRegion of interest

geo  = GeoRegion("AR6_NCA")

# We also define some sample test data in the global domain

lon = collect(0:360); pop!(lon); nlon = length(lon)
lat = collect(-90:90);           nlat = length(lat)
odata = randn((nlon,nlat))

#=
Our next step is to define the RegionGrid based on the longitude and latitude vectors and their intersection with the GeoRegion
=#

ggrd = RegionGrid(geo,lon,lat)

# Then we extract the data

ndata = extractGrid(odata,ggrd)

# Let us plot the old and new data

fig = Figure()
_,_,slon,slat = coordGeoRegion(geo); slon = slon
aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))

ax = Axis(
    fig[1,1],width=350,height=350/aspect,
    limits=(minimum(slon)-2+360,maximum(slon)+2+360,minimum(slat)-2,maximum(slat)+2)
)
contourf!(
    ax,lon,lat,odata,
    levels=range(-1,1,length=11),extendlow=:auto,extendhigh=:auto
)
lines!(ax,clon,clat,color=:black)
lines!(ax,slon.+360,slat.+360,color=:red,linewidth=5)

ax = Axis(
    fig[1,2],width=350,height=350/aspect,
    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)
)
contourf!(
    ax,ggrd.lon,ggrd.lat,ndata,
    levels=range(-1,1,length=11),extendlow=:auto,extendhigh=:auto
)
lines!(ax,clon,clat,color=:black)
lines!(ax,slon,slat,color=:red,linewidth=5)

hideydecorations!(ax, ticks = false,grid=false)

resize_to_layout!(fig)
fig

#=
## API

```@docs
extractGrid
extractGrid!
```
=#