"""
    rm(
        geo  :: GeoRegion;
        path :: AbstractString = geodir
    )

Removes the GeoRegion `geo` from the custom lists specified in `path`. The GeoRegion must have exactly the same properties as the one in the custom list

Arguments
=========
- `geo` : The GeoRegion to be removed from the custom lists in `path`

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
"""
rm(
    geo   :: GeoRegion;
    path  :: AbstractString = dirname(geo.path)
) = if isGeoRegion(geo,path=path)
    rmID(geo.ID,path=path)
end

"""
    rmID(
        geoID :: AbstractString;
        path  :: AbstractString = geodir
    )

Removes any GeoRegion associated with the ID `geoID`. ID must be exact.

Arguments
=========
- `geoID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is not valid (i.e. not being used), then an error will be thrown.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the home directory `homedir()`
"""
function rmID(
    geoID :: AbstractString;
    path  :: AbstractString = homedir(),
)

    if geoID == "GLB"
        error("$(modulelog()) - The Global GeoRegion \"GLB\" is an integral part of the GeoRegions.jl package and cannot be removed.")
    else
        @info "$(modulelog()) - Removing the GeoRegion $(geoID) ..."
    end

    rvec,fvec,tvec,dvec = listall(path); isID(geoID,rvec)
    ind = findall(geoID.==rvec)[1]

    fdefined = ["global.txt","giorgi.txt","srex.txt","ar6.txt"]
    if !any(fvec[ind].==fdefined)
        geo = getgeoregion(geoID,joinpath(dvec[ind],fvec[ind]),tvec[ind])
        removegeoregion(geo,joinpath(dvec[ind],fvec[ind]))
    else
        error("$(modulelog()) - You are trying to remove the predefined GeoRegion \"$geoID\". If you really want to remove this GeoRegion, please do `force = true`")
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