"""
    in(
        Point  :: Point2{<:Real},
        geo    :: GeoRegion;
        tlon   :: Real = 0,
        tlat   :: Real = 0,
        throw  :: Bool = false
    ) -> Bool

Check if a geographical point `point` is within a GeoRegion defined by `geo`.

Arguments
=========
- `Point` : A geographical point of Type `Point2`.  Pass `Point2(plon,plat)`, where `plon` and `plat` are the longitude and latitudes of the point.
- `geo`   : The GeoRegion struct container

Keyword Arguments
=================
- `tlon`  : Threshold for the longitude bound
- `tlat`  : Threshold for the latitude bound
- `throw` : If `true`, then if `Point` is not within `geo`, an error is thrown and the program stops running.
"""
Base.in(
    point :: Point2{<:Real},
    geo   :: GeoRegion;
    tlon   :: Real = 0,
    tlat   :: Real = 0,
    throw  :: Bool = false
) = isinGeoRegion(point,geo,tlon=tlon,tlat=tlat,throw=throw)

"""
    isinGeoRegion(
        Point  :: Point2{<:Real},
        geo    :: GeoRegion;
        tlon   :: Real = 0,
        tlat   :: Real = 0,
        throw  :: Bool = true
    ) -> Bool

Check if a geographical point `Point` is within a GeoRegion defined by `geo`.

Arguments
=========

- `Point` : A geographical point of Type `Point2`.  Pass `Point2(plon,plat)`, where `plon` and `plat` are the longitude and latitudes of the point.
- `geo`   : The GeoRegion struct container

Keyword Arguments
=================

- `tlon`  : Threshold for the longitude bound
- `tlat`  : Threshold for the latitude bound
- `throw` : If `true`, then if `Point` is not within `geo`, an error is thrown and the program stops running.
"""
function isinGeoRegion(
    Point  :: Point2{<:Real},
    GeoReg :: RectRegion;
    tlon   :: Real = 0,
    tlat   :: Real = 0,
    throw  :: Bool = true
)

    if throw
        @info "$(modulelog()) - Performing a check to determine if the coordinates $(Point) are within the specified region boundaries."
    end

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W

    plon = Point[1]; plon = mod(plon,360)
    plat = Point[2]

    is180 = GeoReg.is180
    is360 = GeoReg.is360

    isin = true

    if (plat < (S-tlat)) || (plat > (N+tlat))
        isin = false
    else
        if is360
            if !is180
                if (plon < (W-tlon)) || (plon > (E+tlon)); isin = false end
            else

                if (plon < (W-tlon)) || (plon > (E+tlon))
                    plon = plon - 360
                    if (plon < (W-tlon)) || (plon > (E+tlon))
                        isin = false
                    end
                end

            end
        else

            if plon > 180; plon = plon - 360 end
            if (plon < (W-tlon)) || (plon > (E+tlon))
                if (plon < (W-tlon)) || (plon > (E+tlon))
                    isin = false
                end
            end

        end
    end

    if !isin
        if throw
             error("$(modulelog()) - The requested coordinates $(Point2(plon,plat)) are not within the specified region boundaries.")
        else return false
        end
    else
        if throw
            @info "$(modulelog()) - The requested coordinates $(Point2(plon,plat)) are within the specified region boundaries."
        end
        return true
    end

end

function isinGeoRegion(
    Point  :: Point2{<:Real},
    GeoReg :: PolyRegion;
    tlon   :: Real = 0,
    tlat   :: Real = 0,
    throw  :: Bool = true
)

    if throw
        @info "$(modulelog()) - Performing a check to determine if the coordinates $(Point) are within the specified region boundaries."
    end

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W

    plon = Point[1]; plon = mod(plon,360)
    plat = Point[2]

    is180 = GeoReg.is180
    is360 = GeoReg.is360

    isin = true

    if (plat < (S-tlat)) || (plat > (N+tlat))
        isin = false
    else
        if is360
            if !is180
                if (plon < (W-tlon)) || (plon > (E+tlon)); isin = false end
            else

                if (plon < (W-tlon)) || (plon > (E+tlon))
                    plon = plon - 360
                    if (plon < (W-tlon)) || (plon > (E+tlon))
                        isin = false
                    end
                end

            end
        else

            if plon > 180; plon = plon - 360 end
            if (plon < (W-tlon)) || (plon > (E+tlon))
                if (plon < (W-tlon)) || (plon > (E+tlon))
                    isin = false
                end
            end

        end
    end

    if isin
        isin = inpolygon(Point2(plon,plat),GeoReg.shape,in=true,on=true,out=false)
    end

    if !isin
        if throw
            error("$(modulelog()) - The requested coordinates $(Point2(plon,plat)) are not within the specified region boundaries.")
        else
            return false
        end
    else
        if throw
            @info "$(modulelog()) - The requested coordinates $(Point2(plon,plat)) are within the specified region boundaries."
        end
        return true
    end


end