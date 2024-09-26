"""
    GeoRegion(
        geoID :: AbstractString;
        path  :: AbstractString = homedir()
    ) -> geo :: GeoRegion

Extracts information of the GeoRegion with the ID `geoID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========
- `geoID` : The ID that will be used to identify the GeoRegion.
            If the ID is not valid (i.e. not being used), then an error will be thrown.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`

Returns
=======
- `geo` : A GeoRegion
"""
function GeoRegion(
    geoID :: AbstractString,
    ST = String,
    FT = Float64;
    path  :: AbstractString = homedir(),
    verbose :: Bool = true
)

    if verbose
        @info "$(modulelog()) - Retrieving information for the GeoRegion defined by the ID $geoID"
    end

    rvec,fvec,tvec,dvec = listall(path); isID(geoID,rvec)
    ind = findall(geoID.==rvec)[1]
    return getgeoregion(geoID,joinpath(dvec[ind],fvec[ind]),tvec[ind],ST,FT)

end

"""
    RectRegion(
        ID    :: AbstractString,
        pID   :: AbstractString,
        name  :: AbstractString,
        bound :: Vector{<:Real};
        save :: Bool = false,
        path :: AbstractString = pwd(),
        verbose :: Bool = true,
        ST = String,
        FT = Float64
    ) -> geo :: RectRegion{ST,FT}

Creates a rectilinear GeoRegion.

Arguments
=========
- `ID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.
- `pID` : The ID of the parent GeoRegion where information can be extracted from
- `name` : A name for the GeoRegion (meta information, can be used in Logging)
- `bound` : The [N,S,E,W] coordinates defining the region

Keyword Arguments
=========
- `save` : If `true`, save the GeoRegion into the list of custom GeoRegions in the path specified by `path`.
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`

Returns
=======
- `geo` : A rectilinear GeoRegion
"""
function RectRegion(
    ID    :: AbstractString,
    pID   :: AbstractString,
    name  :: AbstractString,
    bound :: Vector{<:Real};
    save :: Bool = false,
    path :: AbstractString = homedir(),
    verbose :: Bool = true,
    ST = String,
    FT = Float64
)

    if !verbose
        disable_logging(Logging.Warn)
    end

    if save
        geofile = joinpath(path,"rectlist.txt")
        if !isfile(geofile)
            cp(joinpath(geodir,"rectlist.txt"),geofile)
        end
        if isID(ID,path=path,throw=false)
            error("$(modulelog()) - The GeoRegion $(ID) has already been defined.  Please use another identifier.")
        end
        lon,lat = rect2shape(N,S,E,W)
        if isgeoshape(lon,lat,path=path)
            oID = isgeoshape(lon,lat,path=path,returnID=true)
            error("$(modulelog()) - The GeoRegion $(oID) in $path has the same shape. Use it instead.")
        end
        if pID != "GLB"
            if !isID(pID,path=path,throw=false)
                error("$(modulelog()) - The GeoRegion $(pID) was defined to be the parent GeoRegion of $(ID), but the GeoRegion $(pID) is not defined.  Please define the GeoRegion $(pID) and its properties.")
            else
                pgeo = GeoRegion(pID,path=path); isinGeoRegion(geo,pgeo)
            end
        end
        @info "$(modulelog()) - Adding the GeoRegion $(ID) to the list."
    else
        path = homedir()
    end

    N,S,E,W = bound; is180,is360 = checkbounds(N,S,E,W)
    lon,lat = rect2shape(N,S,E,W)
    geo  = RectRegion{ST,FT}(
        ID, pID, name, joinpath(path,"rectlist.txt"),
        [N, S, E, W], Point2.(lon,lat), is180, is360
    )

    if save
        name = replace(name," "=>"-")
        open(geofile,"a") do io
            write(io,"$ID, $pID, $N, $W, $S, $E, $name\n")
        end
    end

    if !verbose
        disable_logging(Logging.Debug)
    end

    return geo

end

