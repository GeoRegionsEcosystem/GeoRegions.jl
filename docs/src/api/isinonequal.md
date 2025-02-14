# API for Is it in/on/equal to a GeoRegion?

## In

### Is Point In a GeoRegion
```@docs
in(
    Point :: Point2{<:Real},
    geo   :: GeoRegion;
    throw :: Bool = false
)
```

### Is GeoRegion In a GeoRegion
```@docs
in(
    cgeo :: GeoRegion,
    geo  :: GeoRegion;
    n    :: Int = 100,
    throw   :: Bool = false,
    verbose :: Bool = false
)
```

## On

### Is Point On a GeoRegion
```@docs
on(
    point :: Point2{<:Real},
    geo   :: GeoRegion;
    throw :: Bool = false
)
```

### Is GeoRegion On a GeoRegion
```@docs
on(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    n    :: Int = 2,
    throw   :: Bool = false,
    verbose :: Bool = false
)
```

## Equivalence of GeoRegions
```@docs
==(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion,
)
isequal(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    verbose :: Bool = false
)
```

## Does this GeoRegion already Exist?
```@docs
isgeo(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    throw   :: Bool = true,
    verbose :: Bool = false
)
```

## Equivalence of GeoRegion IDs
```@docs
isID(
    ID   :: AbstractString;
    path :: AbstractString = homedir(),
    throw   :: Bool = true,
    verbose :: Bool = false
)
```

## Equivalence of GeoRegion Shapes
```@docs
isgeoshape(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    returnID :: Bool = true,
    verbose  :: Bool = false
)
isgeoshape(
    lon  :: Vector{<:Real},
    lat  :: Vector{<:Real};
    path :: AbstractString = dirname(geo.path),
    returnID :: Bool = true,
    verbose  :: Bool = false
)
```