```@raw html
---
layout: home

hero:
  name: "GeoRegions.jl"
  text: "Geographic Regions for Geospatial Data"
  tagline: Defining Geographic Regions of Interest for Geospatial Data in Geoscience and Climate.
  image:
    src: /logo.png
    alt: GeoRegions
  actions:
    - theme: brand
      text: Getting Started
      link: /georegions
    - theme: alt
      text: Basics
      link: /basics/read/overview
    - theme: alt
      text: Tutorials
      link: /tutorials/using/isin
    - theme: alt
      text: View on Github
      link: https://github.com/GeoRegionsEcosystem/GeoRegions.jl
      

features:
  - icon: <img width="64" height="64" src="https://img.icons8.com/arcade/64/markdown.png" alt="markdown"/>
    title: Simple
    details: Geographic Regions are defined using Longitude/Latitude coordinates
    link: /basics/shape
  - icon: <img width="64" height="64" src="https://img.icons8.com/arcade/64/markdown.png" alt="markdown"/>
    title: Predefined GeoRegions
    details: Many predefined Geographic Regions bundled, from the IPCC AR6 report
    link: /basics/read/predefined
  - icon: <img width="64" height="64" src="https://img.icons8.com/arcade/64/markdown.png" alt="markdown"/>
    title: Customizable
    details: Define your own custom Geographic Regions and save them for later
    link: /tutorials/projects/addreadrm
  - icon: <img width="64" height="64" src="https://img.icons8.com/arcade/64/markdown.png" alt="markdown"/>
    title: Useful
    details: Check if points or a region are in/on a GeoRegion?
    link: /tutorials/using/isin
---
```

## Installation Instructions

The latest version of GeoRegions can be installed using the Julia package manager (accessed by pressing `]` in the Julia command prompt)
```julia-repl
julia> ]
(@v1.10) pkg> add GeoRegions
```

You can update `GeoRegions.jl` to the latest version using
```julia-repl
(@v1.10) pkg> update GeoRegions
```

And if you want to get the latest release without waiting for me to update the Julia Registry (although this generally isn't necessary since I make a point to release patch versions as soon as I find bugs or add new working features), you may fix the version to the `main` branch of the GitHub repository:
```julia-repl
(@v1.10) pkg> add GeoRegions#main
```

## Getting help
If you are interested in using `GeoRegions.jl` or are trying to figure out how to use it, please feel free to ask me questions and get in touch!  Please feel free to [open an issue](https://github.com/JuliaClimate/GeoRegions.jl/issues/new) if you have any questions, comments, suggestions, etc!
