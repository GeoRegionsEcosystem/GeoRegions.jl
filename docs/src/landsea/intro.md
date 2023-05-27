# Land-Sea Mask Datasets

Starting from v5, GeoRegions.jl now fully supports the retrieval of 30- and 60-arcsecond ETOPO orographic data, which includes the following options:
* Topography that follows the ice-surface (surface)
* Topography that follows the bedrock beneath the ice (bedrock)
* Geoid data that converts the Topography into WTGS84 ellipsoid elevation heights

```@docs
GeoRegions.LandSea
```