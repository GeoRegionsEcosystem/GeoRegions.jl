"""
This set of functions queries if a given coordinate/grid is within a region defined either
by a set of region [N,S,E,W] bounds or by longitude/latitude vectors.

Other additional features include:
    * Transformation of longitude coordinates from [-180,180] to [0,360] and vice versa

"""

## Is Point in GeoRegion?

"""
    ispointinregion(plon, plat, rlon, rlat; throw=true) -> Bool

Check if a point with coordinates (`plon`,`plat`) is found within a region defined by the longitude and latitude vectors `rlon` and `rlat`

Arguments:
* `plon::Real` : Longitude of the point in question.
* `plat::Real` : Latitude of the point in question.
* `rlon::Vector{<:Real}` : Longitude vector spanning the region.  Points should be evenly spaced.
* `rlat::Vector{<:Real}` : Latitude vector spanning the region.  Points should be evenly spaced.

Keyword Arguments:
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function ispointinregion(
    plon::Real, plat::Real,
    rlon::Vector{<:Real}, rlat::Vector{<:Real};
    throw::Bool=true
)

    rW = mod(minimum(rlon),360); rS = minimum(rlat);
    rE = mod(maximum(rlon),360); rN = maximum(rlat);
    tlon = abs((rlon[2]-rlon[1])*3/4);
    tlat = abs((rlat[2]-rlat[1])*3/4);

    return checkpoint(plon,plat,rN,rS,rE,rW,tlon,tlat,throw)

end

"""
    ispointinregion(plon, plat, regionbounds; tlon=0, tlat=0, throw=true) -> Bool

Check if a point with coordinates (`plon`,`plat`) is found within a region defined by the bounds `regionbounds` in [`N`,`S`,`E`,`W`] format.

Arguments:
* `plon::Real` : Longitude of the point in question.
* `plat::Real` : Latitude of the point in question.
* `regionbounds::Vector{<:Real}` : Vector defining the [North,South,East,West] bounds of the region.

Keyword Arguments:
* `tlon::Real` : Threshold for longitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the longitude bounds
* `tlat::Real` : Threshold for latitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the latitude bounds
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function ispointinregion(
    plon::Real, plat::Real,
    regionbounds::Vector{<:Real};
    tlon::Real=0, tlat::Real=0,
    throw::Bool=true
)

    rN,rS,rE,rW = regionbounds; rW = mod(rW,360); rE = mod(rE,360);

    return checkpoint(plon,plat,rN,rS,rE,rW,tlon,tlat,throw)

end

"""
    ispointinregion(pcoord, rlon, rlat; throw=true) -> Bool

Check if a point with coordinates `pcoord = [plon,plat]` is found within a region defined by the longitude and latitude vectors `rlon` and `rlat`.

Arguments:
* `pcoord::Vector{<:Real}` : Vector defining coordinates of point in `[plon,plat]`
* `rlon::Vector{<:Real}` : Longitude vector spanning the region.  Points should be evenly spaced.
* `rlat::Vector{<:Real}` : Latitude vector spanning the region.  Points should be evenly spaced.

Keyword Arguments:
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function ispointinregion(
    pcoord::Vector{<:Real},
    rlon::Vector{<:Real}, rlat::Vector{<:Real};
    throw::Bool=true
)

    plon,plat = pcoord;
    rW = mod(minimum(rlon),360); rS = minimum(rlat);
    rE = mod(maximum(rlon),360); rN = maximum(rlat);
    tlon = abs((rlon[2]-rlon[1])*3/4);
    tlat = abs((rlat[2]-rlat[1])*3/4);

    return checkpoint(plon,plat,rN,rS,rE,rW,tlon,tlat,throw)

end

"""
    ispointinregion(pcoord, regionbounds; tlon=0, tlat=0, throw=true) -> Bool

Check if a point with coordinates `pcoord = [plon,plat]` is found within a region defined by the bounds `regionbounds` in [`N`,`S`,`E`,`W`] format.

Arguments:
* `pcoord::Vector{<:Real}` : Vector defining coordinates of point in `[plon,plat]`
* `regionbounds::Vector{<:Real}` : Vector defining the [North,South,East,West] bounds of the region.

Keyword Arguments:
* `tlon::Real` : Threshold for longitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the longitude bounds
* `tlat::Real` : Threshold for latitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the latitude bounds
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function ispointinregion(
    pcoord::Vector{<:Real},
    regionbounds::Vector{<:Real};
    tlon::Real=0, tlat::Real=0,
    throw::Bool=true
)

    plon,plat = pcoord; rN,rS,rE,rW = regionbounds;
    rW = mod(rW,360); rE = mod(rE,360);

    return checkpoint(plon,plat,rN,rS,rE,rW,tlon,tlat,throw)

end

