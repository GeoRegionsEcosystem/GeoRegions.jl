# API for Is it in/on a GeoRegion?

```@docs
in(
    Point :: Point2{<:Real},
    geo   :: GeoRegion;
    throw :: Bool = false
)
in(
    cgeo :: GeoRegion,
    geo  :: GeoRegion;
    n    :: Int = 100,
    throw   :: Bool = false,
    verbose :: Bool = false
)
on(
    point :: Point2{<:Real},
    geo   :: GeoRegion;
    throw :: Bool = false
)
on(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    n    :: Int = 2,
    throw   :: Bool = false,
    verbose :: Bool = false
)
==(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion,
)
isequal(
    geo1 :: RectRegion,
    geo2 :: RectRegion;
    strict  :: Bool = true,
    verbose :: Bool = false
)
isgeo(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    strict  :: Bool = true,
    shape   :: Bool = true,
    throw   :: Bool = true,
    verbose :: Bool = false
)
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
isID(
    ID   :: AbstractString;
    path :: AbstractString = homedir(),
    throw   :: Bool = true,
    verbose :: Bool = false
)
```