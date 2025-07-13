# Default List of Predefined GeoRegions
```@example listgeo
using GeoRegions
setupGeoRegions(overwrite=true);
```

## GeoRegions.jl's default region is the Globe

```@example listgeo
tableGeoRegions(predefined=false,custom=false)
```

## Giorgi & Francisco [2000]

Add the `GF_` prefix to the 3-letter IDs given in Giorgi & Francisco [2000] to call GeoRegions adapted from this paper.

!!! compat "Defined in GeoRegions > 1.1"
    All `GF_*` domains are defined only in versions ≥1.1

```@example listgeo
tableGeoRegions(giorgi=true,srex=false,ar6=false,custom=false)
```

## SREX Regions from Seneviratne et al. [2012]

Add the `SREX_` prefix to the 3-letter IDs given in Seneviratne et al. [2012] to call GeoRegions adapted from this paper.

!!! compat "Defined in GeoRegions ≧ 2"
    All `SREX_*` domains are defined only in versions ≥2

!!! tip "Changes to SREX IDs in GeoRegions.jl ≥ v8"
    Previous versions of GeoRegions.jl used the prefix `SRX_*`. As of GeoRegions.jl ≥v8, the prefix has been changed to `SREX_*`

```@example listgeo
tableGeoRegions(giorgi=false,srex=true,ar6=false,custom=false)
```

## IPCC AR6 Regions from Iturbide et al., [2020]

Add the `AR6_` prefix to the 3-letter IDs given in Iturbide et al., [2020] to call GeoRegions adapted from this paper.

!!! compat "Defined in GeoRegions ≧ 2"
    All `AR6_*` domains are defined only in versions ≥2

```@example listgeo
tableGeoRegions(giorgi=false,ar6=true,srex=false,custom=false)
```