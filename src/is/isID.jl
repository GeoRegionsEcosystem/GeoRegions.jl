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