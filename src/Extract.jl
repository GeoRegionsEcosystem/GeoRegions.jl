function RegionGrid(
    geo :: RectRegion{ST,FT},
    lon    :: Vector{<:Real},
    lat    :: Vector{<:Real}
) where {FT <: Real, ST <: AbstractString}

    @debug "$(Dates.now()) - Determining indices of longitude and latitude boundaries in the given dataset ..."
    N = geo.N
    S = geo.S
    E = geo.E
    W = geo.W

    igrid = regiongrid([N,S,E,W],lon,lat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4]

    @debug "$(Dates.now()) - Creating vector of latitude indices to extract ..."
    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    else;           iNS = iN;
    end

    @debug "$(Dates.now()) - Creating vector of longitude indices to extract ..."
    if     iW < iE; iWE = vcat(iW:iE)
    elseif iW > iE || (iW == iE && bounds[3] != bounds[4])
          iWE = vcat(iW:length(lon),1:iE); lon[1:(iW-1)] .+= 360
    else; iWE = [iW];
    end

    while lon[end] > 360; lon .-= 360 end
    nlon = lon[iWE]
    nlat = lat[iNS]

    return RectGrid{FT}(igrid,iWE,iNS,nlon,nlat)

end

function RegionGrid(
    geo :: PolyRegion{ST,FT},
    lon    :: Vector{<:Real},
    lat    :: Vector{<:Real}
) where {FT <: Real, ST <: AbstractString}

    @debug "$(Dates.now()) - Determining indices of longitude and latitude boundaries in the given dataset ..."
    N = geo.N
    S = geo.S
    E = geo.E
    W = geo.W

    igrid = regiongrid([N,S,E,W],lon,lat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4]

    @debug "$(Dates.now()) - Creating vector of latitude indices to extract ..."
    if     iN < iS; iNS = vcat(iN:iS)
    elseif iS < iN; iNS = vcat(iS:iN)
    else;           iNS = [iN];
    end

    @debug "$(Dates.now()) - Creating vector of longitude indices to extract ..."
    if     iW < iE; iWE = vcat(iW:iE)
    elseif iW > iE || (iW == iE && bounds[3] != bounds[4])
          iWE = vcat(iW:length(lon),1:iE); lon[1:(iW-1)] .+= 360
    else; iWE = [iW];
    end

    while lon[end] > 360; lon .-= 360 end

    nlon = lon[iWE]
    nlat = lat[iNS]
    mask = Array{Bool,2}(undef,length(nlon),length(nlat))
    for ilat = 1 : length(nlat), ilon = 1 : length(nlon)
        ipnt = Point2(nlon[ilon],nlat[ilat])
        mask[ilon,ilat] = isPointingeoion(ipnt,geo,throw=false) * 1
    end

    return PolyGrid{FT}(igrid,iWE,iNS,nlon,nlat,mask)

end

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

function regioninfo(gridbounds::Vector{<:Real},rlon::Vector{<:Real},rlat::Vector{<:Real})

    iN,iS,iE,iW = regiongrid(gridbounds,rlon,rlat);
    nlon = deepcopy(rlon)

    if     iN < iS; iNS = vcat(iN:iS)
    elseif iS < iN; iNS = vcat(iS:iN)
    else;           iNS = [iN];
    end

    if     iW < iE; iWE = vcat(iW:iE)
    elseif iW > iE || (iW == iE && bounds[3] != bounds[4])
          iWE = vcat(iW:length(lon),1:iE); lon[1:(iW-1)] .+= 360
    else; iWE = [iW];
    end

    while lon[end] > 360; lon .-= 360 end
    nlon = lon[iWE]
    nlat = lat[iNS]

    return RectGrid{FT}(igrid,iWE,iNS,nlon,nlat)

end
