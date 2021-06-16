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
            "Retrieving GeoRegions" => "georegions/read.md",
            "Predefined GeoRegions" => "georegions/predefined.md",
        ],
        "Using GeoRegions" => [
            "Is it in a GeoRegion?" => "using/isin.md",
            # "RegionInfo Basics"     => "using/regioninfo.md",
            # "Extract Gridded Data"  => "using/extract.md"
        ],
        # "An Example Application" => "example.md",
        "APIs" => "api.md",
    ]
)

deploydocs(
    repo = "github.com/JuliaClimate/GeoRegions.jl.git",
    devbranch = "main"
)
