function RectRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    bound :: Vector{<:Real},
    ST = String,
    FT = Float64
)

    if isgeoregion(RegID,throw=false)
        error("$(now()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
    end

    if !isgeoregion(ParID)
        error("$(now()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
    end

    N,S,E,W = bound; is180,is360 = checkbounds(N,S,E,W)

    open(joinpath(DEPOT_PATH[1],"files","GeoRegions","rectlist.txt"),"a") do io
        write(io,"$RegID, $ParID, $N, $W, $S, $E, $name\n")
    end

    return RectRegion{ST,FT}(RegID,ParID,name,N,S,E,W,is180,is360)

end

function PolyRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    lonpt :: Vector{<:Real},
    latpt :: Vector{<:Real},
    ST = String,
    FT = Float64
)

    if isgeoregion(RegID,throw=false)
        error("$(now()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
    end

    if !isgeoregion(ParID)
        error("$(now()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
    end

    N = maximum(latpt); S = minimum(latpt)
    E = maximum(lonpt); W = minimum(lonpt)
    is180,is360 = checkbounds(N,S,E,W)
    shape = Point2.(lonpt,latpt)
    name  = replace(name," "=>"-")

    npt = length(lonpt)
    open(joinpath(DEPOT_PATH[1],"files","GeoRegions","polylist.txt"),"a") do io
        write(io,"\n  RegID $(RegID), $(ParID), $name\n")
        write(io,"  RegX  $(lonpt[1])")
        for ipt = 1 : npt; write(io,", $(lonpt[ipt])") end
        write(io,"\n")
        write(io,"  RegY  $(latpt[1])")
        for ipt = 1 : npt; write(io,", $(latpt[ipt])") end
        write(io,"\n")
    end

    return PolyRegion{ST,FT}(RegID,ParID,name,N,S,E,W,shape,is180,is360)

end

function removeGeoRegion(
    RegID :: AbstractString
)

    if RegID == "GLB"
        error("$(now()) - The Global GeoRegion \"GLB\" is an integral part of the GeoRegions.jl package and cannot be removed.")
    end

    regvec,filevec,typevec = listGeoRegions(); isgeoregion(RegID,regvec)
    ind = findall(RegID.==regvec)[1]
    geo = getgeoregion(RegID,filevec[ind],typevec[ind])
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

end
