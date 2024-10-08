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

    if !isdir(path); mkpath(path) end
    for fname in ["rectlist.txt","polylist.txt","tiltlist.txt"]

        ftem = joinpath(geodir,fname)
        freg = joinpath(path,fname)

        if !overwrite
            if !isfile(freg)

                @debug "$(modulelog()) - Unable to find $freg, copying data from $ftem ..."

                open(freg,"w") do io
                    open(ftem) do f
                        for line in readlines(f)
                            write(io,"$line\n")
                        end
                    end
                end

            end
        else

            if isfile(freg)
                @warn "$(modulelog()) - Overwriting $freg with original file in $ftem ..."
                rm(freg,force=true)
            end

            open(freg,"w") do io
                open(ftem) do f
                    for line in readlines(f)
                        write(io,"$line\n")
                    end
                end
            end

        end

    end

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
function readGeoRegions(
    fname :: AbstractString
)

    @info "$(modulelog()) - Loading user-defined GeoRegions from the file $fname ..."

    rvec,rtype = listgeoregions(fname)
    ngeo = length(rvec)
    gvec = Vector{GeoRegion}(undef,ngeo)
    for igeo in 1 : ngeo
        reg = rvec[igeo]
        g = getgeoregion(reg,fname,rtype)
        gvec[igeo] = g
    end

    return gvec

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
    fname :: AbstractString;
    path  :: AbstractString = pwd(),
    overwrite :: Bool = false,
    verbose   :: Bool = false
)

    @info "$(modulelog()) - Importing user-defined GeoRegions from the file $fname directly into the custom lists."

    rvec,rtype = listgeoregions(fname)
    for reg in rvec
        if !isID(reg,path=path,throw=false,verbose=verbose)
            g = getgeoregion(reg,fname,rtype)
            add(g,path=path,verbose=verbose)
        elseif overwrite
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Overwriting and replacing with new boundaries ..."
            g = getgeoregion(reg,fname,rtype)
            overwrite(g,path=path,verbose=verbose)
        else
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Please use a different ID, or you can remove the ID using removeGeoRegion()."
        end
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


    @warn "$(modulelog()) - Removing custom GeoRegions.jl files from $path, all GeoRegion information saved into these files will be permanently lost."
    flist = ["rectlist.txt","polylist.txt","tiltlist.txt"]
    for fname in flist
        rm(joinpath(path,fname),force=true)
    end

    return nothing

end