"""
    TiltRegion(
        ID   :: AbstractString,
        pID  :: AbstractString,
        name :: AbstractString,
        X    :: Real,
        Y    :: Real,
        ΔX   :: Real,
        ΔY   :: Real,
        θ    :: Real;
        save :: Bool = false,
        path :: AbstractString = pwd(),
        verbose :: Bool = true,
        ST = String,
        FT = Float64
    ) -> geo :: TiltRegion{ST,FT}

Creates a tilted rectangular GeoRegion.

Arguments
=========
- `ID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.
- `pID` : The ID of the parent GeoRegion where information can be extracted from
- `name` : A name for the GeoRegion (meta information, can be used in Logging)
- `X`  : Longitude coordinate of region centre
- `Y`  : Latitude coordinate of region centre
- `ΔX` : Half-width in longitude coordinates (before tilting)
- `ΔY` : Half-width in latitude coordinates (before tilting)
- `θ`  : Tilt of rectangular region in **degrees**

Keyword Arguments
=========
- `save` : If `true`, save the GeoRegion into the list of custom GeoRegions in the path specified by `path`.
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`
- `verbose` : Verbose logging for ease of monitoring? Default is `true`

Returns
=======
- `geo` : A tilted rectangular GeoRegion
"""
function TiltRegion(
    ID   :: AbstractString,
    pID  :: AbstractString,
    name :: AbstractString,
    X    :: Real,
    Y    :: Real,
    ΔX   :: Real,
    ΔY   :: Real,
    θ    :: Real;
    save :: Bool = false,
    path :: AbstractString = homedir(),
    verbose :: Bool = true,
    ST = String,
    FT = Float64
)

    if !verbose
        disable_logging(Logging.Warn)
    end

    if save
        geofile = joinpath(path,"tiltlist.txt")
        if !isfile(geofile)
            cp(joinpath(geodir,"tiltlist.txt"),geofile)
        end
        if isID(ID,path=path,throw=false)
            error("$(modulelog()) - The GeoRegion $(ID) has already been defined.  Please use another identifier.")
        end
        lon,lat = tilt2shape(X,Y,ΔX,ΔY,θ)
        if isgeoshape(lon,lat,path=path)
            oID = isgeoshape(lon,lat,path=path,returnID=true)
            error("$(modulelog()) - The GeoRegion $(oID) in $path has the same shape. Use it instead.")
        end
        if pID != "GLB"
            if !isID(pID,path=path,throw=false)
                error("$(modulelog()) - The GeoRegion $(pID) was defined to be the parent GeoRegion of $(ID), but the GeoRegion $(pID) is not defined.  Please define the GeoRegion $(pID) and its properties.")
            else
                pgeo = GeoRegion(pID,path=path); isinGeoRegion(geo,pgeo)
            end
        end
        @info "$(modulelog()) - Adding the GeoRegion $(ID) to the list."
    else
        path = homedir()
    end

    N,S,E,W = tilt2bounds(X,Y,ΔX,ΔY,θ); is180,is360 = checkbounds(N,S,E,W)
    lon,lat = tilt2shape(X,Y,ΔX,ΔY,θ)
    geo  = TiltRegion{ST,FT}(
        ID, pID, name, joinpath(path,"tiltlist.txt"),
        [N, S, E, W], Point2.(lon,lat), is180, is360,
        [X, Y, ΔX, ΔY, θ]
    )

    if save
        name = replace(name," "=>"-")
        open(geofile,"a") do io
            write(io,"$ID, $pID, $X, $Y, $ΔX, $ΔY, $θ, $name\n")
        end
    end

    if !verbose
        disable_logging(Logging.Debug)
    end

    return geo

end

