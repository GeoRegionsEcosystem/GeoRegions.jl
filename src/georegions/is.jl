"""
    ==(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion,
    ) -> tf :: Bool

Checks all the fields (except names and paths) of two different GeoRegions in order to determine if they are exactly the same. The GeoRegions must be of the same GeoRegion `type`.

The `geo1.shape` and `geo2.shape` need not be exactly the same as long as they define the same area (i.e., the points in `geo2` can be a circshift version of `geo1`).

Arguments
=========
- `geo1` : The first GeoRegion
- `geo2` : The second GeoRegion

Returns
=======
- `tf` : True / False
"""
==(geo1 :: GeoRegion, geo2 :: GeoRegion) = isequal(geo1,geo2)
!==(geo1 :: GeoRegion, geo2 :: GeoRegion) = !isequal(geo1,geo2)

"""
    isequal(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion;
        strict :: Bool = true
    ) -> tf :: Bool

Checks all the fields (except names) of two different GeoRegions in order to determine if they are exactly the same. The GeoRegions must be of the same GeoRegion `type`.

The `geo1.shape` and `geo2.shape` need not be exactly the same as long as they define the same area (i.e., the points in `geo2` can be a circshift version of `geo1`).

Arguments
=========
- `geo1` : The first GeoRegion
- `geo2` : The second GeoRegion

Keyword Arguments
=================
- `strict` : If `true` (which is default), check to see if all fields are equivalent except for `name` and `path`

Returns
=======
- `tf` : True / False
"""
function isequal(
    geo1 :: RectRegion,
    geo2 :: RectRegion;
    strict :: Bool = true
)

    tf = equalshape(geo1,geo2)

    if geo1.ID !== geo2.ID
        tf = false
    end

    if strict
        if (geo1.pID !== geo2.pID) || 
            !isequal(geo1.bound,geo2.bound) || 
            (geo1.is180 !== geo2.is180) || 
            (geo1.is360 !== geo2.is360)
            tf = false
        end
    end

    return tf

end

function isequal(
    geo1 :: PolyRegion,
    geo2 :: PolyRegion;
    strict :: Bool = true
)

    tf = equalshape(geo1,geo2)

    if geo1.ID !== geo2.ID
        tf = false
    end

    if strict
        if (geo1.pID !== geo2.pID) || 
            !isequal(geo1.bound,geo2.bound) || 
            (geo1.is180 !== geo2.is180) || 
            (geo1.is360 !== geo2.is360)
            tf = false
        end
    end

    return tf

end

function isequal(
    geo1 :: TiltRegion,
    geo2 :: TiltRegion;
    strict :: Bool = true
)

    tf = equalshape(geo1,geo2)

    if geo1.ID !== geo2.ID
        tf = false
    end

    if strict
        if (geo1.pID !== geo2.pID) || 
            !isequal(geo1.bound,geo2.bound) || 
            (geo1.is180 !== geo2.is180) || 
            (geo1.is360 !== geo2.is360) || 
            (geo1.geometry !== geo2.geometry)
            tf = false
        end
    end

    return tf

end

isequal(
    geo1 :: RectRegion,
    geo2 :: Union{TiltRegion, PolyRegion};
    strict :: Bool = true
) = if strict || (geo1.ID !== geo2.ID) || (geo1.pID !== geo2.pID)
    return false
else
    return equalshape(geo1,geo2)
end

isequal(
    geo1 :: TiltRegion,
    geo2 :: Union{RectRegion, PolyRegion};
    strict :: Bool = true
) = if strict || (geo1.ID !== geo2.ID) || (geo1.pID !== geo2.pID)
    return false
else
    return equalshape(geo1,geo2)
end

isequal(
    geo1 :: PolyRegion,
    geo2 :: Union{RectRegion, TiltRegion};
    strict :: Bool = true
) = if strict || (geo1.ID !== geo2.ID) || (geo1.pID !== geo2.pID)
    return false
else
    return equalshape(geo1,geo2)
end

"""
    isgeo(
        geo   :: GeoRegion;
        path  :: AbstractString = dirname(geo.path),
        throw :: Bool = true
    ) -> tf :: Bool

Checks all the GeoRegions defined in the project determined by `path`. If there exists a `GeoRegion` with the same `ID` **and** the same field values as the GeoRegion `geo`, returns `true`. Otherwise, returns `false` or throws an error.

Arguments
=========
- `geo` : The GeoRegion in question

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the directory `geo.path`
- `throw` : If `true`, then throws an error if there is no `GeoRegion` defined in `path` with the same characteristics or field values as `geo`.

Returns
=======
- `tf` : True / False
"""
function isgeo(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    strict :: Bool = true,
    throw  :: Bool = false
)

    if isID(geo.ID,path=path,throw=throw)

        tgeo = GeoRegion(geo.ID,path=path)
        if isequal(geo,tgeo,strict=strict)
            @info "$(modulelog()) - The GeoRegion \"$(geo.ID)\" we have defined shares the same properties as the custom GeoRegion \"$(tgeo.ID)\" from the lists in $path"
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
        throw    :: Bool = false,
        returnID :: Bool = true
    ) -> tf :: Bool

