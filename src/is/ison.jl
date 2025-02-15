"""
    on(
        point :: Point2{<:Real},
        geo   :: GeoRegion;
        throw :: Bool = false,
        sigdigits :: Int = 10
    ) -> tf :: Bool

Check if a geographical point `point` is on the boundary of a shape of a GeoRegion defined by `geo`.

Arguments
=========
- `point` : A geographical point of Type `Point`.  Pass `Point(plon,plat)`, where `plon` and `plat` are the longitude and latitudes of the point.
- `geo`   : The GeoRegion struct container.

Keyword Arguments
=================
- `throw` : If `true`, then if `point` is not within `geo`, an error is thrown and the program stops running.
- `sigdigits` : Specifies number of significant digits (i.e., precision) of the point coordinates used for checking. Defaults to 10.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function on(
    point :: Point2{<:Real},
    geo   :: GeoRegion;
    throw :: Bool = false,
    sigdigits :: Int = 10
)

    throw ? (@info "$(modulelog()) - Performing a check to determine if the coordinates $(point) are within the specified region boundaries.") : nothing

    plon = point[1]
    plat = round(point[2],sigdigits=sigdigits)

    while plon > 360;  plon -= 360 end
    while plon < -180; plon += 360 end

    plon1 = round(plon,sigdigits=sigdigits)
    plon2 = round(plon-360,sigdigits=sigdigits)
    plon3 = round(plon+360,sigdigits=sigdigits)

    isin = !iszero(sum([
        touches(Point(plon1,plat),geo.geometry.polygon),
        touches(Point(plon2,plat),geo.geometry.polygon),
        touches(Point(plon3,plat),geo.geometry.polygon)
    ]))

    if !isin
        throw ? error("$(modulelog()) - The requested coordinates $(Point(plon,plat)) are not on the region perimeter.") : return false
    else
        throw ? (@info "$(modulelog()) - The requested coordinates $(Point(plon,plat)) are on the region perimeter.") : nothing
        return true
    end


end

"""
    on(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion;
        n    :: Int = 2,
        throw   :: Bool = false,
        verbose :: Bool = false,
        sigdigits :: Int = 10
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
- `sigdigits` : Specifies number of significant digits (i.e., precision) of the point coordinates used for checking. Defaults to 10.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function on(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    n    :: Int = 2,
    throw   :: Bool = false,
    verbose :: Bool = false,
    sigdigits :: Int = 10
)

    verbose ? (@info "$(modulelog()) - Performing a check to determine if the $(geo1.name) GeoRegion  \"$(geo1.ID)\" shares the same shape as GeoRegion  \"$(geo2.ID)\".") : nothing

    lon1,lat1 = coordinates(geo1,n=n)
    lon2,lat2 = coordinates(geo2,n=n)
    
    tlon1 = round.(lon1,sigdigits=sigdigits); tlat1 = round.(lat1,sigdigits=sigdigits)
    tlon2 = round.(lon2,sigdigits=sigdigits); tlat2 = round.(lat2,sigdigits=sigdigits)
    tgeo1 = GeoRegion(tlon1,tlat1)
    tgeo2 = GeoRegion(tlon2,tlat2)

    isin = sum(.!on.(Point.(lon1,lat1),[tgeo2],sigdigits=sigdigits)) + 
           sum(.!on.(Point.(lon2,lat2),[tgeo1],sigdigits=sigdigits))

    if iszero(isin)

        if verbose; @info "$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion  \"$(geo1.ID)\" indeed shares the same shape as GeoRegion \"$(geo2.ID)\"." end
        return true
        
    else

        if throw
            error("$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion \"$(geo1.ID)\" does not share the same shape as GeoRegion  \"$(geo2.ID)\"")
        else
            verbose ? (@warn "$(modulelog()) - The GeoRegion $(geo1.name) GeoRegion \"$(geo1.ID)\" does not share the same shape as GeoRegion  \"$(geo2.ID)\"") : nothing
            return false
        end

    end

end
