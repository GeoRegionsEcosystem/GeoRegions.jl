"""
    RectRegion(
        RegID :: AbstractString,
        ParID :: AbstractString,
        name  :: AbstractString,
        bound :: Vector{<:Real};
        save :: Bool = true,
        path :: AbstractString = "",
        verbose :: Bool = true,
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

Keyword Arguments
=========
- `save` : Save the GeoRegion into the master list? Default is `true`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`
"""
function RectRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    bound :: Vector{<:Real};
    save :: Bool = true,
    path :: AbstractString = geodir,
    verbose :: Bool = true,
    ST = String,
    FT = Float64
)

    if !verbose
        disable_logging(Logging.Warn)
    end

    if isGeoRegion(RegID,throw=false)
        error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
    else
        @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
    end

    if ParID != "GLB"
        if !isGeoRegion(ParID,throw=false)
            error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
        end
    end

    N,S,E,W = bound; is180,is360 = checkbounds(N,S,E,W)
    geo  = RectRegion{ST,FT}(RegID,ParID,name,N,S,E,W,is180,is360)
    par  = GeoRegion(ParID,path=path); isinGeoRegion(geo,par)
    name = replace(name," "=>"-")

    if save
        geofile = joinpath(path,"rectlist.txt")
        if !isfile(geofile)
            cp(joinpath(geodir,"recttemplate.txt"),geofile)
        end
        open(geofile,"a") do io
            write(io,"$RegID, $ParID, $N, $W, $S, $E, $name\n")
        end
    end

    if !verbose
        disable_logging(Logging.Debug)
    end

    return geo

end

"""
    TiltRegion(
        RegID :: AbstractString,
        ParID :: AbstractString,
        name  :: AbstractString,
        X     :: Real,
        Y     :: Real,
        ΔX    :: Real,
        ΔY    :: Real,
        θ     :: Real;
        save :: Bool = true,
        path :: AbstractString = "",
        verbose :: Bool = true,
        ST = String,
        FT = Float64
    ) -> TiltRegion{ST,FT}

Creates a tilted rectangular GeoRegion `RegID`.

Arguments
=========
- `RegID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.
- `ParID` : The ID of the parent GeoRegion where information can be extracted from
- `name`  : A name for the GeoRegion (meta information, can be used in Logging)
- `X`  : Longitude coordinate of region centre
- `Y`  : Latitude coordinate of region centre
- `ΔX` : Half-width in longitude coordinates (before tilting)
- `ΔY` : Half-width in latitude coordinates (before tilting)
- `θ`  : Tilt of rectangular region in **degrees**

Keyword Arguments
=========
- `save` : Save the GeoRegion into the master list? Default is `true`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`
"""
function TiltRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    X     :: Real,
    Y     :: Real,
    ΔX    :: Real,
    ΔY    :: Real,
    θ     :: Real;
    save :: Bool = true,
    path :: AbstractString = geodir,
    verbose :: Bool = true,
    ST = String,
    FT = Float64
)

    if !verbose
        disable_logging(Logging.Warn)
    end

    if isGeoRegion(RegID,throw=false)
        error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
    else
        @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
    end

    if ParID != "GLB"
        if !isGeoRegion(ParID,throw=false)
            error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
        end
    end

    N,S,E,W = getTiltBounds(X,Y,ΔX,ΔY,θ); is180,is360 = checkbounds(N,S,E,W)
    geo  = TiltRegion{ST,FT}(RegID,ParID,name,X,Y,ΔX,ΔY,θ,N,S,E,W,is180,is360)
    par  = GeoRegion(ParID,path=path); isinGeoRegion(geo,par)
    name = replace(name," "=>"-")

    if save
        geofile = joinpath(path,"tiltlist.txt")
        if !isfile(geofile)
            cp(joinpath(geodir,"tilttemplate.txt"),geofile)
        end
        open(geofile,"a") do io
            write(io,"$RegID, $ParID, $X, $Y, $ΔX, $ΔY, $θ, $name\n")
        end
    end

    if !verbose
        disable_logging(Logging.Debug)
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
        save :: Bool = true,
        path :: AbstractString = "",
        verbose :: Bool = true,
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

Keyword Arguments
=========
- `save` : Save the GeoRegion into the master list? Default is `true`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`

!!! info "Start and End Points"
    The 1st and last elements of `lonpt` and `latpt` must be equal.
"""
function PolyRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    lonpt :: Vector{<:Real},
    latpt :: Vector{<:Real},;
    save :: Bool = true,
    path :: AbstractString = geodir,
    verbose :: Bool = true,
    ST = String,
    FT = Float64
)

    if !verbose
        disable_logging(Logging.Warn)
    end
    
    if isGeoRegion(RegID,throw=false)
        error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
    else
        @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
    end

    if ParID != "GLB"
        if !isGeoRegion(ParID)
            error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
        end
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
    par   = GeoRegion(ParID,path=path); isinGeoRegion(geo,par)
    name  = replace(name," "=>"-")

    npt = length(lonpt)
    if save
        geofile = joinpath(path,"polylist.txt")
        if !isfile(geofile)
            cp(joinpath(geodir,"polytemplate.txt"),geofile)
        end
        open(geofile,"a") do io
            write(io,"\n  RegID $(RegID), $(ParID), $name\n")
            write(io,"  RegX  $(lonpt[1])")
            for ipt = 2 : npt; write(io,", $(lonpt[ipt])") end
            write(io,"\n")
            write(io,"  RegY  $(latpt[1])")
            for ipt = 2 : npt; write(io,", $(latpt[ipt])") end
            write(io,"\n")
        end
    end

    if !verbose
        disable_logging(Logging.Debug)
    end

    return geo

end