# Predefined `GeoRegion`s in GeoRegions.jl

In GeoRegions.jl, there are several predefined sets of `GeoRegion`s.

## Adapted from Giorgi & Francisco [2000]

Add the `GF_` prefix to the 3-letter IDs given in Giorgi & Francisco [2000] to call GeoRegions adapted from this paper.

!!! tip "Defined in GeoRegions.jl ≥ v1.1"
    All `GF_*` domains are defined only in versions ≥1.1

```@example readpredefined
using GeoRegions
GeoRegion("GF_WAF")
```

To see the full list of predefined GeoRegions from Giorgi & Francisco [2000], go [here](/basics/predefined/listall#Giorgi-and-Francisco-[2000])

## SREX Regions adapted from Seneviratne et al. [2012]

Add the `SREX_` prefix to the 3-letter IDs given in Seneviratne et al. [2012] to call GeoRegions adapted from this paper.

!!! tip "Defined in GeoRegions.jl ≥ v2"
    All `SREX_*` domains are defined only in versions ≥2

!!! tip "Changes to SREX IDs in GeoRegions.jl ≥ v8"
    Previous versions of GeoRegions.jl used the prefix `SRX_*`. As of GeoRegions.jl ≥v8, the prefix has been changed to `SREX_*`

```@example readpredefined
using GeoRegions
GeoRegion("SREX_CNA")
```

To see the full list of predefined GeoRegions from Seneviratne et al. [2012], go [here](/basics/predefined/listall#SREX-Regions-from-Seneviratne-et-al.-[2012])

## AR6 Regions adapted from Iturbide et al., [2020]

Add the `AR6_` prefix to the 3-letter IDs given in Iturbide et al., [2020] to call GeoRegions adapted from this paper.

!!! tip "Defined in GeoRegions.jl ≥ v2"
    All `AR6_*` domains are defined only in versions ≥2

```@example readpredefined
using GeoRegions
GeoRegion("AR6_EAS")
```

To see the full list of predefined GeoRegions from Iturbide et al., [2020], go [here](/basics/predefined/listall#IPCC-AR6-Regions-from-Iturbide-et-al.,-[2020])