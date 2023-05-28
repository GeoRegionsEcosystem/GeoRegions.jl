# Land-Sea Mask Datasets

Starting from v5, GeoRegions.jl now fully supports the retrieval of 30- and 60-arcsecond ETOPO orographic data, which includes the following options:
* Topography that follows the ice-surface (surface)
* Topography that follows the bedrock beneath the ice (bedrock)
* Geoid data that converts the Topography into WTGS84 ellipsoid elevation heights

## The `AbstractLandSea` SuperType

The data is loaded into a `LandSea` dataset struct-type, which is a subset of the supertype `AbstractLandSea`.  We export this supertype, and its abstract subtypes `LandSeaTopo` and `LandSeaFlat`, so that other packages can extend the use of these abstract types with their own `LandSea` Types.

For examples of how to extend the functionality of the `LandSea` datasets, you may refer to the following examples:
* [NASAPrecipitation.jl](https://github.com/natgeo-wong/NASAPrecipitation.jl)
* [ERA5Reanalysis.jl](https://github.com/natgeo-wong/ERA5Reanalysis.jl)

```@docs
AbstractLandSea
```

## The `LandSea` Type for GeoRegions.jl

```@docs
GeoRegions.LandSea
```