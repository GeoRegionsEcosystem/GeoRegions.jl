==(a::T, b::T) where T <: RectRegion =
    getfield.(Ref(a),fieldnames(T)) == getfield.(Ref(b),fieldnames(T))

==(a::T, b::T) where T <: PolyRegion =
    getfield.(Ref(a),fieldnames(T)) == getfield.(Ref(b),fieldnames(T))

==(a::T, b::T) where T <: TiltRegion =
    getfield.(Ref(a),fieldnames(T)) == getfield.(Ref(b),fieldnames(T))

function isGeoRegion(
    geo   :: GeoRegion;
    path  :: AbstractString = dirname(geo.path),
    throw :: Bool = true
)

    if isID(geo.ID,path=path,throw=throw)

        tgeo = GeoRegion(geo.ID,path=path)
        if tgeo == geo
            @info "$(modulelog) - The GeoRegion \"$(geo.ID)\" we have defined shares the same properties as the custom GeoRegion \"$(tgeo.ID)\" from the lists in $path"
            return true
        else
            if throw
                error("$(modulelog) - The custom GeoRegion \"$(tgeo.ID)\" from the lists in $path does not have the same properties as the GeoRegion \"$(geo.ID)\" we have defined despite having the same ID.")
            else
                @warn "$(modulelog) - The custom GeoRegion \"$(tgeo.ID)\" from the lists in $path does not have the same properties as the GeoRegion \"$(geo.ID)\" we have defined despite having the same ID."
                return false
            end
        end

    else

        return false

    end

end

"""
    isGeoRegion(
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

    rvec,_,_ = listall(path)
    return isID(geoID,rvec;throw=throw,dolog=true)

end

function isID(
    geoID  :: AbstractString,
    regvec :: AbstractArray;
    throw  :: Bool = true,
    dolog  :: Bool = false)

    if dolog
        @info "$(modulelog) - Checking to see if the ID $geoID is in use"
    end

    if sum(regvec.==geoID) == 0
        if throw
            error("$(modulelog) - $(geoID) is not a valid GeoRegion identifier, use RectRegion(), TiltRegion() or PolyRegion() to add this GeoRegion to the list.")
        else
            @warn "$(modulelog) - $(geoID) is not a valid GeoRegion identifier, use RectRegion(), TiltRegion() or PolyRegion() to add this GeoRegion to the list."
            return false
        end
    else
        if dolog; @info "$(modulelog) - The ID $geoID is already in use" end
        return true
    end

end