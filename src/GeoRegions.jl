module GeoRegions

export
       regionpoint, regiongrid, regionisglobe, regiongridvec,
       ispointinregion, isgridinregion,
       regionextract, regionextractpoint, regionextractgrid, regionextractgrid!,
       from0360to180, from180to0360

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

# Find Index of given position in Region

function regionpoint(
    plon::Real, plat::Real,
    rlon::Vector{<:Real}, rlat::Vector{<:Real}
)

    plon = mod(plon,360); ispointinregion(plon,plat,rlon,rlat); rlon = mod.(rlon,360);
    ilon = argmin(abs.(rlon.-plon)); ilat = argmin(abs.(rlat.-plat));

    return [ilon,ilat]

end

function regiongrid(gridbounds::Vector{<:Real},rlon::Vector{<:Real},rlat::Vector{<:Real})

    N,S,E,W = gridbounds; isgridinregion(gridbounds,rlon,rlat)

    E = mod(E,360); W = mod(W,360); rlon = mod.(rlon,360);
    iN = argmin(abs.(rlat.-N)); iS = argmin(abs.(rlat.-S)); iW = argmin(abs.(rlon.-W));
    if E == W;
        if gridbounds[3] != gridbounds[4]
              if iW != 1; iE = iW - 1; else; iE = length(rlon); end
        else; iE = iW
        end
    else; iE = argmin(abs.(rlon.-E));
    end

    return [iN,iS,iE,iW]

end

function regiongridvec(gridbounds::Vector{<:Real},rlon::Vector{<:Real},rlat::Vector{<:Real})


    iN,iS,iE,iW = regiongrid(gridbounds,rlon,rlat);

    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    else;           iNS = iN;
    end

    if     iW < iE; iWE = iW : iE
    elseif iW > iE || (iW == iE && gridbounds[3] != gridbounds[4])
        iWE = 1 : (iE + length(rlon) + 1 - iW);
        rlon[1:(iW-1)] = rlon[1:(iW-1)] .+ 360; rlon = circshift(rlon,1-iW);
    else
        iWE = iW;
    end

    reginfo = Dict("gridindices"=>[iN,iS,iE,iW],"lonlatindices"=>[iWE,iNS]);

    glon = rlon[iWE]; while glon[end] > 360; glon = glon .- 360; end

    return glon,rlat[iNS],reginfo

end

# Tranformation of Coordinates

from180to0360(lon::Real) = lon + 360
from0360to180(lon::Real) = lon - 360

# Extraction of Data

function regionextract(data::Array{<:Real},coord::Array,ndim::Integer)

    nlon1 = length(coord[1]); nlon2 = size(data,1);
    nlat1 = length(coord[2]); nlat2 = size(data,2);
    nt = size(data)[3:end];

    if ndim == 2; data = data[coord[1],coord[2]];
    elseif ndim >= 3;
        data = reshape(data,nlon2,nlat2,:)
        data = data[coord[1],coord[2],:];
        data = reshape(data,Tuple(vcat(nlon1,nlat1,nt...)));
    end

    return data

end

function regionextract(data::Array{<:Real},coord::Array)

    nlon1 = length(coord[1]); nlon2 = size(data,1);
    nlat1 = length(coord[2]); nlat2 = size(data,2);
    nt = size(data)[3:end]; ndim = ndims(data);

    if ndim == 2; data = data[coord[1],coord[2]];
    elseif ndim >= 3;
        data = reshape(data,nlon2,nlat2,:);
        data = data[coord[1],coord[2],:];
        data = reshape(data,Tuple(vcat(nlon1,nlat1,nt...)));
    end

    return data

end

function regionextractpoint(
    rdata::Array{<:Real},
    plon::Real, plat::Real,
    rlon::Vector{<:Real}, rlat::Vector{<:Real}
)

    icoord = regionpoint(plon,plat,rlon,rlat); ndim = ndims(data)
    pdata = regionextract(rdata,icoord,ndim)

    return pdata

end

function regionextractgrid(
    rdata::Array{<:Real}, reginfo::Dict
)

    iW = reginfo["gridindices"][4]; iE = reginfo["gridindices"][3];

    if iW > iE; rdata = circshift(rdata,1-iW);
          gdata = regionextract(rdata,reginfo["IDvec"]);
    else; gdata = regionextract(rdata,reginfo["IDvec"]);
    end

    return gdata

end

function regionextractgrid(
    rdata::Array{<:Real},
    gridbounds::Vector{<:Real}, lon::Vector{<:Real}, rlat::Vector{<:Real}
)

    nlon = length(lon); ndim = ndims(data); igrid  = regiongrid(gridbounds,lon,rlat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4];

    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    end

    if iW > iE; iWE = 1 : (iE + nlon + 1 - iW); rdata = circshift(rdata,1-iW);
          gdata = regionextract(rdata,[iWE,iNS],ndim)
    else; gdata = regionextract(rdata,[iWE,iNS],ndim)

    end

    return gdata

end

function regionextractgrid!(
    rdata::Array{<:Real},
    gridbounds::Vector{<:Real}, lon::Vector{<:Real}, rlat::Vector{<:Real},
    tmp::Array{<:Real}
)

    nlon = length(lon); ndim = ndims(data); igrid  = regiongrid(gridbounds,lon,rlat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4];

    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    end

    if iW > iE; iWE = 1 : (iE + nlon + 1 - iW); circshift!(tmp,data,1-iW);
          gdata = regionextract(tmp,[iWE,iNS],ndim)
    else; gdata = regionextract(rdata,[iWE,iNS],ndim)

    end

    return gdata

end

function regionextractgrid!(
    rdata::Array{<:Real}, reginfo::Dict, tmp::Array{<:Real}
)

    iW = reginfo["gridindices"][4]; iE = reginfo["gridindices"][3];

    if iW > iE; circshift!(tmp,data,1-iW);
          gdata = regionextract(tmp,reginfo["lonlatindices"]);
    else; gdata = regionextract(rdata,reginfo["lonlatindices"]);
    end

    return gdata

end

end # module
