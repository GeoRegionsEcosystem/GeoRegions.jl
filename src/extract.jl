"""
This set of functions extracts data for a given point / within a defined grid from a region
defined either by a set of region [N,S,E,W] bounds or by longitude/latitude vectors.

Other functionalities include:
    * Returning information of grid longitude/latitude vectors (for grid extraction)

"""

## Find Index of given position in Region

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

## Extraction of Data

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
          gdata = regionextract(rdata,reginfo["lonlatindices"]);
    else; gdata = regionextract(rdata,reginfo["lonlatindices"]);
    end

    return gdata

end

function regionextractgrid(
    rdata::Array{<:Real},
    gridbounds::Vector{<:Real}, rlon::Vector{<:Real}, rlat::Vector{<:Real}
)

    nlon = length(rlon); ndim = ndims(rdata); igrid  = regiongrid(gridbounds,rlon,rlat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4];

    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    end

    if iW > iE; iWE = 1 : (iE + nlon + 1 - iW); rdata = circshift(rdata,1-iW);
          gdata = regionextract(rdata,[iWE,iNS],ndim)
    else; iWE = iW : iE;
          gdata = regionextract(rdata,[iWE,iNS],ndim)

    end

    return gdata

end

function regionextractgrid!(
    rdata::Array{<:Real},
    gridbounds::Vector{<:Real}, rlon::Vector{<:Real}, rlat::Vector{<:Real},
    tmp::Array{<:Real}
)

    nlon = length(rlon); ndim = ndims(rdata); igrid  = regiongrid(gridbounds,rlon,rlat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4];

    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    end

    if iW > iE; iWE = 1 : (iE + nlon + 1 - iW); circshift!(tmp,data,1-iW);
          gdata = regionextract(tmp,[iWE,iNS],ndim)
    else; iWE = iW : iE;
          gdata = regionextract(rdata,[iWE,iNS],ndim)

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
