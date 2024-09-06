"""
    GeoRegion(
        geoID :: AbstractString;
        path  :: AbstractString = geodir
    ) -> geo :: GeoRegion

Extracts information of the GeoRegion with the ID `geoID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========
- `geoID` : The ID that will be used to identify the GeoRegion.
            If the ID is not valid (i.e. not being used), then an error will be thrown.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`

Returns
=======
- `geo` : A GeoRegion
"""
function GeoRegion(
    geoID :: AbstractString,
    ST = String,
    FT = Float64;
    path  :: AbstractString = geodir,
)

    @info "$(modulelog()) - Retrieving information for the GeoRegion defined by the ID $geoID"

    regvec,filevec,typevec = listall(path); isID(geoID,regvec)
    ind = findall(geoID.==regvec)[1]
    return getgeoregion(geoID,joinpath(path,filevec[ind]),typevec[ind],ST,FT)

end

"""
    templateGeoRegions(;
        path :: AbstractString = pwd(),
        overwrite :: Bool = false
    ) -> nothing

Copies the template files for defining GeoRegions in textfiles, that can then be added as a batch using addGeoRegions()

Keyword Arguments
=================
- `path` : The folder to copy the files to
- `overwrite` : If template files exist in this folder, overwrite?
"""
function templateGeoRegions(;
    path :: AbstractString = pwd(),
    overwrite :: Bool = false
)

    if !isdir(path); mkpath(path) end
    for fname in ["recttemplate.txt","polytemplate.txt","tilttemplate.txt"]

        ftem = joinpath(@__DIR__,"..","..","extra",fname)
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

Extracts information of the GeoRegion with the ID `geoID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========
- `fname` : String specifying name + path of the file containing GeoRegion information

Returns
=======
- `gvec` : Vector containing all the GeoRegions in the file `fname`
"""
function readGeoRegions(
    fname :: AbstractString
)

    @info "$(modulelog()) - Loading user-defined GeoRegions from the file $fname"

    rvec,rtype = listgeoregions(fname)
    ngeo = length(rvec)
    gvec = Vector{GeoRegion}(undef,ngeo)
    for igeo in 1 : ngeo
        reg = rvec[igeo]
        if !isGeoRegion(reg,throw=false)
            g = getgeoregion(reg,fname,rtype)
            if     rtype == "PolyRegion"
                lon,lat = coordGeoRegion(g,n=1)
                geo = PolyRegion(g.ID,g.pID,g.name,lon,lat,save=false)
            elseif rtype == "TiltRegion"
                geo = TiltRegion(g.ID,g.pID,g.name,g.X,g.Y,g.ΔX,g.ΔY,g.θ,save=false)
            elseif rtype == "RectRegion"
                geo = RectRegion(g.ID,g.pID,g.name,[g.N,g.S,g.E,g.W],save=false)
            end
        else
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Please use a different ID, or you can remove the ID using removeGeoRegion()."
        end
        gvec[igeo] = geo
    end

    return gvec

end

"""
    addGeoRegions(
        fname :: AbstractString;
        path  :: AbstractString = geodir,
        overwrite :: Bool = false
    ) -> nothing

Extracts information of the GeoRegion with the ID `geoID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========
- `fname` : name + path of the file containing GeoRegion information

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `overwrite` : If `true`, override any custom GeoRegions that have the same `ID`s as those in the file `fname`
"""
function addGeoRegions(
    fname :: AbstractString;
    path  :: AbstractString = geodir,
    overwrite :: Bool = false
)

    @info "$(modulelog()) - Importing user-defined GeoRegions from the file $fname directly into the custom lists"

    rvec,rtype = listgeoregions(fname)
    for reg in rvec
        if !isGeoRegion(reg,throw=false)
            g = getgeoregion(reg,fname,rtype)
            addGeoRegion(g,path=path)
        elseif overwrite
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Overwriting and replacing with new boundaries ..."
            removeGeoRegion(reg)
            g = getgeoregion(reg,fname,rtype)
            addGeoRegion(g,path=path)
        else
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Please use a different ID, or you can remove the ID using removeGeoRegion()."
        end
    end

    return nothing

end

"""
    resetGeoRegions(;
        path :: AbstractString = geodir,
        all  :: Bool = false
    ) -> nothing

Reset all the files containing GeoRegion information back to the default.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `all` : If `true`, reset the GeoRegions defined in Giorgi & Francisco [2000], AR6 Regions (Iturbide et al., 2020; ESSD) and Seneviratne et al. [2012] as well.
          If `false`, only reset the custom GeoRegions.
"""
function resetGeoRegions(;
    path :: AbstractString = geodir,
    all  :: Bool = false
)


    @info "$(modulelog()) - Resetting the custom lists of GeoRegions back to the default"
    flist = ["rectlist.txt","polylist.txt","tiltlist.txt"]
    for fname in flist
        copygeoregions(fname,path,overwrite=true)
    end

    if all

        @info "$(modulelog()) - Resetting the predefined lists of GeoRegions back to the default"
        fdefined = ["giorgi.txt","srex.txt","ar6.txt"]
        for fname in fdefined
            copygeoregions(fname,geodir,overwrite=true)
        end

    end

    return

end

function copygeoregions(
    fname :: AbstractString,
    path  :: AbstractString;
    overwrite :: Bool=false
)

    ftem = joinpath(@__DIR__,"..","..","extra",fname)
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

    return

end