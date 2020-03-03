module GeoRegions

## Modules Used
using Logging, Dates
using DelimitedFiles

## Exporting the following functions:
export
       ispointinregion, isgridinregion, from0360to180, from180to0360,
       regionpoint, regiongrid, regiongridvec,
       regionextract, regionextractpoint, regionextractgrid, regionextractgrid!,
       gregioncopy, gregioninfoload, gregioninfodisplay, gregioninfoall, gregioninfoadd,
       gregionbounds, gregionfullname, gregionparent, gregionchild, gregiongridvec


## Including other files in the module
include("isin.jl")
include("query.jl")
include("extract.jl")

end # module
