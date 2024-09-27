"""
    on(
        point  :: Point2{<:Real},
        geo    :: GeoRegion;
        throw  :: Bool = false
    ) -> Bool

Check if a geographical point `point` is on the boundary of a shape of a GeoRegion defined by `geo`.

Arguments
=========
- `point` : A geographical point of Type `Point2`.  Pass `Point2(plon,plat)`, where `plon` and `plat` are the longitude and latitudes of the point.
- `geo`   : The GeoRegion struct container

Keyword Arguments
=================
- `throw` : If `true`, then if `point` is not within `geo`, an error is thrown and the program stops running.
"""
function on(
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
        touches(Point2(plon    ,plat),geo.geometry),
        touches(Point2(plon+360,plat),geo.geometry),
        touches(Point2(plon-360,plat),geo.geometry)
    ]))

    if !isin
        if throw
            error("$(modulelog()) - The requested coordinates $(Point2(plon,plat)) are not on the region perimeter.")
        else
            return false
        end
    else
        if throw
            @info "$(modulelog()) - The requested coordinates $(Point2(plon,plat)) are on the region perimeter."
        end
        return true
    end


end

"""
    on(
        geo1  :: GeoRegion,
        geo2  :: GeoRegion;
        n     :: Int = 100,
        throw :: Bool = false
    ) -> Bool

Check if a child GeoRegion defined by `cgeo` is the same as a RectRegion `geo`.

Arguments
=========
- `cgeo` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `geo`
- `geo` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `cgeo`

Keyword Arguments
=================
- `throw`  : If `true`, then if `cgeo` is not within `geo`, an error is thrown and the program stops running
"""
function on(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    n    :: Int = 2,
    throw   :: Bool = false,
    verbose :: Bool = false
)

    if verbose; @info "$(modulelog()) - Performing a check to determine if the $(geo1.name) GeoRegion ($(geo1.ID)) shares the same shape as GeoRegion ($(geo2.ID))" end

    lon1,lat1 = coordinates(geo1,n=n)
    lon2,lat2 = coordinates(geo2,n=n)
    isin = sum(.!on.(Point2.(lon1,lat1),[geo2])) + sum(.!on.(Point2.(lon2,lat2),[geo1]))

    # @info lon1,lat1,Point2.(lon1,lat1)

    if iszero(isin)

        if verbose; @info "$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion ($(geo1.ID)) indeed shares the same shape as GeoRegion ($(geo2.ID))" end
        return true
        
    else

        if throw
            error("$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion ($(geo1.ID)) does not share the same shape as GeoRegion ($(geo2.ID))")
        else
            if verbose; @warn "$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion ($(geo1.ID)) does not share the same shape as GeoRegion ($(geo2.ID))" end
            return false
        end

    end

end
