# Smoothing of the Land-Sea Mask Dataset

The land-sea mask created from the ETOPO dataset comprises of 1s and 0s, where 1 denotes land and 0 denotes the ocean.  However, it may often be useful to sort grid points not only by their land-surface type, but how distant they are from the coastline.  GeoRegions.jl uses Gaussian Filtering from [ImageFiltering.jl](https://github.com/JuliaImages/ImageFiltering.jl) to perform a smoothing of the land-sea mask.

The degree of smoothing is expressed by the arguments `σlon` and `σlat`, which are integer inputs respectively.

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

## Example

````@example smooth
geo = RectRegion("ACH","GLB","Aceh",[7,2,99,94],savegeo=false)
lsd_raw = getLandSea(geo,savelsd=false)
lsd_σ1d = getLandSea(geo,savelsd=false,smooth=true,σlon=1,σlat=1)
lsd_σ2d = getLandSea(geo,savelsd=false,smooth=true,σlon=2,σlat=2)
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
    title="Smoothed Land-Sea Mask (σ=1)",xlabel="Longitude / º",
    limits=(93.9,99.1,1.9,7.1)
)
contourf!(
    ax2,lsd_σ1d.lon,lsd_σ1d.lat,lsd_σ1d.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax2,clon,clat,color=:black,linewidth=2)

ax3 = Axis(
    fig[1,3],width=225,height=225,
    title="Smoothed Land-Sea Mask (σ=2)",xlabel="Longitude / º",
    limits=(93.9,99.1,1.9,7.1)
)
contourf!(
    ax3,lsd_σ2d.lon,lsd_σ2d.lat,lsd_σ2d.lsm,
    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto
)
lines!(ax3,clon,clat,color=:black,linewidth=2)

resize_to_layout!(fig)
fig
````