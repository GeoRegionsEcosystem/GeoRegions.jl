"""
    rm(
        geo  :: GeoRegion;
        path :: AbstractString = geodir
    ) -> nothing

Removes the GeoRegion `geo` from the custom lists specified in `path`. The GeoRegion must have exactly the same properties as the one in the custom list.

Arguments
=========
- `geo` : The GeoRegion to be removed from the custom lists in `path`.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`.
"""
rm(
    geo  :: GeoRegion;
    path :: AbstractString = dirname(geo.path)
) = if isgeo(geo,path=path)
    rmID(geo.ID,path=path)
else
    if isID(geo.ID,path=path)
        error("$(modulelog()) - The GeoRegion in $path which has the ID \"$(geo.ID)\" does not have the same properties as our GeoRegion \"$(geo.ID)\" that we have defined, and thus cannot be removed.")
    else
        error("$(modulelog()) - There is no GeoRegion in $path which has the ID \"$(geo.ID)\".")
    end
end

"""
    rmID(
        ID :: AbstractString;
        path :: AbstractString = geodir
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
    end

    rvec,fvec,tvec,dvec = listall(path); isID(ID,rvec)
    ind = findall(ID.==rvec)[1]

    fdefined = ["global.txt","giorgi.txt","srex.txt","ar6.txt"]
    if !any(fvec[ind].==fdefined)
        geo = getgeoregion(ID,joinpath(dvec[ind],fvec[ind]),tvec[ind])
        removegeoregion(geo,joinpath(dvec[ind],fvec[ind]))
    else
        error("$(modulelog()) - You are trying to remove the predefined GeoRegion \"$ID\". If you really want to remove this GeoRegion, please do `force = true`")
    end

end

function removegeoregion(
    geo  :: PolyRegion,
    fgeo :: AbstractString
)

    rvec = listpolyregions(fgeo)
    ind  = findall(rvec.==geo.ID)[1]
    ind  = (ind) * 4 .+ (0:3)

    flines = readlines(fgeo)
    nlines = length(flines)

    open("tmp.txt","w") do io
        for iline = 1 : nlines
            if !any(iline.==ind)
                write(io,"$(flines[iline])\n")
            end
        end
    end

    mv("tmp.txt",fgeo,force=true)

    return nothing

end

function removegeoregion(
    geo  :: Union{RectRegion,TiltRegion},
    fgeo :: AbstractString
)

    flines = readlines(fgeo)
    nlines = length(flines)

    open("tmp.txt","w") do io
        for iline = 1 : nlines
            line = flines[iline]
            items = split(line,", ")
            if !(items[1] == geo.ID)
                write(io,"$(flines[iline])\n")
            end
        end
    end

    mv("tmp.txt",fgeo,force=true)

    return nothing

end