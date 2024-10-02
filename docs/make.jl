using Documenter
using DocumenterVitepress
using GeoRegions
using CairoMakie

CairoMakie.activate!(type = "svg")

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
        "Home"                 => "index.md",
        "What is a GeoRegion?" => "georegions.md",
        "Basics"               => [
            "Load/Read a GeoRegion"     => "basics/read.md",
            "Creating a GeoRegion"      => "basics/create.md",
            "Shape of a GeoRegion"      => "basics/shape.md",
            "List Available GeoRegions" => "basics/tables.md",
            "Predefined GeoRegions"     => [
                "Predefined Datasets" => "basics/predefined/datasets.md",
                "List All GeoRegions" => "basics/predefined/listall.md",
            ],
        ],
        "Tutorials"            => [
            "Using GeoRegions.jl"          => [
                "Is it in a GeoRegion?" => "tutorials/using/isin.md",
                "Is it on a GeoRegion?" => "tutorials/using/ison.md",
            ],
            "Equivalence in GeoRegions.jl" => "tutorials/isequal.md",
            "GeoRegions.jl for Projects"   => [
                "Setting Up"             => "tutorials/projects/setup.md",
                "Add, Read, Remove"      => "tutorials/projects/addreadrm.md",
                "Custom GeoRegion Files" => "tutorials/projects/files.md",
            ],
        ],
        "API"                  => [
            "Creation"            => "api/create.md",
            "Add, Read, Remove"   => "api/addreadrm.md",
            "Project Setup"       => "api/project.md",
            "Tables"              => "api/tables.md",
            "Shape / Coordinates" => "api/shape.md",
            "Is In/On/Equal?"     => "api/isinonequal.md",
        ],
        "Ecosystem"            => "ecosystem.md",
    ],
)

recursive_find(directory, pattern) =
    mapreduce(vcat, walkdir(directory)) do (root, dirs, files)
        joinpath.(root, filter(contains(pattern), files))
    end

files = []
for pattern in [r"\.cst", r"\.nc", "test.geo"]
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
