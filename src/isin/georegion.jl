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
        if in(Point2(lon[ilon],lat[ilat]),Child)
            if in(Point2(lon[ilon],lat[ilat]),polyG)
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
