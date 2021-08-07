<p align="center">
<img alt="NASAPrecipitation.jl Logo" src=https://raw.githubusercontent.com/JuliaClimate/GeoRegions.jl/main/src/logosmall.png />
</p>

# **<div align="center">GeoRegions.jl</div>**

<p align="center">
  <a href="https://www.repostatus.org/#active">
    <img alt="Repo Status" src="https://www.repostatus.org/badges/latest/active.svg?style=flat-square" />
  </a>
  <a href="https://github.com/JuliaClimate/GeoRegions.jl/actions/workflows/ci.yml">
    <img alt="GitHub Actions" src="https://github.com/JuliaClimate/GeoRegions.jl/actions/workflows/ci.yml/badge.svg?branch=main&style=flat-square">
  </a>
  <br>
  <a href="https://mit-license.org">
    <img alt="MIT License" src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square">
  </a>
	<img alt="MIT License" src="https://img.shields.io/github/v/release/JuliaClimate/GeoRegions.jl.svg?style=flat-square">
  <a href="https://juliaclimate.github.io/GeoRegions.jl/stable/">
    <img alt="Latest Documentation" src="https://img.shields.io/badge/docs-stable-blue.svg?style=flat-square">
  </a>
  <a href="https://juliaclimate.github.io/GeoRegions.jl/dev/">
    <img alt="Latest Documentation" src="https://img.shields.io/badge/docs-latest-blue.svg?style=flat-square">
  </a>
</p>

**Created By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)

## **Introduction**

`GeoRegions.jl` is a Julia package that aims to streamline the following processes:
* query if a point / grid is within a specified boundary
* extract point data (given coordinates) from a given region
* extract gridded data (given grid boundaries) from a larger (parent) region (grid must be entirely within the parent region)

In general, these boundaries can be specified either using `[N,S,E,W]` coordinates, or by `longitude` and `latitude` vectors.

`GeoRegions.jl` can be installed via
```
] add GeoRegions
```

## **Usage**

Please refer to the [documentation](https://juliaclimate.github.io/GeoRegions.jl/dev/) for instructions and examples.
