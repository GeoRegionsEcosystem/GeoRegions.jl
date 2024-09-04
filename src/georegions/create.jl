"""
    RectRegion(
        RegID :: AbstractString,
        ParID :: AbstractString,
        name  :: AbstractString,
        bound :: Vector{<:Real};
        save :: Bool = true,
        path :: AbstractString = geodir,
        verbose :: Bool = true,
        ST = String,
        FT = Float64
    ) -> geo :: RectRegion{ST,FT}

Creates a rectilinear GeoRegion.

Arguments
=========
- `RegID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.
- `ParID` : The ID of the parent GeoRegion where information can be extracted from
- `name`  : A name for the GeoRegion (meta information, can be used in Logging)
- `bound` : The [N,S,E,W] coordinates defining the region

Keyword Arguments
=========
- `save` : If `true`, save the GeoRegion into the list of custom GeoRegions in the path specified by `path`.
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`

Returns
=======
- `geo` : A rectilinear GeoRegion
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

    if save
        if isGeoRegion(RegID,path=path,throw=false)
            error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
        else
            @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
        end
        if ParID != "GLB"
            if !isGeoRegion(ParID,path=path,throw=false)
                error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
            end
        end
    else
        path = geodir
    end

    N,S,E,W = bound; is180,is360 = checkbounds(N,S,E,W)
    geo  = RectRegion{ST,FT}(RegID,ParID,name,N,S,E,W,is180,is360)

    if save
        par  = GeoRegion(ParID,path=path); isinGeoRegion(geo,par)
        name = replace(name," "=>"-")
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
        path :: AbstractString = geodir,
        verbose :: Bool = true,
        ST = String,
        FT = Float64
    ) -> geo :: TiltRegion{ST,FT}

Creates a tilted rectangular GeoRegion.

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
- `save` : If `true`, save the GeoRegion into the list of custom GeoRegions in the path specified by `path`.
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`

Returns
=======
- `geo` : A tilted rectangular GeoRegion
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

    if save
        if isGeoRegion(RegID,path=path,throw=false)
            error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
        else
            @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
        end
        if ParID != "GLB"
            if !isGeoRegion(ParID,path=path,throw=false)
                error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
            end
        end
    else
        path = geodir
    end

    N,S,E,W = getTiltBounds(X,Y,ΔX,ΔY,θ); is180,is360 = checkbounds(N,S,E,W)
    geo  = TiltRegion{ST,FT}(RegID,ParID,name,X,Y,ΔX,ΔY,θ,N,S,E,W,is180,is360)

    if save
        par  = GeoRegion(ParID,path=path); isinGeoRegion(geo,par)
        name = replace(name," "=>"-")
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
        lon :: Vector{<:Real},
        lat :: Vector{<:Real};
        join :: Bool = true,
        save :: Bool = true,
        path :: AbstractString = geodir,
        verbose :: Bool = true,
        ST = String,
        FT = Float64
    ) -> geo :: PolyRegion{ST,FT}

Creates a polygonal GeoRegion.

Arguments
=========

- `RegID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.

- `ParID` : The ID of the parent GeoRegion where information can be extracted from.
- `name`  : A name for the GeoRegion (meta information, can be used in Logging).
- `lon` : A vector containing the longitude points.
- `lat` : A vector containing the latitude points.

Keyword Arguments
=========
- `join` : If `true`, if the first and last coordinate points do not match, append the first coordinate again to close the shape.
- `save` : If `true`, save the GeoRegion into the list of custom GeoRegions in the path specified by `path`.
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `verbose` : If `true`, verbose logging for ease of monitoring.

Returns
=======
- `geo` : A polygonal GeoRegion
"""
function PolyRegion(
    RegID :: AbstractString,
    ParID :: AbstractString,
    name  :: AbstractString,
    lon   :: Vector{<:Real},
    lat   :: Vector{<:Real};
    join :: Bool = true,
    save :: Bool = true,
    path :: AbstractString = geodir,
    verbose :: Bool = true,
    ST = String,
    FT = Float64
)

    if !verbose
        disable_logging(Logging.Warn)
    end
    
    if save
        if isGeoRegion(RegID,path=path,throw=false)
            error("$(modulelog()) - The GeoRegion $(RegID) has already been defined.  Please use another identifier.")
        else
            @info "$(modulelog()) - Adding the GeoRegion $(RegID) to the list."
        end
        if ParID != "GLB"
            if !isGeoRegion(ParID,path=path)
                error("$(modulelog()) - The GeoRegion $(ParID) was defined to be the parent GeoRegion of $(RegID), but the GeoRegion $(ParID) is not defined.  Please define the GeoRegion $(ParID) and its properties.")
            end
        end
    else
        path = geodir
    end

    if (lon[1] != lon[end]) || (lat[1] != lat[end])
        if !join
            error("$(modulelog()) - The longitude/ latitude coordinates of the first and last points must be the same")
        else
            lon = vcat(lon,lon[1])
            lat = vcat(lat,lat[1])
        end
    end

    N = maximum(lat); S = minimum(lat)
    E = maximum(lon); W = minimum(lon)
    is180,is360 = checkbounds(N,S,E,W)
    shape = Point2.(lon,lat)
    geo   = PolyRegion{ST,FT}(RegID,ParID,name,N,S,E,W,shape,is180,is360)
    
    if save
        par  = GeoRegion(ParID,path=path); isinGeoRegion(geo,par)
        name = replace(name," "=>"-")
        npt  = length(lon)
        geofile = joinpath(path,"polylist.txt")
        if !isfile(geofile)
            cp(joinpath(geodir,"polytemplate.txt"),geofile)
        end
        open(geofile,"a") do io
            write(io,"\n  RegID $(RegID), $(ParID), $name\n")
            write(io,"  RegX  $(lon[1])")
            for ipt = 2 : npt; write(io,", $(lon[ipt])") end
            write(io,"\n")
            write(io,"  RegY  $(lat[1])")
            for ipt = 2 : npt; write(io,", $(lat[ipt])") end
            write(io,"\n")
        end
    end

    if !verbose
        disable_logging(Logging.Debug)
    end

    return geo

end