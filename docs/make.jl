using Documenter
using GeoRegions
using Literate

using CairoMakie # to avoid capturing precompilation output by Literate
CairoMakie.activate!(type = "svg")

pages_using = [
    "Is it in a GeoRegion?"           => "isin",
    "Custom GeoRegions"               => "custom",
    "Data Extraction via RegionGrids" => "extract",
]

pages_examples = [
#     "Is it in a GeoRegion?" => "using/isin.md",
#     "RegionInfo Basics"     => "using/regiongrid.md",
#     "Custom GeoRegions"     => "using/custom.md",
]

const DIR_LIT      = joinpath(@__DIR__, "literate")
const DIR_USING    = joinpath(@__DIR__, "src/using")
const DIR_EXAMPLES = joinpath(@__DIR__, "src/examples")

scripts_using    = [ "using/" * filename * ".jl" for (title, filename) in pages_using ]
scripts_examples = [ "examples/" * filename * ".jl" for (title, filename) in pages_examples ]

for scripts in scripts_using
    scripts_filepath = joinpath(DIR_LIT, scripts)
    Literate.markdown(scripts_filepath, DIR_USING; flavor = Literate.DocumenterFlavor())
end

for scripts in scripts_examples
    scripts_filepath = joinpath(DIR_LIT, scripts)
    Literate.markdown(scripts_filepath, DIR_EXAMPLES; flavor = Literate.DocumenterFlavor())
end

# Literate.markdown("landsea.jl",joinpath(@__DIR__,"src"); flavor = Literate.DocumenterFlavor())

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
        "What is a GeoRegion: An Overview" => [
            "What is a GeoRegion?"  => "georegions/intro.md",
            "Creating GeoRegions"   => "georegions/create.md",
            "Predefined GeoRegions" => "georegions/predefined.md",
            "Retrieving GeoRegions" => "georegions/read.md",
        ],
        "What is a RegionGrid: An Overview" => [
            "What is a RegionGrid?"  => "regiongrids/intro.md",
            "Creating RegionGrids"   => "regiongrids/create.md",
        ],
        "Using GeoRegions.jl: A Tutorial" => [
            "Is it in a GeoRegion?"           => "using/isin.md",
            "Custom GeoRegions"               => "using/custom.md",
            "Data Extraction via RegionGrids" => "using/extract.md"
        ],
        "LandSea Datasets: ETOPO 2022" => [
            "What is a LandSea Dataset?" => "landsea/intro.md",
            "Loading LandSea Datasets"   => "landsea/create.md",
        ],
        "Examples"              => "example/placeholder.md",
        "Lists of GeoRegions"   => [
            "API"     => "lists/api.md",
            "Default" => "lists/default.md",
        ],
    ]
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

deploydocs(
    repo = "github.com/JuliaClimate/GeoRegions.jl.git",
    devbranch = "main"
)