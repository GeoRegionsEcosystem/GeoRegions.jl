"""
This set of functions queries if a given coordinate/grid is within a region defined either
by a set of region [N,S,E,W] bounds or by longitude/latitude vectors.

Other additional features include:
    * Transformation of longitude coordinates from [-180,180] to [0,360] and vice versa

"""

"""
    in(
        Point  :: Point2{<:Real},
        geo    :: GeoRegion;
        tlon   :: Real = 0,
        tlat   :: Real = 0,
        throw  :: Bool = false
    ) -> Bool

Check if a geographical point `point` is within a GeoRegion defined by `geo`.
"""
Base.in(
    point :: Point2{<:Real},
    geo   :: GeoRegion;
    tlon   :: Real = 0,
    tlat   :: Real = 0,
    throw  :: Bool = false
) = isinGeoRegion(point,geo,tlon=tlon,tlat=tlat,throw=throw)

"""
    in(
        Child  :: GeoRegion,
        polyG  :: PolyRegion;
        domask :: Bool = false,
        throw  :: Bool = false
    ) -> Bool

Check if a child GeoRegion defined by `Child` is within a PolyRegion `polyG`.

Arguments
=========

- `Child` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `polyG`
- `polyG` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

Keyword Arguments
=================

- `throw`  : If `true`, then if `Child` is not within `polyG`, an error is thrown and the program stops running
- `domask` : If `throw` is `false` and `domask` is `true`, return a mask (with bounds defined by the `Child` GeoRegion) showing the region where `Child` and `polyG` do not overlap
"""
Base.in(
    Child  :: GeoRegion,
    polyG  :: PolyRegion;
    domask :: Bool = false,
    throw  :: Bool = false
) = isinGeoRegion(Child,polyG,domask=domask,throw=throw)

"""
    in(
        Child  :: GeoRegion,
        rectG  :: RectRegion;
        throw  :: Bool = false
    ) -> Bool

Check if a child GeoRegion defined by `Child` is within a RectRegion `rectG`.

Arguments
=========

- `Child` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `polyG`
- `polyG` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

Keyword Arguments
=================

- `throw`  : If `true`, then if `Child` is not within `polyG`, an error is thrown and the program stops running
"""
Base.in(
    Child :: GeoRegion,
    rectG :: RectRegion;
    throw :: Bool = false
) = isinGeoRegion(Child,rectG,throw=throw)

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

"""
    isinGeoRegion(
        Child  :: GeoRegion,
        polyG  :: PolyRegion;
        domask :: Bool = false,
        throw  :: Bool = true
    ) -> Bool

Check if a child GeoRegion defined by `Child` is within a PolyRegion `polyG`.

Arguments
=========

- `Child` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `polyG`
- `polyG` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

Keyword Arguments
=================

- `throw`  : If `true`, then if `Child` is not within `polyG`, an error is thrown and the program stops running
- `domask` : If `throw` is `false` and `domask` is `true`, return a mask (with bounds defined by the `Child` GeoRegion) showing the region where `Child` and `polyG` do not overlap
"""
function isinGeoRegion(
    Child  :: GeoRegion,
    polyG  :: PolyRegion;
    domask :: Bool = false,
    throw  :: Bool = true
)

    @info "$(modulelog()) - Performing a check to determine if the $(Child.name) GeoRegion ($(Child.ID)) is inside the $(polyG.name) GeoRegion ($(polyG.ID))"

    N = Child.N
    S = Child.S
    E = Child.E
    W = Child.W

    lon = range(W,E,length=10001); nlon = length(lon)
    lat = range(S,N,length=10001); nlat = length(lat)

    mask = zeros(Bool,nlon,nlat)

    for ilat in 1 : nlat, ilon = 1 : nlon
        if isinGeoRegion(Point2(lon[ilon],lat[ilat]),Child,throw=false)
            if !isinGeoRegion(Point2(lon[ilon],lat[ilat]),polyG,throw=false)
                mask[ilon,ilat] = 1
            end
        end
    end

    if sum(mask) > 0

        if throw
            error("$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is not a subset of the GeoRegion $(polyG.ID) ($(polyG.name))")
        else
            if domask
                @warn "$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is not a subset of the GeoRegion $(polyG.ID) ($(polyG.name)), returning a mask to show which regions do not intersect"
                return mask
            else
                @warn "$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is not a subset of the GeoRegion $(polyG.ID) ($(polyG.name))"
                return false
            end
        end

    else
        @info "$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is indeed a subset of the GeoRegion $(polyG.ID) ($(polyG.name))"
        return true
    end

end

"""
    isinGeoRegion(
        Child  :: GeoRegion,
        rectG  :: RectRegion;
        throw  :: Bool = true
    ) -> Bool

Check if a child GeoRegion defined by `Child` is within a RectRegion `rectG`.

Arguments
=========

- `Child` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `polyG`
- `polyG` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

Keyword Arguments
=================

- `throw`  : If `true`, then if `Child` is not within `polyG`, an error is thrown and the program stops running
"""
function isinGeoRegion(
    Child :: GeoRegion,
    rectG :: RectRegion;
    throw :: Bool = true
)

    @info "$(modulelog()) - Performing a check to determine if the $(Child.name) GeoRegion ($(Child.ID)) is inside the $(rectG.name) GeoRegion ($(rectG.ID))"

    isin = isgridinregion(
        [Child.N,Child.S,Child.E,Child.W],
        [rectG.N,rectG.S,rectG.E,rectG.W],
        throw=false
    )

    if !isin

        if throw
            error("$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is not a subset of the GeoRegion $(rectG.ID) ($(rectG.name))")
        else
            @warn "$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is not a subset of the GeoRegion $(rectG.ID) ($(rectG.name))"
            return false
        end

    else
        @info "$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is indeed a subset of the GeoRegion $(rectG.ID) ($(rectG.name))"
        return true
    end

end
