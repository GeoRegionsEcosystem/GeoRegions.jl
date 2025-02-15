"""
    isgeoshape(
        geo  :: GeoRegion;
        path :: AbstractString = dirname(geo.path),
        returnID :: Bool = true,
        verbose  :: Bool = false
    ) -> tf :: Bool

Checks all the GeoRegions defined in the project determined by `path`. If there exists a GeoRegion `tgeo` such that `on(geo,tgeo) = true`, then returns `true` by default, or otherwise, if `returnID` is true, it will return `tgeo.ID`. If there is no `GeoRegion` with the same shape, then either returns a `false` or throws and error depending on `throw`

Arguments
=========
- `geo` : The GeoRegion in question.

Keyword Arguments
=================
- `path` : The path where GeoRegions will be retrieved from and compared against.
           Defaults to the directory `geo.path`.
- `returnID` : If `true`, then returns the `ID` of the `GeoRegion` in `path` with the same shape as `geo`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function isgeoshape(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    returnID :: Bool = false,
    verbose  :: Bool = false
)

    gpath = geopath(path)
    IDvec,_ = listall(gpath,verbose); ngeo = length(IDvec)
    tf = zeros(Bool,ngeo)

    for igeo in 1 : ngeo
        tgeo = GeoRegion(IDvec[igeo],path=gpath,verbose=verbose)
        tf[igeo] = on(geo,tgeo,verbose=verbose)
    end

    if !iszero(sum(tf))
        if returnID
            return IDvec[tf][1]
        else
            return true
        end
    else
        return false
    end

end

"""
    isgeoshape(
        lon  :: Vector{<:Real},
        lat  :: Vector{<:Real};
        path :: AbstractString = dirname(geo.path),
        returnID :: Bool = true,
        verbose  :: Bool = false
    ) -> tf :: Bool

Checks all the GeoRegions defined in the project determined by `path`. If there exists a GeoRegion `tgeo` with the same shape as defined by the vectors `lon` and `lat`, returns `true` by default, or otherwise, if `returnID` is true, it will return the `tgeo.ID`. If there is no `GeoRegion` with the same shape, then either returns a `false` or throws and error depending on `throw`

Arguments
=========
- `lon` : Vector of longitude points.
- `lat` : Vector of latitude points.

Keyword Arguments
=================
- `path` : The path where GeoRegions will be retrieved from and compared against.
           Defaults to the directory `homedir()`.
- `returnID` : If `true`, then returns the `ID` of the `GeoRegion` in `path` with the same shape as `geo`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function isgeoshape(
    lon  :: Vector{<:Real},
    lat  :: Vector{<:Real};
    path :: AbstractString = homedir(),
    returnID :: Bool = false,
    verbose  :: Bool = false
)

    gpath = geopath(path)

    IDvec,_ = listall(gpath,verbose); ngeo = length(IDvec)
    tf = zeros(Bool,ngeo)

    geo = GeoRegion(lon,lat)

    for igeo in 1 : ngeo
        tgeo = GeoRegion(IDvec[igeo],path=gpath,verbose=verbose)
        tf[igeo] = on(geo,tgeo,verbose=verbose)
    end

    if !iszero(sum(tf))
        if returnID
            return IDvec[tf][1]
        else
            return true
        end
    else
        return false
    end

end