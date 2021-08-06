# [GeoRegions.jl](https://github.com/JuliaClimate/GeoRegions.jl)
*Extract Regional Data from a Gridded Dataset*

`GeoRegions.jl` is a Julia package that aims to streamline the following processes:
* query if a point / grid is within a specified boundary
* extract point data (given coordinates) from a given region
* extract regional data from a gridded dataset, or from a parent region dataset

The new core functionality of GeoRegions.jl (newly developed in v2), are the `GeoRegion` and `RegionInfo` supertypes, which contains information
* `GeoRegion`: regarding the shape and bounds of a given GeoRegion
* `RegionGrid`: needed to extract information from a lon-lat grid typical of climate datasets, such as Reanalysis data, GCM model output, satellite observations, etc.

## Installation Instructions

The latest version of GeoRegions can be installed using the Julia package manager (accessed by pressing `]` in the Julia command prompt)
```
julia> ]
(@v1.6) pkg> add GeoRegions
```

You can update `GeoRegions.jl` to the latest version using
```
(@v1.6) pkg> update GeoRegions
```

And if you want to get the latest release without waiting for me to update the Julia Registry (although this generally isn't necessary since I make a point to release patch versions as soon as I find bugs or add new working features), you may fix the version to the `main` branch of the GitHub repository:
```
(@v1.6) pkg> add GeoRegions#main
```

## Documentation Overview

The documentation for `GeoRegions.jl` is divided into three components:
1. Tutorials - meant as an introduction to the package
2. How-to Examples - geared towards those looking for specific examples of what can be done
3. API Reference - comprehensive summary of all exported functionalities

!!! tip "Obtaining Example Datasets"
    All the output for the coding examples were produced using my computer with key security information (such as login info) omitted.  The examples cannot be run online because the file size requirements are too big.  Copying and pasting the code examples (with relevant directory and login information changes) should produce the same results.

## Getting help
If you are interested in using `GeoRegions.jl` or are trying to figure out how to use it, please feel free to ask me questions and get in touch!  Please feel free to [open an issue](https://github.com/JuliaClimate/GeoRegions.jl/issues/new) if you have any questions, comments, suggestions, etc!