"""
    checkpoint(plon, plat, rN, rS, rE, rW, tlon, tlat, throw) -> Bool

Check if a point with longitude and latitude coordinates `plon` and `plat` is found within a region defined by the bounds [`rN`,`rS`,`rE`,`rW`] format, with `tlon` and `tlat` being the threshold/margin of error for the longitude and latitude respectively.

Arguments:
* `plon::Real` : Longitude of the point in question.
* `plat::Real` : Latitude of the point in question.
* `rN::Real` : North bound of region
* `rS::Real` : South bound of region
* `rE::Real` : East bound of region
* `rW::Real` : West bound of region
* `tlon::Real` : Threshold for longitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the longitude bounds
* `tlat::Real` : Threshold for latitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the latitude bounds
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function checkpoint(
    plon::Real, plat::Real,
    rN::Real, rS::Real, rE::Real, rW::Real,
    tlon::Real, tlat::Real,
    throw::Bool
)

    if (rW < rE && (plon < (rW-tlon) || plon > (rE+tlon))) ||
        (rW > rE && (plon < (rW-tlon) && plon > (rE+tlon))) ||
        plat < (rS-tlat) || plat > (rN+tlat)

        if throw
             error("Requested coordinates [$(plon),$(plat)] are not within the specified region boundaries.")
        else return false
        end

    else; return true

    end

end


## Is Grid in GeoRegion?

"""
    isgridinregion(gridbounds, regionbounds; tlon=0, tlat=0, throw=true) -> Bool

Check if a grid defined by `gridbounds = [gN,gS,gE,gW]` is found within a predefined `GeoRegion`.

Arguments:
* `gridbounds::Vector{<:Real}` : Vector defining the [North,South,East,West] bounds of the grid in question.
* `regionbounds::Vector{<:Real}` : Vector defining the [North,South,East,West] bounds of the region.

Keyword Arguments:
* `tlon::Real` : Threshold for longitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the longitude bounds
* `tlat::Real` : Threshold for latitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the latitude bounds
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function isgridinregion(
    gridbounds::Vector{<:Real},
    regionbounds::Vector{<:Real};
    tlon::Real=0, tlat::Real=0,
    throw::Bool=true
)

    N,S,E,W = gridbounds; rN,rS,rE,rW = regionbounds;
    E = mod(E,360); rE = mod(rE,360); W = mod(W,360); rW = mod(rW,360);

    return checkgrid(N,S,E,W,rN,rS,rE,rW,tlon,tlat,throw)

end

"""
    isgridinregion(gridbounds, rlon, rlat; throw=true) -> Bool

Check if a grid defined by `gridbounds = [gN,gS,gE,gW]` is found within a predefined `GeoRegion`.

Arguments:
* `gridbounds::Vector{<:Real}` : Vector defining the [North,South,East,West] bounds of the grid in question.
* `rlon::Vector{<:Real}` : Longitude vector spanning the region.  Points should be evenly spaced.
* `rlat::Vector{<:Real}` : Latitude vector spanning the region.  Points should be evenly spaced.

Keyword Arguments:
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function isgridinregion(
    gridbounds::Vector{<:Real},
    rlon::Vector{<:Real},rlat::Vector{<:Real};
    throw::Bool=true
)

    N,S,E,W = gridbounds; E = mod(E,360); W = mod(W,360);
    rE = mod(maximum(rlon),360); rN = maximum(rlat);
    rW = mod(minimum(rlon),360); rS = minimum(rlat);
    tlon = abs((rlon[2]-rlon[1])*3/4);
    tlat = abs((rlat[2]-rlat[1])*3/4);

    return checkgrid(N,S,E,W,rN,rS,rE,rW,tlon,tlat,throw)

end

"""
    checkgrid(gN, gS, gE, gW, rN, rS, rE, rW, tlon, tlat, throw) -> Bool

Check if a grid with bounds [`gN`,`gS`,`gE`,`gW`] is found within a region defined by the bounds [`rN`,`rS`,`rE`,`rW`] format, with `tlon` and `tlat` being the threshold/margin of error for the longitude and latitude respectively.

Arguments:
* `gN::Real` : North bound of grid
* `gS::Real` : South bound of grid
* `gE::Real` : East bound of grid
* `gW::Real` : West bound of grid
* `rN::Real` : North bound of region
* `rS::Real` : South bound of region
* `rE::Real` : East bound of region
* `rW::Real` : West bound of region
* `tlon::Real` : Threshold for longitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the longitude bounds
* `tlat::Real` : Threshold for latitude bounds in °.  If set to 0, means that there is no leniency for the point to fall outside the latitude bounds
* `throw::Bool` : If `throw=true`, then if (`plon`,`plat`) is not within the region, an error is thrown and the program stops running.
"""
function checkgrid(
    gN::Real, gS::Real, gE::Real, gW::Real,
    rN::Real, rS::Real, rE::Real, rW::Real,
    tlon::Real, tlat::Real,
    throw::Bool
)

    if (rW < rE && (gE < (rW-tlon) || gE > (rE+tlon))) ||
        (rW > rE && (gE < (rW-tlon) && gE > (rE+tlon))) ||
        (rW < rE && (gW < (rW-tlon) || gW > (rE+tlon))) ||
        (rW > rE && (gW < (rW-tlon) && gW > (rE+tlon))) ||
        gN < (rS-tlat) || gN > (rN+tlat) ||
        gS < (rS-tlat) || gS > (rN+tlat)

        if throw
             error("Requested grid points [$(gridbounds)] are not within the specified region boundaries.")
        else return false
        end

    else; return true

    end

end

## Tranformation of Coordinates

from180to0360(lon::Real) = lon + 360
from0360to180(lon::Real) = lon - 360
