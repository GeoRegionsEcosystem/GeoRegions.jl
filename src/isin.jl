"""
This set of functions queries if a given coordinate/grid is within a region defined either
by a set of region [N,S,E,W] bounds or by longitude/latitude vectors.

Other additional features include:
    * Transformation of longitude coordinates from [-180,180] to [0,360] and vice versa

"""

## Is Point in GeoRegion?

function ispointinregion(
    plon::Real, plat::Real,
    rlon::Vector{<:Real}, rlat::Vector{<:Real}
)

    rW = mod(minimum(rlon),360); rS = minimum(rlat);
    rE = mod(maximum(rlon),360); rN = maximum(rlat);
    tlon = abs((rlon[2]-rlon[1])/2); tlat = abs((rlat[2]-rlat[1])/2);

    if (rW < rE && (plon < (rW-tlon) || plon > (rE+tlon))) ||
        (rW > rE && (plon < (rE-tlon) && plon > (rW+tlon))) ||
        plat < (rS-tlat) || plat > (rN+tlat)

          error("Requested coordinates are not within the specified longitude and/or latitude.")

    end

end

function ispointinregion(plon::Real,plat::Real,regionbounds::Vector{<:Real})

    rN,rS,rE,rW = regionbounds; rW = mod(rW,360); rE = mod(rE,360);

    if (rW < rE && (plon < rW || plon > rE)) || (rW > rE && (plon < rE && plon > rW)) ||
        plat < S || plat > N

          error("Requested coordinates are not within the specified region boundaries.")
    end

end

function ispointinregion(pcoord::Vector{<:Real},rlon::Vector{<:Real},rlat::Vector{<:Real})

    plon,plat = pcoord;
    rW = mod(minimum(rlon),360); rS = minimum(rlat);
    rE = mod(maximum(rlon),360); rN = maximum(rlat);
    tlon = abs((rlon[2]-rlon[1])/2); tlat = abs((rlat[2]-rlat[1])/2);

    if (rW < rE && (plon < (rW-tlon) || plon > (rE+tlon))) ||
        (rW > rE && (plon < (rE-tlon) && plon > (rW+tlon))) ||
        plat < (rS-tlat) || plat > (rN+tlat)

          error("Requested coordinates are not within the specified longitude and/or latitude.")

    end

end

function ispointinregion(pcoord::Vector{<:Real},regionbounds::Vector{<:Real})

    plon,plat = pcoord; rN,rS,rE,rW = regionbounds;
    rW = mod(rW,360); rE = mod(rE,360);

    if (rW < rE && (plon < rW || plon > rE)) || (rW > rE && (plon < rE && plon > rW)) ||
        plat < S || plat > N

          error("Requested coordinates are not within the specified region boundaries.")

    end

end

## Is Grid in GeoRegion?

function isgridinregion(gridbounds::Vector{<:Real},regionbounds::Vector{<:Real})

    N,S,E,W = gridbounds; rN,rS,rE,rW = regionbounds;
    E = mod(E,360); rE = mod(rE,360); W = mod(W,360); rW = mod(rW,360);

    if (rW < rE && (E < rW || E > rE)) || (rW > rE && (E < rE && E > rW)) ||
        (rW < rE && (W < rW || W > rE)) || (rW > rE && (W < rE && W > rW)) ||
        N < rS || N > rN || S < rS || S > rN

          error("Requested grid points are not within the specified region boundaries.")

    end

end

function isgridinregion(
    gridbounds::Vector{<:Real},
    rlon::Vector{<:Real},rlat::Vector{<:Real}
)

    N,S,E,W = gridbounds; E = mod(E,360); W = mod(W,360);
    rE = mod(maximum(rlon),360); rN = maximum(rlat);
    rW = mod(minimum(rlon),360); rS = minimum(rlat);
    tlon = abs((rlon[2]-rlon[1])/2); tlat = abs((rlat[2]-rlat[1])/2);

    if (rW < rE && (E < (rW-tlon) || E > (rE+tlon))) ||
        (rW > rE && (E < (rE-tlon) && E > (rW+tlon))) ||
        (rW < rE && (W < (rW-tlon) || W > (rE+tlon))) ||
        (rW > rE && (W < (rE-tlon) && W > (rW+tlon))) ||
        N < (rS-tlat) || N > (rN+tlat) ||
        S < (rS-tlat) || S > (rN+tlat)

          error("Requested grid points are not within the specified longitude and/or latitude.")

    end

end

## Tranformation of Coordinates

from180to0360(lon::Real) = lon + 360
from0360to180(lon::Real) = lon - 360
