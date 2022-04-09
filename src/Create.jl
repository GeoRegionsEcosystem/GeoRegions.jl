"""
    RectRegion(
        RegID :: AbstractString,
        ParID :: AbstractString,
        name  :: AbstractString,
        bound :: Vector{<:Real},
        savegeo :: Bool = true,
        ST = String,
        FT = Float64
    ) -> RectRegion{ST,FT}

Creates a rectilinear GeoRegion `RegID`.

Arguments
=========

- `RegID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.

- `ParID` : The ID of the parent GeoRegion where information can be extracted from
- `name`  : A name for the GeoRegion (meta information, can be used in Logging)
- `bound` : The [N,S,E,W] coordinates defining the region
- `savegeo` : Save the GeoRegion into the master list?
"""
function RectRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    bound :: Vector{<:Real};
    savegeo :: Bool = true,
    ST = String,
    FT = Float64
)

    if isGeoRegion(RegID,throw=false)
        error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
    else
        @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
    end

    if !isGeoRegion(ParID,throw=false)
        error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
    end

    N,S,E,W = bound; is180,is360 = checkbounds(N,S,E,W)
    geo  = RectRegion{ST,FT}(RegID,ParID,name,N,S,E,W,is180,is360)
    par  = GeoRegion(ParID); isinGeoRegion(geo,par)
    name = replace(name," "=>"-")

    if savegeo
        open(joinpath(DEPOT_PATH[1],"files","GeoRegions","rectlist.txt"),"a") do io
            write(io,"$RegID, $ParID, $N, $W, $S, $E, $name\n")
        end
    end

    return geo

end

"""
    PolyRegion(
        RegID :: AbstractString,
        ParID :: AbstractString,
        name  :: AbstractString,
        lonpt :: Vector{<:Real},
        latpt :: Vector{<:Real};
        savegeo :: Bool = true,
        ST = String,
        FT = Float64
    ) -> PolyRegion{ST,FT}

Creates a rectilinear GeoRegion `RegID`.

Arguments
=========

- `RegID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.

- `ParID` : The ID of the parent GeoRegion where information can be extracted from
- `name`  : A name for the GeoRegion (meta information, can be used in Logging)
- `lonpt` : A vector containing the longitude points
- `latpt` : A vector containing the latitude points
- `savegeo` : Save the GeoRegion into the master list?

!!! info "Start and End Points"
    The 1st and last elements of `lonpt` and `latpt` must be equal.
"""
function PolyRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    lonpt :: Vector{<:Real},
    latpt :: Vector{<:Real},;
    savegeo :: Bool = true,
    ST = String,
    FT = Float64
)

    if isGeoRegion(RegID,throw=false)
        error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
    else
        @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
    end

    if !isGeoRegion(ParID)
        error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
    end

    if lonpt[1] != lonpt[end]
        error("$(modulelog()) - The first and last points of the vector of longitude coordinates must be the same")
    end

    if latpt[1] != latpt[end]
        error("$(modulelog()) - The first and last points of the vector of latitude coordinates must be the same")
    end

    N = maximum(latpt); S = minimum(latpt)
    E = maximum(lonpt); W = minimum(lonpt)
    is180,is360 = checkbounds(N,S,E,W)
    shape = Point2.(lonpt,latpt)
    geo   = PolyRegion{ST,FT}(RegID,ParID,name,N,S,E,W,shape,is180,is360)
    par   = GeoRegion(ParID); isinGeoRegion(geo,par)
    name  = replace(name," "=>"-")

    npt = length(lonpt)
    if savegeo
        open(joinpath(DEPOT_PATH[1],"files","GeoRegions","polylist.txt"),"a") do io
            write(io,"\n  RegID $(RegID), $(ParID), $name\n")
            write(io,"  RegX  $(lonpt[1])")
            for ipt = 2 : npt; write(io,", $(lonpt[ipt])") end
            write(io,"\n")
            write(io,"  RegY  $(latpt[1])")
            for ipt = 2 : npt; write(io,", $(latpt[ipt])") end
            write(io,"\n")
        end
    end

    return geo

end

"""
    removeGeoRegion(RegID::AbstractString)

Creates the GeoRegion associated with the ID `RegID`.

Arguments
=========

- `RegID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is not valid (i.e. not being used), then an error will be thrown.
"""
function removeGeoRegion(
    RegID :: AbstractString
)

    if RegID == "GLB"
        error("$(modulelog()) - The Global GeoRegion \"GLB\" is an integral part of the GeoRegions.jl package and cannot be removed.")
    else
        @info "$(modulelog()) - Removing the GeoRegion $(RegID) ..."
    end

    regvec,filevec,typevec = listGeoRegions(); isgeoregion(RegID,regvec)
    ind = findall(RegID.==regvec)[1]
    geo = getgeoregion(
        RegID,
        joinpath(DEPOT_PATH[1],"files","GeoRegions",filevec[ind]),
        typevec[ind]
    )
    removegeoregion(geo,filevec[ind])

end

function removegeoregion(
    geo  :: PolyRegion,
    fgeo :: AbstractString
)

    rvec = listpolyregions(joinpath(DEPOT_PATH[1],"files","GeoRegions",fgeo))
    ind  = findall(rvec.==geo.regID)[1]
    ind  = (ind) * 4 .+ (0:3)

    flines = readlines(joinpath(DEPOT_PATH[1],"files","GeoRegions",fgeo))
    nlines = length(flines)

    open("tmp.txt","w") do io
        for iline = 1 : nlines
            if !any(iline.==ind)
                write(io,"$(flines[iline])\n")
            end
        end
    end

    mv("tmp.txt",joinpath(DEPOT_PATH[1],"files","GeoRegions",fgeo),force=true)

    return nothing

end

function removegeoregion(
    geo  :: RectRegion,
    fgeo :: AbstractString
)

    flines = readlines(joinpath(DEPOT_PATH[1],"files","GeoRegions",fgeo))
    nlines = length(flines)

    open("tmp.txt","w") do io
        for iline = 1 : nlines
            if !occursin(geo.regID,flines[iline])
                write(io,"$(flines[iline])\n")
            end
        end
    end

    mv("tmp.txt",joinpath(DEPOT_PATH[1],"files","GeoRegions",fgeo),force=true)

    return nothing

end
