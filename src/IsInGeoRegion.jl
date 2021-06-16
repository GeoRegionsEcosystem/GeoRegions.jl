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

"""
    isGeoRegioninGeoRegion(Child, GeoReg::PolyRegion; domask=false, throw=true) -> Bool

Check if a point with coordinates (`plon`,`plat`) is found within a region defined by the longitude and latitude vectors `rlon` and `rlat`

Arguments:
* `plon::Real` : Longitude of the point in question.
* `plat::Real` : Latitude of the point in question.
* `rlon::Vector{<:Real}` : Longitude vector spanning the region.  Points should be evenly spaced.
* `rlat::Vector{<:Real}` : Latitude vector spanning the region.  Points should be evenly spaced.

Keyword Arguments:
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function isGeoRegioninGeoRegion(
    Child  :: GeoRegion,
    GeoReg :: PolyRegion;
    domask :: Bool = false,
    throw  :: Bool = true
)

    N = Child.N
    S = Child.S
    E = Child.E
    W = Child.W

    lon = range(W,E,length=10001); nlon = length(lon)
    lat = range(S,N,length=10001); nlat = length(lat)

    mask = zeros(Bool,nlon,nlat)

    for ilat in 1 : nlat, ilon = 1 : nlon
        if isPointinGeoRegion(Point2(lon[ilon],lat[ilat]),Child,throw=false)
            if !isPointinGeoRegion(Point2(lon[ilon],lat[ilat]),GeoReg,throw=false)
                mask[ilon,ilat] = 1
            end
        end
    end

    if sum(mask) > 0

        if throw
            error("The GeoRegion $(Child.regID) ($(Child.name)) is not a subset of the GeoRegion $(GeoReg.regID) ($(GeoReg.name))")
        else
            if domask
                  return mask
            else; return false
            end
        end

    else; return true
    end

end

"""
    isGeoRegioninGeoRegion(Child, GeoReg::RectRegion; throw=true) -> Bool

Check if a point with coordinates (`plon`,`plat`) is found within a region defined by the longitude and latitude vectors `rlon` and `rlat`

Arguments:
* `plon::Real` : Longitude of the point in question.
* `plat::Real` : Latitude of the point in question.
* `rlon::Vector{<:Real}` : Longitude vector spanning the region.  Points should be evenly spaced.
* `rlat::Vector{<:Real}` : Latitude vector spanning the region.  Points should be evenly spaced.

Keyword Arguments:
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function isGeoRegioninGeoRegion(
    Child  :: GeoRegion,
    GeoReg :: RectRegion;
    throw  :: Bool = true
)

    isin = isgridinregion(
        [Child.N,Child.S,Child.E,Child,W],
        [GeoReg.N,GeoReg.S,GeoReg.E,GeoReg,W],
        throw=false
    )

    if isin

        if throw
            error("The GeoRegion $(Child.regID) ($(Child.name)) is not a subset of the GeoRegion $(GeoReg.regID) ($(GeoReg.name))")
        else
            return false
        end

    else; return true
    end

end
