"""
    removeGeoRegion(geoID::AbstractString)

Creates the GeoRegion associated with the ID `geoID`.

Arguments
=========

- `geoID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is not valid (i.e. not being used), then an error will be thrown.
"""
function removeGeoRegion(
    geoID :: AbstractString;
    path  :: AbstractString = geodir
)

    if geoID == "GLB"
        error("$(modulelog()) - The Global GeoRegion \"GLB\" is an integral part of the GeoRegions.jl package and cannot be removed.")
    else
        @info "$(modulelog()) - Removing the GeoRegion $(geoID) ..."
    end

    regvec,filevec,typevec = listGeoRegions(); isgeoregion(geoID,regvec)
    ind = findall(geoID.==regvec)[1]
    geo = getgeoregion(geoID,joinpath(path,filevec[ind]), typevec[ind])
    removegeoregion(geo,joinpath(path,filevec[ind]))

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