using Documenter
using DocumenterVitepress
using GeoRegions
# using CairoMakie
# using Literate

# CairoMakie.activate!(type = "svg")

DocMeta.setdocmeta!(GeoRegions, :DocTestSetup, :(using GeoRegions); recursive=true)

makedocs(;
    modules  = [GeoRegions],
    authors  = "Nathanael Wong <natgeo.wong@outlook.com>",
    sitename = "GeoRegions.jl",
    doctest  = false,
    warnonly = true,
    format   = DocumenterVitepress.MarkdownVitepress(
        repo = "https://github.com/GeoRegionsEcosystem/GeoRegions.jl",
    ),
    pages=[
        "Home" => "index.md",
        "What is a GeoRegion?"  => "georegions.md",
        "Basic Functionality" => [
            "Retrieving GeoRegions"  => [
                "Overview (START HERE)"  => "basics/read/overview.md",
                "Predefined GeoRegions"  => "basics/read/predefined.md",
                "Tabulating GeoRegions"  => "basics/read/tables.md",
                "Listing All GeoRegions" => "basics/read/listall.md",
            ]
            "GeoRegion Properties"   => [
                "Shape of a GeoRegion"  => "basics/properties/shape.md",
                "Is it in a GeoRegion?" => "basics/properties/isin.md",
            ]
        ],
        "GeoRegions.jl Tutorials" => [
            "Setup (START HERE)"     => "tutorials/setup.md",
            "Create, Save, Retrieve" => "tutorials/overview.md",
            "More on Creation" => [
                "Creating RectRegions"   => "tutorials/create/rectregion.md",
                "Creating PolyRegions"   => "tutorials/create/polyregion.md",
                "Creating TiltRegions"   => "tutorials/create/tiltregion.md",
            ],
            "Custom GeoRegion Files" => "tutorials/files.md",
        ],
        "Ecosystem"  => "ecosystem.md",
    ],
)

recursive_find(directory, pattern) =
    mapreduce(vcat, walkdir(directory)) do (root, dirs, files)
        joinpath.(root, filter(contains(pattern), files))
    end

files = []
for pattern in [r"\.cst", r"\.nc"]
    global files = vcat(files, recursive_find(@__DIR__, pattern))
end

for file in files
    rm(file)
end

deploydocs(;
    repo      = "github.com/GeoRegionsEcosystem/GeoRegions.jl.git",
    target    = "build", # this is where Vitepress stores its output
    devbranch = "main",
    branch    = "gh-pages",
)
