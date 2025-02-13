# API for Creating, Adding, Reading and Removing GeoRegions

## Creating GeoRegions

```@docs
GeoRegion(::Vector{<:Real}, ::Vector{<:Real})
```

## Retrieving GeoRegions

```@docs
GeoRegion(
    ID   :: AbstractString;
    path :: AbstractString = homedir()
)
```

## Adding/Removing GeoRegions

```@docs
add
overwrite
rm
rmID
```