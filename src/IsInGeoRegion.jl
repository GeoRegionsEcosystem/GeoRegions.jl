"""
This set of functions queries if a given coordinate/grid is within a region defined either
by a set of region [N,S,E,W] bounds or by longitude/latitude vectors.

Other additional features include:
    * Transformation of longitude coordinates from [-180,180] to [0,360] and vice versa

"""

## Is Point in GeoRegion?

"""
    isPointinGeoRegion(plon, plat, rlon, rlat; throw=true) -> Bool

Check if a point with coordinates (`plon`,`plat`) is found within a region defined by the longitude and latitude vectors `rlon` and `rlat`

Arguments:
* `plon::Real` : Longitude of the point in question.
* `plat::Real` : Latitude of the point in question.
* `rlon::Vector{<:Real}` : Longitude vector spanning the region.  Points should be evenly spaced.
* `rlat::Vector{<:Real}` : Latitude vector spanning the region.  Points should be evenly spaced.

Keyword Arguments:
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function isPointinGeoRegion(
    Point  :: Point2{<:Real},
    GeoReg :: RectRegion;
    tlon   :: Real = 0,
    tlat   :: Real = 0,
    throw  :: Bool = true
)

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
             error("Requested coordinates $(Point2(plon,plat)) are not within the specified region boundaries.")
        else return false
        end
    else
        return true
    end


end

"""
    isPointinGeoRegion(plon, plat, rlon, rlat; throw=true) -> Bool

Check if a point with coordinates (`plon`,`plat`) is found within a region defined by the longitude and latitude vectors `rlon` and `rlat`

Arguments:
* `plon::Real` : Longitude of the point in question.
* `plat::Real` : Latitude of the point in question.
* `rlon::Vector{<:Real}` : Longitude vector spanning the region.  Points should be evenly spaced.
* `rlat::Vector{<:Real}` : Latitude vector spanning the region.  Points should be evenly spaced.

Keyword Arguments:
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function isPointinGeoRegion(
    Point  :: Point2{<:Real},
    GeoReg :: PolyRegion;
    tlon   :: Real = 0,
    tlat   :: Real = 0,
    throw  :: Bool = true
)

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W
    GeoShape = GeoReg.shape

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
             error("Requested coordinates $(Point2(plon,plat)) are not within the specified region boundaries.")
        else return false
        end
    else
        return true
    end


end
