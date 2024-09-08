# Default List of Predefined GeoRegions
```@example listgeo
using GeoRegions
resetGeoRegions(all=true);
```

## GeoRegions.jl's default region is the Globe

```@example listgeo
tableGeoRegions(predefined=false,custom=false)
```

## Giorgi & Francisco [2000]

Add the `GF_` prefix to the 3-letter IDs given in Giorgi & Francisco [2000] to call GeoRegions adapted from this paper.  All GeoRegions are defined as the `RectRegion` type.

!!! compat "Defined in GeoRegions > 1.1"
    All `GF_*` domains are defined only in versions ≥1.1

```@example listgeo
tableRectRegions(giorgi=true,custom=false)
```

## SREX Regions from Seneviratne et al. [2012]

Add the `SRX_` prefix to the 3-letter IDs given in Seneviratne et al. [2012] to call GeoRegions adapted from this paper.  All GeoRegions are defined as the `PolyRegion` type, even though many of them are rectilinear.

!!! compat "Defined in GeoRegions ≧ 2"
    All `SRX_*` domains are defined only in versions ≥2

```@example listgeo
tablePolyRegions(srex=true,custom=false)
```

## IPCC AR6 Regions from Iturbide et al., [2020]

Add the `AR6_` prefix to the 3-letter IDs given in Iturbide et al., [2020] to call GeoRegions adapted from this paper.  All GeoRegions are defined as the `PolyRegion` type.

!!! compat "Defined in GeoRegions ≧ 2"
    All `AR6_*` domains are defined only in versions ≥2

```@example listgeo
tablePolyRegions(ar6=true,custom=false)
```