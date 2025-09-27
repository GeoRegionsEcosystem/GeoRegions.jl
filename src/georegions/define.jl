"""
    GeoRegion(
        ID   :: AbstractString;
        path :: AbstractString = homedir(),
        verbose :: Bool = false
    ) -> geo :: GeoRegion

Extracts information of the GeoRegion with the ID `ID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========
- `ID` : The ID that will be used to identify the GeoRegion.
         If the ID is not valid (i.e. not being used), then an error will be thrown.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`.
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.

Returns
=======
- `geo` : A GeoRegion.
"""
function GeoRegion(
    ID   :: AbstractString;
    path :: AbstractString = homedir(),
    verbose :: Bool = false,
    ST = String,
    FT = Float64
)

    gpath = geopath(path)
    IDs,gpaths = listall(gpath,verbose); isIDinlist(ID,IDs,verbose=verbose)
    ind = findall(ID.==IDs)[1]
    fID = joinpath(gpaths[ind],"$ID.json")

    verbose ? (@info "$(modulelog()) - Retrieving information for the GeoRegion defined by the ID \"$ID\".") : nothing
    flush(stderr)

    geo = JSON3.read(read(fID,String))
    lon = FT.(geo.geometry.longitude)
    lat = FT.(geo.geometry.latitude)
    shape = Point.(lon,lat)
    polygon = Polygon(shape)
    N,S,E,W = checkbounds(lon,lat)
    return GeoRegion{ST,FT}(
        geo.ID, geo.pID, geo.name, fID, N, S, E, W, geo.rotation,
        Geometry{FT}(shape, centroid(polygon), polygon)
    )

end

"""
    GeoRegion(
        lon  :: Vector{<:Real},
        lat  :: Vector{<:Real};
        rotation :: Real = 0,
        ID   :: AbstractString = "",
        pID  :: AbstractString = "",
        name :: AbstractString = "",
        join :: Bool = true,
        save :: Bool = false,
        path :: AbstractString = homedir(),
        checkshape :: Bool = true,
        verbose    :: Bool = false,
        ST = String,
        FT = Float64
    ) -> geo :: GeoRegion{ST,FT}

Creates a GeoRegion.

Arguments
=========
- `lon` : A vector containing the longitude points.
- `lat` : A vector containing the latitude points.

Keyword Arguments
=========
- `ID` : The keyword ID that will be used to identify the GeoRegion.
         If the ID is already in use, then an error will be thrown.
- `pID` : The ID of the parent GeoRegion where information can be extracted from.
- `name` : A name for the GeoRegion (meta information, can be used in Logging).
- `rotation` : Rotation of GeoRegion from longitude/latitude in **degrees**.
- `join` : If `true`, if the first and last coordinate points do not match, append the first coordinate again to close the shape.
- `save` : If `true`, save the GeoRegion into the list of custom GeoRegions in the path specified by `path`.
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`.
- `checkshape` : If `true`, then run `isgeoshape()` to check if the same shape already exists in the current project and predefined lists. Default is true.
- `verbose` : If `true`, verbose logging for ease of monitoring. Default is `false`.

Returns
=======
- `geo` : A GeoRegion.
"""
function GeoRegion(
    lon  :: Vector{<:Real},
    lat  :: Vector{<:Real};
    rotation :: Real = 0,
    ID   :: AbstractString = "",
    pID  :: AbstractString = "",
    name :: AbstractString = "",
    join :: Bool = true,
    save :: Bool = false,
    path :: AbstractString = homedir(),
    checkshape :: Bool = true,
    verbose    :: Bool = false,
    ST = String,
    FT = Float64
)

    !verbose ? disable_logging(Logging.Warn) : nothing

    length(lon) !== length(lat) ? error("$(modulelog()) - The longitude and latitude vectors must be of the same length.") : nothing

    if (lon[1] != lon[end]) || (lat[1] != lat[end])
        if !join
            error("$(modulelog()) - The (longitude,latitude) coordinates of the first and last points must be the same.")
        else
            lon = vcat(lon,lon[1])
            lat = vcat(lat,lat[1])
        end
    end

    N,S,E,W = checkbounds(lon,lat)
    gpath = geopath(path)
    shape = Point.(lon,lat)
    polygon = Polygon(shape)
    
    if save

        ID == "" || pID == "" || name == "" ? error("$(modulelog()) - In order to save a GeoRegion, you must enter values for all the following keyword arguments: \"ID\", \"pID\" and \"name\".") : nothing

        isID(ID,path=gpath,throw=false) ? error("$(modulelog()) - The GeoRegion $(ID) has already been defined.  Please use another identifier.") : nothing

        if checkshape && isgeoshape(lon,lat,path=gpath)
            oID = isgeoshape(lon,lat,path=gpath,returnID=true)
            error("$(modulelog()) - The GeoRegion $(oID) in $path has the same shape, use it instead.")
        end

        if pID != "GLB"
            if !isID(pID,path=gpath)
                error("$(modulelog()) - The GeoRegion $(pID) was defined to be the parent GeoRegion of $(ID), but the GeoRegion $(pID) is not defined.  Please define the GeoRegion $(pID) and its properties.")
            else
                pgeo = GeoRegion(pID,path=gpath); in(GeoRegion(lon,lat),pgeo,throw=true)
            end
        end

        @info "$(modulelog()) - Adding the GeoRegion $(ID) to the list."
        !isdir(gpath) ? mkpath(gpath) : nothing
        open(joinpath(gpath,"$ID.json"), "w") do io
            JSON3.write(io,JSONRegion{ST,FT}(
                ID, pID, name, rotation, JSONGeometry{FT}(lon, lat)
            ))
        end

    else

        gpath = geopath(homedir())

    end

    !verbose ? disable_logging(Logging.Debug) : nothing

    return GeoRegion{ST,FT}(
        ID, pID, name, joinpath(gpath,"$ID.json"), N, S, E, W, rotation,
        Geometry{FT}(shape, centroid(polygon), polygon)
    )

end

function checkbounds(
    lon  :: Vector{<:Real},
    lat  :: Vector{<:Real}
)

    W = minimum(lon); E = maximum(lon)
    S = minimum(lat); N = maximum(lat)

    (N>90) || (N<-90) ? error("$(modulelog()) - The latitude of the GeoRegion's northern bound at $N is not valid.") : nothing

    (S>90) || (S<-90) ? error("$(modulelog()) - The latitude of the GeoRegion's southern bound at $S is not valid.") : nothing

    (E - W) > 360 ? error("$(modulelog()) - The GeoRegion cannot be more than 360º in Longitude.") : nothing

    while W < -180; lon .+= 360; E += 360; W += 360 end
    while E >  360; lon .-= 360; E -= 360; W -= 360 end

    E < W ? error("$(modulelog()) - The eastern bound of the GeoRegion cannot be west of the western bound.") : nothing

    N < S ? error("$(modulelog()) - The northern bound of the GeoRegion cannot be south of the southern bound.") : nothing

    return N, S, E, W

end