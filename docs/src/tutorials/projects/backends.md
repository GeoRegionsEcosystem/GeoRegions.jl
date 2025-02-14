# Backends for GeoRegions.jl

This page gives a brief summary of the backend process that GeoRegions.j uses to save **manually** defined custom `GeoRegion`s for projects.

## JSON files

All relevant information for a GeoRegion can be divided into two components:
* String descriptors that identify a GeoRegion and make each GeoRegion unique
* Geometry, or a vector of Geometries, that describe the geographic region itself

Ever since ≥v8, I have decided that JSON is the appropriate format to store this information. Therefore, each `GeoRegion` will have its own unique `.json` file, stored in the location `$path/.georegions/$ID.json`, where `path` is the directory of your project.

We use [JSON3.jl]() to write and read these `.json` files, as JSON3.jl is able to take a `struct` and parse it into a readable JSON string.

Let's show an example

```@example jsonbackend
using GeoRegions
geo = GeoRegion(
    [3,8,5,3],[40,-20,14,40],
    ID = "TSTjson", pID = "GLB", name = "Test Save GeoRegion",
    save = true, path = joinpath(pwd(),"jsoneg")
)
```

And let's read the string inside this file

```@example jsonbackend
open(geo.path) do file
    read(file, String) 
end
```

Let's clean up the directory.
```@example jsonbackend
rm(dirname(geo.path),recursive=true)
```