"""
    ==(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion,
    ) -> tf :: Bool

Checks (a) ID, (b) pID, (c) rotation, and (d) the geometry/shape of two different GeoRegions in order to determine if they are exactly the same.

The `geo1.shape` and `geo2.shape` need not be exactly the same as long as they define the same area (i.e., the points in `geo2` can be a circshift version of `geo1`). They can also be offset from each other by 360º.

Arguments
=========
- `geo1` : The first GeoRegion.
- `geo2` : The second GeoRegion.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
==(geo1 :: GeoRegion, geo2 :: GeoRegion) = isequal(geo1,geo2)
!==(geo1 :: GeoRegion, geo2 :: GeoRegion) = !isequal(geo1,geo2)

"""
    isequal(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion;
        verbose :: Bool = false
    ) -> tf :: Bool

Checks (a) ID, (b) pID, (c) rotation, and (d) the geometry/shape of two different GeoRegions in order to determine if they are exactly the same.

The `geo1.shape` and `geo2.shape` need not be exactly the same as long as they define exactly the same area (i.e., the points in `geo2` can be a `circshift()` version of `geo1`).

Arguments
=========
- `geo1` : The first GeoRegion.
- `geo2` : The second GeoRegion.

Keyword Arguments
=================
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function isequal(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    verbose :: Bool = false
)
 
    tf = on(geo1,geo2,verbose=verbose)

    if (geo1.ID !== geo2.ID) || (geo1.pID !== geo2.pID) || (geo1.θ !== geo2.θ)

        tf = false
    end

    return tf

end

"""
    isgeo(
        geo  :: GeoRegion;
        path :: AbstractString = dirname(geo.path),
        throw   :: Bool = true,
        verbose :: Bool = false
    ) -> tf :: Bool

Checks all the GeoRegions defined in the project determined by `path` against a given GeoRegion `geo`. If there is any GeoRegion `tgeo` that returns `isequal(geo,tgeo) = true`, then `isgeo(geo) = true`. Otherwise, returns `false` or throws an error.

Arguments
=========
- `geo` : The GeoRegion in question.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the directory `geo.path`.
- `throw` : If `true`, then throws an error if there is no `GeoRegion` defined in `path` with the same characteristics or field values as `geo`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function isgeo(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    throw   :: Bool = false,
    verbose :: Bool = false
)

    gpath = geopath(path)
    if isID(geo.ID,path=gpath,throw=throw,verbose=verbose)

        tgeo = GeoRegion(geo.ID,path=gpath,verbose=verbose)
        if isequal(geo,tgeo,verbose=verbose)
            verbose ? (@info "$(modulelog()) - A previously defined GeoRegion \"$(tgeo.ID)\" in $path shares the same properties as our custom GeoRegion \"$(geo.ID)\".") : nothing
            return true
        else
            if throw
                error("$(modulelog()) - The custom GeoRegion \"$(tgeo.ID)\" from the lists in $path does not have the same properties as the GeoRegion \"$(geo.ID)\" we have defined despite having the same ID.")
            else
                @warn "$(modulelog()) - The custom GeoRegion \"$(tgeo.ID)\" from the lists in $path does not have the same properties as the GeoRegion \"$(geo.ID)\" we have defined despite having the same ID."
                return false
            end
        end
        
    else

        return false

    end

end

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

"""
    isID(
        ID   :: AbstractString;
        path :: AbstractString = homedir(),
        throw   :: Bool = true,
        verbose :: Bool = false
    ) -> tf :: Bool

Checks if there is a GeoRegion, that exists in the custom lists defined in `path`, with the ID `ID`.

Arguments
=========
- `ID` : The keyword ID that will be used to identify the GeoRegion.
        If the ID is not valid (i.e. not being used), then an error will be thrown.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the current directory `pwd()`.
- `throw` : If `true`, then throws an error if `ID` is not a valid `GeoRegion` identifier instead of returning the Boolean `tf`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function isID(
    ID   :: AbstractString;
    path :: AbstractString = homedir(),
    throw   :: Bool = true,
    verbose :: Bool = false
)

    IDvec,_ = listall(geopath(path))
    return isIDinlist(ID,IDvec;throw=throw,verbose=verbose)

end

function isIDinlist(
    ID    :: AbstractString,
    IDvec :: AbstractArray;
    throw   :: Bool = true,
    verbose :: Bool = false
)

    if verbose; @info "$(modulelog()) - Checking to see if the ID $ID is in use ..." end

    if sum(IDvec.==ID) == 0
        if throw
            error("$(modulelog()) - $(ID) is not a valid GeoRegion identifier, use GeoRegion() to add this GeoRegion to the list.")
        else
            verbose ? (@warn "$(modulelog()) - $(ID) is not a valid GeoRegion identifier, use GeoRegion() to add this GeoRegion to the list.") : nothing
            return false
        end
    else
        verbose ? (@info "$(modulelog()) - The ID $ID is already in use.") : nothing
        return true
    end

end