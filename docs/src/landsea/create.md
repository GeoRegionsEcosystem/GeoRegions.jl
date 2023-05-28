# Loading and Saving Land-Sea Mask Datasets

The Land-Sea Dataset can be obtained using the function `getLandSea()`.  There are two options:
1. Saving the `LandSea` dataset as a local NetCDF file
2. Extract the `LandSea` dataset directly from the OPeNDAP servers

Option (1) has a longer initial cost, because you have to download the global file, and then use the data from the global file to extract out the information for the GeoRegion of interest.  However, once the data has been downloaded once, you don't need to download the data again and this greatly speeds up latency time.

Option (2) however, is much faster for smaller GeoRegions when loading the data directly from OPeNDAP is much easier than downloading the entire dataset.  However, loading data directly from OPeNDAP comes with its own noticeable latency, which can add up if done iteratively.

You can toggle between the two options using the keyword argument `savelsd` - `true` sets the function to option 1, and `false` is option 2.

See end of the page for the API

### Setup

````@example regiongrid
using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing
````

## Retrieving LandSea Example over Aceh

````@example regiongrid
geo  = RectRegion("ACH","GLB","Aceh",[6,3,98,95],savegeo=false)
slon,slat = coordGeoRegion(geo)
lsd = getLandSea(geo,savelsd=false)
````

And we plot it here, with coarser-resolution coastlines for comparison:

````@example regiongrid
fig = Figure()
aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))

ax1 = Axis(
    fig[1,1],width=350,height=350/aspect,
    title="Orographic Height",xlabel="Longitude / º",ylabel="Latitude / º",
    limits=(minimum(slon)-0.1,maximum(slon)+0.1,minimum(slat)-0.1,maximum(slat)+0.1)
)
contourf!(
    ax1,lsd.lon,lsd.lat,lsd.z,
    levels=range(0,1500,length=16),extendlow=:auto,extendhigh=:auto
)
lines!(ax1,clon,clat,color=:black,linewidth=2)
lines!(ax1,slon,slat,linewidth=5)

ax2 = Axis(
    fig[1,2],width=350,height=350/aspect,
    title="Land-Sea Mask",xlabel="Longitude / º",
    limits=(minimum(slon)-0.1,maximum(slon)+0.1,minimum(slat)-0.1,maximum(slat)+0.1)
)
contourf!(
    ax2,lsd.lon,lsd.lat,lsd.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax2,slon,slat,linewidth=5)

resize_to_layout!(fig)
fig
````

## API

```@docs
getLandSea
```