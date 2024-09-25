# API for Different GeoRegion Properties

```@docs
in(
    Point  :: Point2{<:Real},
    geo    :: GeoRegion;
    tlon   :: Real = 0,
    tlat   :: Real = 0,
    throw  :: Bool = false
)
in(
    cgeo  :: GeoRegion,
    geo   :: RectRegion;
    throw :: Bool = false
)
in(
    cgeo  :: GeoRegion,
    geo   :: Union{TiltRegion,PolyRegion};
    n     :: Int = 100,
    throw :: Bool = false
)
```