Checks all the GeoRegions defined in the project determined by `path`. If there exists a `GeoRegion` with the same shape as `geo.shape`, returns `true` by default, or otherwise, if `returnID` is true, it will return the ID. If there is no `GeoRegion` with the same shape, then either returns a `false` or throws and error depending on `throw`

Arguments
=========
- `geo` : The GeoRegion in question

Keyword Arguments
=================
- `path` : The path where GeoRegions will be retrieved from and compared against.
           Defaults to the directory `geo.path`
- `throw` : If `true`, will throw an error if no GeoRegion in `path` has the same shape as `geo`
- `returnID` : If `true`, then returns the `ID` of the `GeoRegion` in `path` with the same shape as `geo`.

Returns
=======
- `tf` : True / False
"""
function isgeoshape(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path),
    returnID :: Bool = false
)

    IDvec,_,_,_ = listall(path); ngeo = length(IDvec)
    tf = zeros(Bool,ngeo)

    for igeo in 1 : ngeo
        tgeo = GeoRegion(IDvec[igeo],path=path,verbose=false)
        tf[igeo] = equalshape(geo,tgeo)
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
        throw    :: Bool = false,
        returnID :: Bool = true
    ) -> tf :: Bool

Checks all the GeoRegions defined in the project determined by `path`. If there exists a `GeoRegion` with the same shape as defined by the vectors `lon` and `lat`, returns `true` by default, or otherwise, if `returnID` is true, it will return the ID. If there is no `GeoRegion` with the same shape, then either returns a `false` or throws and error depending on `throw`

Arguments
=========
- `lon` : Vector of longitude points
- `lat` : Vector of latitude points

Keyword Arguments
=================
- `path` : The path where GeoRegions will be retrieved from and compared against.
           Defaults to the directory `homedir()`
- `throw` : If `true`, will throw an error if no GeoRegion in `path` has the same shape as `geo`
- `returnID` : If `true`, then returns the `ID` of the `GeoRegion` in `path` with the same shape as `geo`.

Returns
=======
- `tf` : True / False
"""
function isgeoshape(
    lon  :: Vector{<:Real},
    lat  :: Vector{<:Real};
    path :: AbstractString = homedir(),
    returnID :: Bool = false
)

    IDvec,_,_,_ = listall(path); ngeo = length(IDvec)
    tf = zeros(Bool,ngeo)

    geo = PolyRegion("","","",lon,lat)

    for igeo in 1 : ngeo
        tgeo = GeoRegion(IDvec[igeo],path=path,verbose=false)
        tf[igeo] = equalshape(geo,tgeo)
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
        geoID :: AbstractString;
        path  :: AbstractString = homedir(),
        throw :: Bool = true
    ) -> tf :: Bool

Checks if there is a GeoRegion, that exists in the custom lists defined in `path`, with the ID `geoID`.

Arguments
=========
- `geoID` : The keyword ID that will be used to identify the GeoRegion.
        If the ID is not valid (i.e. not being used), then an error will be thrown.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the current directory `pwd()`
- `throw` : If `true`, then throws an error if `geoID` is not a valid `GeoRegion` identifier instead of returning the Boolean `tf`

Returns
=======
- `tf` : True / False
"""
function isID(
    ID :: AbstractString;
    path  :: AbstractString = homedir(),
    throw :: Bool = true
)

    IDvec,_,_,_ = listall(path)
    return isID(ID,IDvec;throw=throw,verbose=true)

end

function isID(
    ID    :: AbstractString,
    IDvec :: AbstractArray;
    throw   :: Bool = true,
    verbose :: Bool = false
)

    if verbose
        @info "$(modulelog()) - Checking to see if the ID $ID is in use"
    end

    if sum(IDvec.==ID) == 0
        if throw
            error("$(modulelog()) - $(ID) is not a valid GeoRegion identifier, use RectRegion(), TiltRegion() or PolyRegion() to add this GeoRegion to the list.")
        else
            @warn "$(modulelog()) - $(ID) is not a valid GeoRegion identifier, use RectRegion(), TiltRegion() or PolyRegion() to add this GeoRegion to the list."
            return false
        end
    else
        if verbose; @info "$(modulelog()) - The ID $ID is already in use" end
        return true
    end

end

function equalshape(geo1::GeoRegion, geo2::GeoRegion)

    lon1,lat1 = coordinates(geo1,n=2); pop!(lon1); pop!(lat1)
    lon2,lat2 = coordinates(geo2,n=2); pop!(lon2); pop!(lat2)
    
    lon1 = mod.(lon1,360); npnt1 = length(lon1)
    lon2 = mod.(lon2,360); npnt2 = length(lon2)

    isin = 0

    for ii = 1 : npnt1
        ipnt = Point(lon1[ii],lat1[ii])
        isin += inpolygon(ipnt,geo2.shape,in=1,on=0,out=1)
    end

    for ii = 1 : npnt2
        ipnt = Point(lon2[ii],lat2[ii])
        isin += inpolygon(ipnt,geo1.shape,in=1,on=0,out=1)
    end

    if !iszero(isin)
        return false
    else
        return true
    end

end