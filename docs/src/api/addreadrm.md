# API for Adding, Reading and Removing GeoRegions

## Retrieving GeoRegions

```@docs
GeoRegion(
    geoID :: AbstractString;
    path  :: AbstractString = homedir()
)
```

## Adding/Removing GeoRegions

```@docs
add
overwrite
rm
rmID
```