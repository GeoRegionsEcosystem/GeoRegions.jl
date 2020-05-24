using Documenter
using GeoRegions

makedocs(
    modules  = [GeoRegions],
    doctest  = false,
    format   = Documenter.HTML(
        collapselevel = 1,
        prettyurls    = false
    ),
    authors  = "Nathanael Wong",
    sitename = "GeoRegions.jl",
    pages    = [
        "Home"      => "index.md",
        "Tutorials" => [
            "GeoRegions List"   => "tutorials/list.md",
            "IsIn Region?"      => "tutorials/isin.md",
            # "GeoRegion Query"   => "tutorials/query.md",
            # "GeoRegion Extract" => "tutorials/extract.md"
        ]
    ]
)

deploydocs(
    repo = "github.com/JuliaClimate/GeoRegions.jl.git",
)
