# API for Adding, Reading and Removing GeoRegions

```@docs
GeoRegion(
        geoID :: AbstractString;
        path  :: AbstractString = homedir()
    ) -> geo :: GeoRegion
```

```@docs
add
rm
```

You can also remove a GeoRegion associated with an `ID`.

```@docs
rmID
```