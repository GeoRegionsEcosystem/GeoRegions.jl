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
    Point :: Point2{<:Real},
    geo   :: GeoRegion;
    throw :: Bool = false
)
on(
    cgeo :: GeoRegion,
    geo  :: GeoRegion;
    n    :: Int = 100,
    throw   :: Bool = false,
    verbose :: Bool = false
)
```