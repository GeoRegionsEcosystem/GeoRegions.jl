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