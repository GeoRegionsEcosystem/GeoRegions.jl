function isdefined(
    geo   :: GeoRegion;
    path  :: AbstractString = geodir,
    throw :: Bool = true
)

    if isGeoRegion(geo.ID,path=path,throw=throw)

        tgeo = GeoRegion(geo.ID,path=path)
        if tgeo !== geo
            if throw
                error("$(modulelog()) - The custom GeoRegion \"$(tgeo.ID)\" from the lists in $path does not have the same properties as the GeoRegion \"$(geo.ID)\" we have defined despite having the same ID.")
            else
                @warn "$(modulelog()) - The custom GeoRegion \"$(tgeo.ID)\" from the lists in $path does not have the same properties as the GeoRegion \"$(geo.ID)\" we have defined despite having the same ID."
                return false
            end
        else
            @info "$(modulelog()) - The GeoRegion \"$(geo.ID)\" we have defined shares the same properties as the custom GeoRegion \"$(tgeo.ID)\" from the lists in $path"
            return true
        end

    end

end

"""
    isGeoRegion(
        geoID :: AbstractString;
        path  :: AbstractString = geodir,
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
           Defaults to the `local` package variable `geodir`
- `throw` : If `true`, then throws an error if `geoID` is not a valid `GeoRegion` identifier instead of returning the Boolean `tf`

Returns
=======
- `tf` : True / False
"""
function isGeoRegion(
    geoID :: AbstractString;
    path  :: AbstractString = geodir,
    throw :: Bool=true
)

    rvec,_,_ = listall(path)
    return isgeoregion(geoID,rvec;throw=throw,dolog=true)

end

function isgeoregion(
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