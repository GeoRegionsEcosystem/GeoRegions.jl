==(geo1::T, geo2::T) where T <: RectRegion =
    getfield.(Ref(geo1),fieldnames(T)) == getfield.(Ref(geo2),fieldnames(T))

==(geo1::T, geo2::T) where T <: PolyRegion =
    getfield.(Ref(geo1),fieldnames(T)) == getfield.(Ref(geo2),fieldnames(T))

==(geo1::T, geo2::T) where T <: TiltRegion =
    getfield.(Ref(geo1),fieldnames(T)) == getfield.(Ref(geo2),fieldnames(T))

function isgeo(
    geo   :: GeoRegion;
    path  :: AbstractString = dirname(geo.path),
    throw :: Bool = true
)

    if isID(geo.ID,path=path,throw=throw)

        tgeo = GeoRegion(geo.ID,path=path)
        if tgeo == geo
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

function isgeoshape(
    geo   :: GeoRegion;
    path  :: AbstractString = dirname(geo.path),
    returnID :: Bool = false
)

    IDvec,_,_,_ = listall(path); ngeo = length(IDvec)
    tf = zeros(Bool,ngeo)

    disable_logging(Logging.Warn)
    for igeo in 1 : ngeo
        tgeo = GeoRegion(IDvec[igeo],path=path)
        tf[igeo] = equalshape(geo,tgeo)
    end
    disable_logging(Logging.Debug)

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
    geoID :: AbstractString;
    path  :: AbstractString = homedir(),
    throw :: Bool=true
)

    rvec,_,_,_ = listall(path)
    return isID(geoID,rvec;throw=throw,dolog=true)

end

function isID(
    geoID  :: AbstractString,
    regvec :: AbstractArray;
    throw  :: Bool = true,
    dolog  :: Bool = false)

    if dolog
        @info "$(modulelog()) - Checking to see if the ID $geoID is in use"
    end

    if sum(regvec.==geoID) == 0
        if throw
            error("$(modulelog()) - $(geoID) is not a valid GeoRegion identifier, use RectRegion(), TiltRegion() or PolyRegion() to add this GeoRegion to the list.")
        else
            @warn "$(modulelog()) - $(geoID) is not a valid GeoRegion identifier, use RectRegion(), TiltRegion() or PolyRegion() to add this GeoRegion to the list."
            return false
        end
    else
        if dolog; @info "$(modulelog()) - The ID $geoID is already in use" end
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