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
        "GeoRegions.jl Basics" => [
            "What is a GeoRegion?"  => "georegions/intro.md",
            "Predefined GeoRegions" => "georegions/predefined.md",
            "Basic Functionality"   => [
                "Create, Save, Retrieve" => "georegions/basics/overview.md",
                "Defining RectRegions"   => "georegions/basics/rectregion.md",
                "Defining PolyRegions"   => "georegions/basics/polyregion.md",
                # "Defining TiltRegions"   => "georegions/using/tiltregion.md",
                "GeoRegion Properties"   => "georegions/basics/shape.md",
            ],
        ],
        "GeoRegions.jl in Projects"   => [
            "Setup GeoRegions.jl" => "projects/setup.md",
            "Read Custom Lists"   => "projects/read.md",
        ],
        # "Tutorials" => [
        #     "Is it in a GeoRegion?" => "using/isin.md",
        #     "Custom GeoRegions"     => "using/custom.md",
        # ],
        "Tables of GeoRegions"   => [
            "Lists of predefined GeoRegions" => "lists/default.md",
            # "Customized Lists of GeoRegions"     => "lists/api.md",
        ],
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
