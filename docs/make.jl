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
        "Home"       => "index.md",
        "GeoRegions" => [
            "What is a GeoRegion?"  => "georegions/intro.md",
            "Creating GeoRegions"   => "georegions/create.md",
            "Retrieving GeoRegions" => "georegions/read.md",
        ],
        "Tutorials"  => [
            "IsIn Region?"      => "tutorials/isin.md",
            "GeoRegions"        => "tutorials/georegions.md",
            # "GeoRegion Extract" => "tutorials/extract.md"
        ],
        "APIs" => "api.md",
    ]
)

deploydocs(
    repo = "github.com/JuliaClimate/GeoRegions.jl.git",
)
