"""
    add(
        geo  :: GeoRegion;
        path :: AbstractString = dirname(geo.path),
        verbose :: Bool = false
    ) -> nothing

Saves information on the GeoRegion `geo` to a directory specified by `path`.

Arguments
=========
- `geo` : The GeoRegion to be saved into the custom lists in `path`.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to `dirname(geo.path)`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.
"""
function add(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    verbose :: Bool = false
)

    lon,lat = coordinates(geo)

    GeoRegion(
        lon, lat, ID = geo.ID, pID = geo.pID, name = geo.name, rotation = geo.θ,
        path = geopath(path), verbose = verbose, save = true
    )

    return nothing

end

"""
    overwrite(
        geo  :: GeoRegion;
        path :: AbstractString = dirname(geo.path),
        verbose :: Bool = false
    ) -> nothing

Overwrites preexisting information associated with the ID `geo.ID` in `path`, with new information from the `GeoRegion` specified by `geo`.

Arguments
=========
- `geo` : The GeoRegion to be saved into the custom lists in `path`, overwriting any preexisting information associated with the ID `geo.ID`.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to `dirname(geo.path)`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.
"""
function overwrite(
    geo :: GeoRegion;
    path    :: AbstractString = dirname(geo.path),
    verbose :: Bool = false
)

    gpath = geopath(path)
    rmID(geo.ID,path=gpath)
    add(geo,path=gpath,verbose=verbose)
    
    return nothing

end