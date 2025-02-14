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

    gpath = geopath(path); !isdir(gpath) ? mkpath(gpath) : nothing
    overwrite ? deleteGeoRegions(path=gpath) : nothing
    return nothing

end

"""
    loadGeoRegions(;
        path :: AbstractString = pwd(),
        custom :: Bool = true,
        giorgi :: Bool = false,
        srex   :: Bool = false,
        ar6    :: Bool = false,
    ) -> gvec :: Vector{<:GeoRegion}

Extract information for all custom GeoRegions in the project defined by defined by `path`.

Arguments
=========
- `path` : Path where all custom GeoRegions for the project are saved into.
- `custom` : If `true`, custom, user-defined list of GeoRegions will be displayed.
- `giorgi` : If `true` AND `predefined = true`, display predefined GF GeoRegions. Default is `false`.
- `srex` : If `true` AND `predefined = true`, display predefined SREX GeoRegions. Default is `false`.
- `ar6` : If `true` AND `predefined = true`, display predefined IPCC AR6 GeoRegions. Default is `false`.

Returns
=======
- `gvec` : Vector containing all the GeoRegions in the directory defined by `path`.
"""
function loadGeoRegions(;
    path :: AbstractString = pwd(),
    custom :: Bool = true,
    giorgi :: Bool = false,
    srex   :: Bool = false,
    ar6    :: Bool = false,
)

    IDs    = []
    gpaths = []
    gpath  = geopath(path)

    IDs,gpaths = fillinfo(IDs,gpaths,geopredefined,warn)
    IDs,gpaths = custom ? fillinfo(IDs,gpaths,gpath,warn)   : (IDs,gpaths)
    IDs,gpaths = giorgi ? fillinfo(IDs,gpaths,gfdir,warn)   : (IDs,gpaths)
    IDs,gpaths = srex   ? fillinfo(IDs,gpaths,srexdir,warn) : (IDs,gpaths)
    IDs,gpaths = ar6    ? fillinfo(IDs,gpaths,ar6dir,warn)  : (IDs,gpaths)

    ngeo = length(IDs)
    geovec = Vector{GeoRegion}(undef,ngeo)
    for iID in 1 : nID
        geovec[iID] = GeoRegion(IDs[iID],gpaths[iID])
    end
    
    return geovec

end

"""
    addGeoRegions(
        src :: AbstractString,
        dst :: AbstractString = pwd();
        overwrite :: Bool = false,
        verbose   :: Bool = false,
        dogeopath :: Bool = true
    ) -> nothing

Copy all custom GeoRegions from the project directory defined by `src` into a new project directory defined by `dst`.

Arguments
=========
- `src` : The project path where the list of custom GeoRegions will be copied from.
- `dst` : The project path where the list of custom GeoRegions will be copied into.

Keyword Arguments
=================
- `overwrite` : If `true`, override any custom GeoRegions that have the same `ID`s as those in the file `fname`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.
- `dogeopath` : If `true`, then the appends `.georegions` to the end of `src` if it isn't already specified. Default is `true`
"""
function addGeoRegions(
    src :: AbstractString,
    dst :: AbstractString = pwd();
    overwrite :: Bool = false,
    verbose   :: Bool = false,
    dogeopath :: Bool = true
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
        path :: AbstractString = pwd(),
        recursive :: Bool = false,
    ) -> nothing

Reset all the files containing GeoRegion information back to the default. If `recursive = true`, delete the entire directory.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the current working directory `pwd()`.
- `recursive` : If true, then delete the hidden `.georegions` folder entirely.
"""
function deleteGeoRegions(;
    path :: AbstractString = pwd(),
    recursive :: Bool = false,
)

    gpath = geopath(path)
    @warn "$(modulelog()) - Removing custom GeoRegions.jl files from $gpath, all GeoRegion information saved into these files will be permanently lost."
    flist = glob("*.json",gpath)
    for fname in flist
        rm(joinpath(gpath,fname),force=true)
    end

    recursive ? rm(gpath,recursive=recursive) : nothing

    return nothing

end