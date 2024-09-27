"""
    add(
        geo  :: GeoRegion;
        path :: AbstractString = dirname(geo.path),
        verbose :: Bool = true
    ) -> nothing

Saves information on the GeoRegion `geo` to a directory specified by `path`.

Arguments
=========
- `geo` : The GeoRegion to be saved into the custom lists in `path`

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`
"""
function add(
    geo  :: RectRegion;
    path :: AbstractString = dirname(geo.path),
    verbose :: Bool = false
)

    RectRegion(
        geo.ID, geo.pID, geo.name,
        geo.bound,
        path = path, verbose = verbose, save = true
    )

    return nothing

end

function add(
    geo  :: TiltRegion;
    path :: AbstractString = dirname(geo.path),
    verbose :: Bool = false
)

    TiltRegion(
        geo.ID, geo.pID, geo.name,
        geo.X, geo.Y, geo.ΔX, geo.ΔY, geo.θ,
        path = path, verbose = verbose, save = true
    )

    return nothing

end

function add(
    geo  :: PolyRegion;
    path :: AbstractString = dirname(geo.path),
    verbose :: Bool = false
)

    lon,lat = coordinates(geo)

    PolyRegion(
        geo.ID, geo.pID, geo.name,
        lon, lat,
        path = path, verbose = verbose, save = true
    )

    return nothing

end

"""
    overwrite(
        geo  :: GeoRegion;
        path :: AbstractString = dirname(geo.path),
        verbose :: Bool = true
    ) -> nothing

Overwrites preexisting information associated with the ID `geo.ID` in `path`, with new information from the `GeoRegion` specified by `geo`

Arguments
=========
- `geo` : The GeoRegion to be saved into the custom lists in `path`, overwriting any preexisting information associated with the ID `geo.ID`.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`
"""
function overwrite(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    verbose :: Bool = false
)

    rmID(geo.ID,path=path)
    add(geo,path=path,verbose=verbose)
    
    return nothing

end