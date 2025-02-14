# API for Creating, Reading, Adding and Removing GeoRegions

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

## Adding Custom GeoRegions

```@docs
add
```

## Overwriting Custom GeoRegions
```@docs
overwrite
```

## Removing Custom GeoRegions

### After having loaded a Custom GeoRegion
```@docs
rm
```

### Based on the `ID` of a Custom GeoRegion

```@docs
rmID
```