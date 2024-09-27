"""
    in(
        point  :: Point2{<:Real},
        geo    :: GeoRegion;
        throw  :: Bool = false
    ) -> Bool

Check if a geographical point `point` is within a GeoRegion defined by `geo`.

Arguments
=========
- `point` : A geographical point of Type `Point`.  Pass `Point(plon,plat)`, where `plon` and `plat` are the longitude and latitudes of the point.
- `geo`   : The GeoRegion struct container

Keyword Arguments
=================
- `throw` : If `true`, then if `point` is not within `geo`, an error is thrown and the program stops running.
"""
function Base.in(
    point :: Point2{<:Real},
    geo   :: GeoRegion;
    throw :: Bool = false
)

    if throw
        @info "$(modulelog()) - Performing a check to determine if the coordinates $(point) are within the specified region boundaries."
    end
    
    plon = point[1]
    plat = point[2]

    while plon > 360;  plon -= 360 end
    while plon < -180; plon += 360 end

    isin = !iszero(sum([
        within(Point(plon    ,plat),geo.geometry),
        within(Point(plon+360,plat),geo.geometry),
        within(Point(plon-360,plat),geo.geometry)
    ]))

    if !isin
        if throw
            error("$(modulelog()) - The requested coordinates $(Point(plon,plat)) are not within the specified region boundaries.")
        else
            return false
        end
    else
        if throw
            @info "$(modulelog()) - The requested coordinates $(Point(plon,plat)) are within the specified region boundaries."
        end
        return true
    end


end

"""
    in(
        cgeo  :: GeoRegion,
        geo   :: GeoRegion;
        n     :: Int = 100,
        throw :: Bool = false
    ) -> Bool

Check if a child GeoRegion defined by `cgeo` is within a RectRegion `geo`.

Arguments
=========
- `cgeo` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `geo`
- `geo` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `cgeo`

Keyword Arguments
=================
- `throw`  : If `true`, then if `cgeo` is not within `geo`, an error is thrown and the program stops running
"""
function Base.in(
    cgeo :: GeoRegion,
    geo  :: GeoRegion;
    n    :: Int = 100,
    throw   :: Bool = false,
    verbose :: Bool = false
)

    if verbose; @info "$(modulelog()) - Performing a check to determine if the $(cgeo.name) GeoRegion ($(cgeo.ID)) is inside the $(geo.name) GeoRegion ($(geo.ID))" end

    lon,lat = coordinates(cgeo,n=n)
    isin = sum(.!in.(Point.(lon,lat),[geo],n=n));

    if iszero(isin)

        if verbose; @info "$(modulelog()) - The GeoRegion $(cgeo.ID) ($(cgeo.name)) is indeed a subset of the GeoRegion $(geo.ID) ($(geo.name))" end
        return true
        
    else

        if throw
            error("$(modulelog()) - The GeoRegion $(cgeo.ID) ($(cgeo.name)) is not a subset of the GeoRegion $(geo.ID) ($(geo.name))")
        else
            if verbose; @warn "$(modulelog()) - The GeoRegion $(cgeo.ID) ($(cgeo.name)) is not a subset of the GeoRegion $(geo.ID) ($(geo.name))" end
            return false
        end

    end

end
