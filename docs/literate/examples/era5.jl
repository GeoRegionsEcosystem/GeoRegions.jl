#=
# An Example with ERA5 Precipitable Water Data

In this example, we use GeoRegions to define custom GeoRegions, and extract precpitable
water data from an example ERA5 dataset for this GeoRegion.  This example demonstrates:

* An example of an extension of the `GeoRegion` functionality, the `ERA5Region` Type
  exported by ERA5Reanalysis.jl
* Extracting data for an `ERA5Region` the same way we do this for a `GeoRegion`
=#

using ERA5Reanalysis # GeoRegions is automatically reexported by ERA5Reanalysis.jl

#=
We then proceed to define the dataset (monthly), variable (total column water vapour)
and the geographic region (global, resolution of 0.25).

!!! note
    The `ERA5Region` functionality is an ERA5Reanalysis.jl Type that is built as a
    container of the `GeoRegion` functionality of GeoRegions.jl, with the added detail
    of specifying the spatial resolution of the data.  All major functions of 
    GeoRegions.jl should work on an `ERA5Region` the same way that they work for a
    `GeoRegion`.
=#

e5ds = ERA5Monthly(start=Dates.now()-Year(1),stop=Dates.now()-Year(1))
evar = SingleVariable("tcwv")
ereg = ERA5Region("GLB",resolution=0.25)

# We proceed to download and retrieve the `LandSea` dataset for the stated region.
lsd  = getLandSea(e5ds,ereg)

# Then, we proceed to download the data. Shouldn't take too long since there are only 12 timesteps

download(e5ds,evar,ereg)

# Let us proceed to read the data. For simplicity, we 

ds = read(e5ds,evar,ego,Dates.now()-Year(1))
tcwv = dropdims(mean(nomissing(ds["tcwv"][:],NaN),dims=3),dims=3)
close(ds)