"""
    PolyRegion(
        ID   :: AbstractString,
        pID  :: AbstractString,
        name :: AbstractString,
        lon  :: Vector{<:Real},
        lat  :: Vector{<:Real};
        join :: Bool = true,
        save :: Bool = false,
        path :: AbstractString = pwd(),
        verbose :: Bool = true,
        ST = String,
        FT = Float64
    ) -> geo :: PolyRegion{ST,FT}

Creates a polygonal GeoRegion.

Arguments
=========

- `ID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is already in use, then an error will be thrown.

- `pID` : The ID of the parent GeoRegion where information can be extracted from.
- `name` : A name for the GeoRegion (meta information, can be used in Logging).
- `lon` : A vector containing the longitude points.
- `lat` : A vector containing the latitude points.

Keyword Arguments
=========
- `join` : If `true`, if the first and last coordinate points do not match, append the first coordinate again to close the shape.
- `save` : If `true`, save the GeoRegion into the list of custom GeoRegions in the path specified by `path`.
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`
- `verbose` : If `true`, verbose logging for ease of monitoring.

Returns
=======
- `geo` : A polygonal GeoRegion
"""
function PolyRegion(
    ID   :: AbstractString,
    pID  :: AbstractString,
    name :: AbstractString,
    lon  :: Vector{<:Real},
    lat  :: Vector{<:Real};
    join :: Bool = true,
    save :: Bool = false,
    path :: AbstractString = homedir(),
    verbose :: Bool = true,
    ST = String,
    FT = Float64
)

    if !verbose
        disable_logging(Logging.Warn)
    end

    if (lon[1] != lon[end]) || (lat[1] != lat[end])
        if !join
            error("$(modulelog()) - The longitude/ latitude coordinates of the first and last points must be the same")
        else
            lon = vcat(lon,lon[1])
            lat = vcat(lat,lat[1])
        end
    end
    
    if save
        geofile = joinpath(path,"polylist.txt")
        if !isfile(geofile)
            cp(joinpath(geodir,"polylist.txt"),geofile)
        end
        if isID(ID,path=path,throw=false)
            error("$(modulelog()) - The GeoRegion $(ID) has already been defined.  Please use another identifier.")
        end
        if isgeoshape(lon,lat,path=path)
            oID = isgeoshape(lon,lat,path=path,returnID=true)
            error("$(modulelog()) - The GeoRegion $(oID) in $path has the same shape. Use it instead.")
        end
        if pID != "GLB"
            if !isID(pID,path=path)
                error("$(modulelog()) - The GeoRegion $(pID) was defined to be the parent GeoRegion of $(ID), but the GeoRegion $(pID) is not defined.  Please define the GeoRegion $(pID) and its properties.")
            else
                pgeo = GeoRegion(pID,path=path); isinGeoRegion(geo,pgeo)
            end
        end
        @info "$(modulelog()) - Adding the GeoRegion $(ID) to the list."
    else
        path = homedir()
    end

    N = maximum(lat); S = minimum(lat)
    E = maximum(lon); W = minimum(lon)
    is180,is360 = checkbounds(N,S,E,W)
    geo   = PolyRegion{ST,FT}(
        ID, pID, name, joinpath(path,"polylist.txt"),
        [N, S, E, W], Point2.(lon,lat), is180, is360
    )
    
    if save
        name = replace(name," "=>"-")
        npt  = length(lon)
        open(geofile,"a") do io
            write(io,"\n  RegID $(ID), $(pID), $name\n")
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

function checkbounds(
    N :: Real,
    S :: Real,
    E :: Real,
    W :: Real
)

    if (N>90) || (N<-90)
        error("$(modulelog()) - The latitude of the GeoRegion's northern bound at $N is not valid.")
    end

    if (S>90) || (S<-90)
        error("$(modulelog()) - The latitude of the GeoRegion's southern bound at $S is not valid.")
    end

    if (E>360) || (E<-180)
        error("$(modulelog()) - The longitude of the GeoRegion's eastern bound at $E is not valid.")
    end

    if (W>360) || (W<-180)
        error("$(modulelog()) - The longitude of the GeoRegion's western bound at $W is not valid.")
    end

    if (E - W) > 360
        error("$(modulelog()) - The GeoRegion cannot be more than 360º in Longitude.")
    end

    if E < W
        error("$(modulelog()) - The eastern bound of the GeoRegion cannot be west of the western bound.")
    end

    if N < S
        error("$(modulelog()) - The northern bound of the GeoRegion cannot be south of the southern bound.")
    end

    if E > 180; is360 = true; else is360 = false end
    if W < 0;   is180 = true; else is180 = false end
    if !(is180) && !(is360); is360 = true end

    return is180,is360

end

function tilt2bounds(
    X  :: Real,
    Y  :: Real,
    ΔX :: Real,
    ΔY :: Real,
    θ  :: Real
)

    lon,lat = tilt2shape(X,Y,ΔX,ΔY,θ)
    return maximum(lat), minimum(lat) , maximum(lon), minimum(lon)

end

function tilt2shape(
    X  :: Real,
    Y  :: Real,
    ΔX :: Real,
    ΔY :: Real,
    θ  :: Real
)

    lon1 = X - ΔX * cosd(θ) - ΔY * sind(θ); lat1 = Y + ΔY * cosd(θ) - ΔX * sind(θ)
    lon2 = X - ΔX * cosd(θ) + ΔY * sind(θ); lat2 = Y - ΔY * cosd(θ) - ΔX * sind(θ)
    lon3 = X + ΔX * cosd(θ) + ΔY * sind(θ); lat3 = Y - ΔY * cosd(θ) + ΔX * sind(θ)
    lon4 = X + ΔX * cosd(θ) - ΔY * sind(θ); lat4 = Y + ΔY * cosd(θ) + ΔX * sind(θ)

    return [lon1,lon2,lon3,lon4,lon1], [lat1,lat2,lat3,lat4,lat1]

end

function rect2shape(
    N :: Real,
    S :: Real,
    E :: Real,
    W :: Real
)

    return [W,E,E,W,W], [N,N,S,S,N]

end