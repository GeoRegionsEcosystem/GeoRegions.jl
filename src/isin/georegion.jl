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
- `rectG` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

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
    in(
        cgeo  :: GeoRegion,
        geo   :: Union{TiltRegion,PolyRegion};
        n     :: Int = 100,
        throw :: Bool = false
    ) -> Bool

Check if a child GeoRegion defined by `cgeo` is within a TiltRegion or PolyRegion `geo`.

Arguments
=========

- `cgeo` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `polyG`
- `geo` : A TiltRegion or PolyRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

Keyword Arguments
=================

- `n`  : Number of points per polygon side to test
- `throw` : If `true`, then if `cgeo` is not within `geo`, an error is thrown and the program stops running
"""
Base.in(
    cgeo  :: GeoRegion,
    geo   :: Union{TiltRegion,PolyRegion};
    n     :: Int = 100,
    throw :: Bool = false
) = isinGeoRegion(cgeo,geo,n=n,throw=throw)

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
- `rectG` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

Keyword Arguments
=================

- `throw`  : If `true`, then if `Child` is not within `rectG`, an error is thrown and the program stops running
"""
function isinGeoRegion(
    Child :: GeoRegion,
    rectG :: RectRegion;
    throw :: Bool = true,
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



"""
    isinGeoRegion(
        Child :: GeoRegion,
        tiltG :: TiltRegion;
        n     :: Int = 100,
        throw :: Bool = false
    ) -> Bool

Check if a child GeoRegion defined by `Child` is within a TiltRegion `tiltG`.

Arguments
=========

- `Child` : A GeoRegion that we postulate to be a "child", or a subset of the GeoRegion defined by `polyG`
- `tiltG` : A GeoRegion that we postulate to be a "parent", or containing the GeoRegion defined by `Child`

Keyword Arguments
=================

- `n`  : Number of points per polygon side to test
- `throw`  : If `true`, then if `Child` is not within `tiltG`, an error is thrown and the program stops running
"""
function isinGeoRegion(
    Child :: GeoRegion,
    tiltG :: TiltRegion;
    n     :: Int = 100,
    throw :: Bool = true,
)

    @info "$(modulelog()) - Performing a check to determine if the $(Child.name) GeoRegion ($(Child.ID)) is inside the $(tiltG.name) GeoRegion ($(tiltG.ID))"

    lon,lat = getTiltShape(tiltG)
    tgeo = PolyRegion("","GLB","",lon,lat,save=false,verbose=false)

    isinGeoRegion(Child,tgeo,n=n,throw=throw)

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

- `n`  : Number of points per polygon side to test
- `throw`  : If `true`, then if `Child` is not within `polyG`, an error is thrown and the program stops running
"""
function isinGeoRegion(
    Child :: GeoRegion,
    polyG :: PolyRegion;
    n     :: Int = 100,
    throw :: Bool = true,
)

    @info "$(modulelog()) - Performing a check to determine if the $(Child.name) GeoRegion ($(Child.ID)) is inside the $(polyG.name) GeoRegion ($(polyG.ID))"

    lon,lat = coordGeoRegion(Child,n=n)
    npts = length(lon)
    
    isin = 0

    for ipnt in 1 : npts
        if !in(Point2(lon[ipnt],lat[ipnt]),polyG)
            isin += 1
        end
    end

    if isin > 0

        if throw
            error("$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is not a subset of the GeoRegion $(polyG.ID) ($(polyG.name))")
        else
            @warn "$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is not a subset of the GeoRegion $(polyG.ID) ($(polyG.name))"
            return false
        end

    else
        @info "$(modulelog()) - The GeoRegion $(Child.ID) ($(Child.name)) is indeed a subset of the GeoRegion $(polyG.ID) ($(polyG.name))"
        return true
    end

end
