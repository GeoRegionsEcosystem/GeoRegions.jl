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
        "GeoRegion Basics" => [
            "What is a GeoRegion?"  => "georegions/intro.md",
            "Creating GeoRegions"   => "georegions/create.md",
            "Predefined GeoRegions" => "georegions/predefined.md",
            "Retrieving GeoRegions" => "georegions/read.md",
        ],
        "Using GeoRegions" => [
            "Is it in a GeoRegion?" => "using/isin.md",
            "RegionInfo Basics"     => "using/regiongrid.md",
            "Custom GeoRegions"     => "using/custom.md",
        ],
        "An Example with ERA5" => "example/era5.md"
    ]
)

deploydocs(
    repo = "github.com/JuliaClimate/GeoRegions.jl.git",
    devbranch = "main"
)
