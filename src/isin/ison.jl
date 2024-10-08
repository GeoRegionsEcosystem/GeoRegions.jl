"""
    on(
        point :: Point2{<:Real},
        geo   :: GeoRegion;
        throw :: Bool = false
    ) -> tf :: Bool

Check if a geographical point `point` is on the boundary of a shape of a GeoRegion defined by `geo`.

Arguments
=========
- `point` : A geographical point of Type `Point`.  Pass `Point(plon,plat)`, where `plon` and `plat` are the longitude and latitudes of the point.
- `geo`   : The GeoRegion struct container.

Keyword Arguments
=================
- `throw` : If `true`, then if `point` is not within `geo`, an error is thrown and the program stops running.

Returns
=======
- `tf` : A `true`/`false` boolean.
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
        touches(Point(plon    ,plat),geo.geometry),
        touches(Point(plon+360,plat),geo.geometry),
        touches(Point(plon-360,plat),geo.geometry)
    ]))

    if !isin
        if throw
            error("$(modulelog()) - The requested coordinates $(Point(plon,plat)) are not on the region perimeter.")
        else
            return false
        end
    else
        if throw
            @info "$(modulelog()) - The requested coordinates $(Point(plon,plat)) are on the region perimeter."
        end
        return true
    end


end

"""
    on(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion;
        n    :: Int = 2,
        throw   :: Bool = false,
        verbose :: Bool = false
    ) -> tf :: Bool

Check if the GeoRegions `geo1` and `geo2` have the same shape. The order of `geo1` and `geo2` does not matter.

Arguments
=========
- `geo1` : The first GeoRegion
- `geo2` : The second GeoRegion

Keyword Arguments
=================
- `n` : The number of segments to split each of the `GeoRegion`s into. Default is 2.
- `throw` : If `true`, then if `geo1` does not have the same shape as `geo2`, an error is thrown and the program stops running.
- `verbose` : If `true`, print logs to screen.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function on(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    n    :: Int = 2,
    throw   :: Bool = false,
    verbose :: Bool = false
)

    if verbose; @info "$(modulelog()) - Performing a check to determine if the $(geo1.name) GeoRegion  \"$(geo1.ID)\" shares the same shape as GeoRegion  \"$(geo2.ID)\"." end

    lon1,lat1 = coordinates(geo1,n=n)
    lon2,lat2 = coordinates(geo2,n=n)
    isin = sum(.!on.(Point.(lon1,lat1),[geo2])) + sum(.!on.(Point.(lon2,lat2),[geo1]))

    # @info lon1,lat1,Point.(lon1,lat1)

    if iszero(isin)

        if verbose; @info "$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion  \"$(geo1.ID)\" indeed shares the same shape as GeoRegion \"$(geo2.ID)\"." end
        return true
        
    else

        if throw
            error("$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion \"$(geo1.ID)\" does not share the same shape as GeoRegion  \"$(geo2.ID)\"")
        else
            if verbose; @warn "$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion \"$(geo1.ID)\" does not share the same shape as GeoRegion  \"$(geo2.ID)\"" end
            return false
        end

    end

end
