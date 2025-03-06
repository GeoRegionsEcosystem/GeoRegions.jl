"""
    rm(
        geo  :: GeoRegion;
        path :: AbstractString = dirname(geo.path)
    ) -> nothing

Removes the GeoRegion `geo` from the custom lists specified in `path`. The GeoRegion must have exactly the same properties as the one in the custom list.

Arguments
=========
- `geo` : The GeoRegion to be removed from the custom lists in `path`.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `dirname(geo.path)`.
"""
rm(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path)
) = if isgeo(geo,path=geopath(path))
    rmID(geo.ID,path=geopath(path))
else
    if isID(geo.ID,path=geopath(path))
        error("$(modulelog()) - The GeoRegion in $(geopath(path)) which has the ID \"$(geo.ID)\" does not have the same properties as our GeoRegion \"$(geo.ID)\" that we have defined, and thus cannot be removed.")
    else
        error("$(modulelog()) - There is no GeoRegion in $(geopath(path)) which has the ID \"$(geo.ID)\".")
    end
end

"""
    rmID(
        ID :: AbstractString;
        path :: AbstractString = dirname(geo.path)
    ) -> nothing

Removes any GeoRegion associated with the ID `ID`. ID must be exact.

Arguments
=========
- `ID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is not valid (i.e. not being used), then an error will be thrown.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the home directory `homedir()`.
"""
function rmID(
    ID :: AbstractString;
    path :: AbstractString = homedir(),
)

    if ID == "GLB"
        error("$(modulelog()) - The Global GeoRegion \"GLB\" is an integral part of the GeoRegions.jl package and cannot be removed.")
    else
        @info "$(modulelog()) - Removing the GeoRegion $(ID) ..."
        flush(stderr)
    end

    fgeo = joinpath(geopath(path),"$ID.json")
    if isfile(fgeo); rm(fgeo,force=true) end

end