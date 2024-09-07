using Documenter
using DocumenterVitepress
using GeoRegions
# using CairoMakie
# using Literate

# CairoMakie.activate!(type = "svg")

DocMeta.setdocmeta!(GeoRegions, :DocTestSetup, :(using GeoRegions); recursive=true)

# pages_using = [
#     "Is it in a GeoRegion?"           => "isin",
#     "Custom GeoRegions"               => "custom",
# ]

# const DIR_LIT      = joinpath(@__DIR__, "literate")
# const DIR_USING    = joinpath(@__DIR__, "src/using")

# scripts_using    = [ filename * ".jl" for (title, filename) in pages_using ]

# for scripts in scripts_using
#     scripts_filepath = joinpath(DIR_LIT, scripts)
#     Literate.markdown(scripts_filepath, DIR_USING; flavor = Literate.DocumenterFlavor())
# end

makedocs(;
    modules  = [GeoRegions],
    authors  = "Nathanael Wong <natgeo.wong@outlook.com>",
    sitename = "GeoRegions.jl",
    doctest  = false,
    warnonly = true,
    format   = DocumenterVitepress.MarkdownVitepress(
        repo       = "https://github.com/GeoRegionsEcosystem/GeoRegions.jl",
    ),
    pages=[
        "Home" => "index.md",
        "What is a GeoRegion?"  => "georegions.md",
        "Basic Functionality" => [
            "Retrieving GeoRegions"  => "basics/read.md",
            "Predefined GeoRegions"  => "basics/predefined.md",
            "GeoRegion Properties"   => "basics/shape.md",
            "Table of GeoRegions"    => "basics/tables.md",
            "Listing All GeoRegions" => "basics/listall.md",
        ],
        "Customizing GeoRegions.jl" => [
            "Create, Save, Retrieve" => "custom/overview.md",
            "Project Setup"          => "custom/setup.md",
            "More on Creation" => [
                "Creating RectRegions"   => "custom/create/rectregion.md",
                "Creating PolyRegions"   => "custom/create/polyregion.md",
                # "Creating TiltRegions"   => "custom/create/tiltregion.md",
            ],
            "Custom GeoRegion Files" => "custom/files.md",
        ],
        # "Tutorials" => [
        #     "Is it in a GeoRegion?" => "using/isin.md",
        #     "Custom GeoRegions"     => "using/custom.md",
        # ],
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
