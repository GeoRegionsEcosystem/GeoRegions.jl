# Smoothing of the Land-Sea Mask Dataset

The land-sea mask created from the ETOPO dataset comprises of 1s and 0s, where 1 denotes land and 0 denotes the ocean.  However, it may often be useful to sort grid points not only by their land-surface type, but how distant they are from the coastline.  GeoRegions.jl uses Gaussian Filtering from [ImageFiltering.jl](https://github.com/JuliaImages/ImageFiltering.jl) to perform a smoothing of the land-sea mask.

The degree of smoothing is expressed by the arguments `σlon` and `σlat`, which are integer inputs respectively.

You can get a smoothed land-sea mask via two means:
1. Calling the smoothing directly when retrieving the Land-Sea Dataset (recommended)
2. Smoothing a preexisting Land-Sea Dataset that has been loaded (not recommended)

The API for smoothing is listed below.  However, it is worth nothing that when implementing the smoothing, you need to first call a larger GeoRegion around the GeoRegion of interest as a buffer.

### Setup

````@example smooth
using GeoRegions
using DelimitedFiles
using CairoMakie

download("https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resh.txt","coast.cst")
coast = readdlm("coast.cst",comments=true)
clon  = coast[:,1]
clat  = coast[:,2]
nothing
````

## Example comparison between Smooth and Unsmoothed Masks

````@example smooth
geo = RectRegion("ACH","GLB","Aceh",[7,2,99,94],savegeo=false)
lsd_raw = getLandSea(geo,savelsd=false)
lsd_σ05 = getLandSea(geo,savelsd=false,smooth=true,σlon=5,σlat=5)
lsd_σ10 = getLandSea(geo,savelsd=false,smooth=true,σlon=10,σlat=10)
````

````@example smooth
fig = Figure()

ax1 = Axis(
    fig[1,1],width=225,height=225,
    title="Raw Land-Sea Mask",xlabel="Longitude / º",ylabel="Latitude / º",
    limits=(93.9,99.1,1.9,7.1)
)
contourf!(
    ax1,lsd_raw.lon,lsd_raw.lat,lsd_raw.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax1,clon,clat,color=:black,linewidth=2)

ax2 = Axis(
    fig[1,2],width=225,height=225,
    title="Smoothed (σ=5)",xlabel="Longitude / º",
    limits=(93.9,99.1,1.9,7.1)
)
contourf!(
    ax2,lsd_σ05.lon,lsd_σ05.lat,lsd_σ05.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax2,clon,clat,color=:black,linewidth=2)

ax3 = Axis(
    fig[1,3],width=225,height=225,
    title="Smoothed (σ=10)",xlabel="Longitude / º",
    limits=(93.9,99.1,1.9,7.1)
)
contourf!(
    ax3,lsd_σ10.lon,lsd_σ10.lat,lsd_σ10.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax3,clon,clat,color=:black,linewidth=2)

resize_to_layout!(fig)
fig
````

## Smoothing Directly from a loaded Land-Sea Mask

````@example smooth
smooth!(lsd_raw,σlon=5,σlat=5)
````

````@example smooth
f2 = Figure()

ax1 = Axis(
    f2[1,1],width=350,height=350,
    title="Smoothed from Global",xlabel="Longitude / º",ylabel="Latitude / º",
    limits=(93.9,99.1,1.9,7.1)
)
contourf!(
    ax1,lsd_σ05.lon,lsd_σ05.lat,lsd_σ05.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax1,clon,clat,color=:black,linewidth=2)

ax2 = Axis(
    f2[1,2],width=350,height=350,
    title="Directly Smoothed",xlabel="Longitude / º",
    limits=(93.9,99.1,1.9,7.1)
)
contourf!(
    ax2,lsd_raw.lon,lsd_raw.lat,lsd_raw.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax2,clon,clat,color=:black,linewidth=2)

resize_to_layout!(f2)
f2
````

You see here that smoothing the land-sea mask directly upon itself causes errors at the edges of the grid.  This is because the smoothing applied is a circular smoothing, meaning that the boundaries are considered to be doubly-periodic, and thus bleed into each other.  Thus, it is always best practice to call the smoothing directly when retrieving the Land-Sea dataset.

## API

```@docs
smooth!
smoothlsm
```