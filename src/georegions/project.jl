"""
    setupGeoRegions(;
        path :: AbstractString = pwd(),
        overwrite :: Bool = false
    ) -> nothing

Setup the directory specified by `path` with files for custom `GeoRegion`s. If `overwrite = true`, then any preexisting files are overwritten.

Keyword Arguments
=================
- `path` : The path where the template list of custom GeoRegions will be copied to.
           Defaults to the current working directory `pwd()`.
- `overwrite` : If template files exist in this folder, overwrite?
"""
function setupGeoRegions(;
    path :: AbstractString = pwd(),
    overwrite :: Bool = false
)

    gpath = geopath(path); !isdir(gpath) ? mkpath(path) : nothing
    overwrite ? deleteGeoRegions(path=gpath) : nothing
    return nothing

end

"""
    readGeoRegions(
        fname :: AbstractString
    ) -> gvec :: Vector{<:GeoRegion}

Extract information of GeoRegions from the file defined by `fname`.

Arguments
=========
- `fname` : String specifying name + path of the file containing GeoRegion information.

Returns
=======
- `gvec` : Vector containing all the GeoRegions in the file `fname`.
"""
function readGeoRegions(;
    ID   :: AbstractString = "",
    path :: AbstractString = pwd(),
)

    gpath = geopath(path)
    @info "$(modulelog()) - Loading user-defined GeoRegions from the directory $gpath ..."

    if ID == ""

        IDvec  = glob("*.json",gpath)
        nID    = length(IDvec)
        geovec = Vector{GeoRegion}(undef,nID)
        for iID in 1 : nID
            geovec[iID] = GeoRegion(ID,gpath)
        end
        
        return geovec

    else

        return GeoRegion(ID,path)

    end

end

"""
    addGeoRegions(
        fname :: AbstractString;
        path  :: AbstractString = pwd(),
        overwrite :: Bool = false,
        verbose   :: Bool = false
    ) -> nothing

Add GeoRegions from the file `fname` into the project directory defined by `path`.

Arguments
=========
- `fname` : name + path of the file containing GeoRegion information.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the current working directory `pwd()`.
- `overwrite` : If `true`, override any custom GeoRegions that have the same `ID`s as those in the file `fname`.
"""
function addGeoRegions(
    src :: AbstractString,
    dst :: AbstractString = pwd();
    overwrite :: Bool = false,
    verbose   :: Bool = false,
    dogeopath :: Bool = false
)

    gsrc = dogeopath ? geopath(src) : src; gdst = geopath(dst)

    verbose ? (@info "$(modulelog()) - Importing all user-defined GeoRegions from the folder $gsrc directly into the folder $gdst.") : nothing

    fgeo = basename.(glob("*.json",gsrc)); ngeo = length(fgeo)
    for igeo = 1 : ngeo
        cp(joinpath(gsrc,fgeo[igeo]),joinpath(gdst,fgeo[igeo]),force=overwrite)
    end

    return nothing

end

"""
    deleteGeoRegions(;
        path :: AbstractString = pwd()
    ) -> nothing

Reset all the files containing GeoRegion information back to the default.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the current working directory `pwd()`.
"""
function deleteGeoRegions(;
    path :: AbstractString = pwd()
)

    gpath = geopath(path)
    @warn "$(modulelog()) - Removing custom GeoRegions.jl files from $gpath, all GeoRegion information saved into these files will be permanently lost."
    flist = glob("*.json",gpath)
    for fname in flist
        rm(joinpath(gpath,fname),force=true)
    end

    return nothing

end