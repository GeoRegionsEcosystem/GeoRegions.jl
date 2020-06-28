module GeoRegions

## Modules Used
using Logging, Dates
using DelimitedFiles
using PrettyTables

## Exporting the following functions:
export
       ispointinregion, isgridinregion, isgeoregion, from0360to180, from180to0360,
       regionpoint, regiongrid, regiongridvec,
       regionextract, regionextractpoint, regionextractgrid, regionextractgrid!,
       gregioncopy, gregiontemplate,
       gregioninfoload, gregioninfodisplay, gregioninfoall,
       gregioninfoadd, gregioninform,
       gregionbounds, gregionfullname, gregionparent, gregionchild, gregiongridvec

## Including other files in the module
include("isin.jl")
include("query.jl")
include("extract.jl")

end # module
