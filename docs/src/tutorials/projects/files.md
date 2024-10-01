# Files of custom `GeoRegion`s

This page gives a brief introduction into how to **manually** defined custom `GeoRegion`s in their respective files.

```@example files
using GeoRegions
using DelimitedFiles
```

## `RectRegion` and `TiltRegion` Files

Manually defining a `RectRegion` or a `TiltRegion` in the `rectlist.txt` and `tiltlist.txt` files is relatively simple. Simple follow the order of the headers in the respective files.

!!! warn "Name of GeoRegion"
    To manually define the `name` of the `GeoRegion`, replace all **spaces** with `-`. For example, "Southern South America" would be written as "Southern-South-America" in the text file. Please see `joinpath($(GeoRegions.geodir),"giorgi.txt")` for examples.

### Example in rectlist.txt

In `rectlist.txt`, the header is

```
# RectRegion
# List of RectRegion GeoRegions
# (1)ID, (2)pID, (3)N, (4)W, (5)S, (6)E, (7)Description
```

Therefore in order to define a `RectRegion` directly in the filed, we do, for example

```
TST, GLB, 70, -60, -20, 130, Test-RectRegion-Manual-Add
```

which is the same as

```julia
RectRegion("TST","GLB","Test RectRegion Manual Add",[70,-20,130,-60])
```

!!! warning "Order of Bounds"
    Note that in the `RectRegion()` function, the bound is ordered in `[N,S,E,W]`, but when directly inputing into file, it is in the order `N, W, S, E`.

### Example in tiltlist.txt

In `tiltlist.txt`, the header is

```
# TiltRegion
# List of TiltRegion GeoRegions
# (1)ID, (2)pID, (3)X, (4)Y, (5)ΔX, (6)ΔY, (7)θ, (8)Name
```

Therefore in order to define a `TiltRegion` directly in the filed, we do, for example

```
TST, GLB, 30, 40, 100, 5, 10, Test-TiltRegion-Manual-Add
```

which is the same as

```julia
TiltRegion("TST","GLB","Test TiltRegion Manual Add",[30,40,100,5,10])
```

## `PolyRegion` Files

Manually defining a `PolyRegion` in `polylist.txt` is in some ways very tricky, and honestly it is best done by calling `PolyRegion(...,save=true)`. However, should you wish to manually define a `PolyRegion` directly in a file, the header is

```
# PolyRegion
# List of PolyRegion GeoRegions
# (ID, pID, Name), X, Y

```

!!! warning "Additional empty lines"
    The additional empty line between the header and the `GeoRegion`s below it, and between the individual `PolyRegion`s being defined, is **essential**. GeoRegions.jl reads a file containing `PolyRegion`s on a **_line-by-line_** basis and thus empty lines are very important.


Following the header, we have the following lines

```
RegID 
RegX  
RegY  
```

And then
* Following `RegID`, we should fill in the `(ID, pID, Name)`, separated by **spaces**.
* Following `RegX`, we should fill in the **longitude** vector
* Following `RegY`, we should fill in the **latitude** vector

For example, we have
```
RegID AR6_ENA, GLB, Eastern-North-America       # (ID, pID, Name)
RegX  -70.0, -90.0, -90.0, -50.0, -77.0, -70.0  # Longitude vector
RegY  25.0, 25.0, 50.0, 50.0, 31.0, 25.0        # Latitude vector
```

Which is the same as defining

```julia
PolyRegion(
    "AR6_ENA","GLB","Eastern-North-America", # (ID, pID, Name)
    [-70.0,-90.0,-90.0,-50.0,-77.0,-70.0],   # Longitude vector
    [25.0,25.0,50.0,50.0,31.0,25.0]          # Latitude vector
)
```

!!! warning "Additional empty lines"
    There is an empty line between each `PolyRegion` being defined. And **there needs to be an additional empty line after the last `PolyRegion` defined. Please see `joinpath($(GeoRegions.geodir),"ar6.txt")` as an example.

## Listing GeoRegions inside Custom Files

Suppose you have a list of `GeoRegion`s inside a custom file (that is not `rectlist.txt`, `tiltlist.txt` or `polylist.txt`), you can read the `GeoRegion`s defined inside this custom file into your project via `readGeoRegions()`

```@example files
download("https://raw.githubusercontent.com/GeoRegionsEcosystem/notebooks/refs/heads/main/files/customrect.txt","test.geo")
geovec = readGeoRegions("test.geo")
```

## Adding GeoRegions inside Custom Files

We can directly add the `GeoRegion`s inside such custom files using the function `addGeoRegions()` as follows:

```@example files
addGeoRegions("test.geo",path=pwd())
```

And we test this:

```@example files
GeoRegion("CRB",path=pwd())
```

Now, let's remove the custom `GeoRegion`s we defined above

```@example files
deleteGeoRegions(path=pwd())
```

```@repl files
GeoRegion("CRB",path=pwd())
```