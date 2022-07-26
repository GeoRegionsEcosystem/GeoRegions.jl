"""
    RegionGrid(
        geo :: GeoRegion,
        lon :: Vector{<:Real},
        lat :: Vector{<:Real}
    ) -> RegionGrid

Creates a `RegionGrid` type based on the following arguments.

Arguments
=========

- `geo` : A RectRegion struct type
- `lon` : A vector containing the longitude points
- `lat` : A vector containing the latitude points
"""
function RegionGrid(
    geo :: GeoRegion,
    lon :: Vector{<:Real},
    lat :: Vector{<:Real}
)

    if typeof(geo) <: RectRegion
          return RectGrid(geo,lon,lat)
    else; return PolyGrid(geo,lon,lat)
    end

end

function RectGrid(
    geo :: RectRegion{ST,FT},
    lon :: Vector{<:Real},
    lat :: Vector{<:Real}
) where {FT <: Real, ST <: AbstractString}

    @info "$(modulelog()) - Creating a RegionGrid for the $(geo.name) GeoRegion"

    @debug "$(modulelog()) - Determining indices of longitude and latitude boundaries in the given dataset ..."
    N = geo.N
    S = geo.S
    E = geo.E
    W = geo.W

    igrid = regiongrid([N,S,E,W],lon,lat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4]
    nlon = deepcopy(lon)

    @info "$(modulelog()) - Creating vector of latitude indices to extract ..."
    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    else;           iNS = iN;
    end

    @info "$(modulelog()) - Creating vector of longitude indices to extract ..."
    if     iW < iE; iWE = vcat(iW:iE)
    elseif iW > iE || (iW == iE && bounds[3] != bounds[4])
          iWE = vcat(iW:length(lon),1:iE); nlon[1:(iW-1)] .+= 360
    else; iWE = [iW];
    end

    while maximum(nlon) > 360; nlon .-= 360 end
    nlon = nlon[iWE]
    nlat =  lat[iNS]

    return RectGrid{FT}(igrid,iWE,iNS,nlon,nlat)

end

function PolyGrid(
    geo :: PolyRegion{ST,FT},
    lon :: Vector{<:Real},
    lat :: Vector{<:Real}
) where {FT <: Real, ST <: AbstractString}

    @info "$(modulelog()) - Creating a RegionGrid for the $(geo.name) GeoRegion"

    @debug "$(modulelog()) - Determining indices of longitude and latitude boundaries in the given dataset ..."
    N = geo.N
    S = geo.S
    E = geo.E
    W = geo.W

    igrid = regiongrid([N,S,E,W],lon,lat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4]
    nlon = deepcopy(lon)

    @info "$(modulelog()) - Creating vector of latitude indices to extract ..."
    if     iN < iS; iNS = vcat(iN:iS)
    elseif iS < iN; iNS = vcat(iS:iN)
    else;           iNS = [iN];
    end

    @info "$(modulelog()) - Creating vector of longitude indices to extract ..."
    if     iW < iE; iWE = vcat(iW:iE)
    elseif iW > iE || (iW == iE && bounds[3] != bounds[4])
          iWE = vcat(iW:length(lon),1:iE); nlon[1:(iW-1)] .+= 360
    else; iWE = [iW];
    end

    while maximum(nlon) > 360; nlon .-= 360 end

    @info "$(modulelog()) - Since the $(geo.name) GeoRegion is a PolyRegion, we need to defined a mask as well ..."
    nlon = nlon[iWE]
    nlat =  lat[iNS]
    mask = Array{FT,2}(undef,length(nlon),length(nlat))
    for ilat in eachindex(nlat), ilon in eachindex(nlon)
        ipnt = Point2(nlon[ilon],nlat[ilat])
        if isinGeoRegion(ipnt,geo,throw=false)
              mask[ilon,ilat] = 1
        else; mask[ilon,ilat] = NaN
        end
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

    E = mod(E,360); W = mod(W,360); nlon = mod.(rlon,360);
    iN = argmin(abs.(rlat.-N)); iS = argmin(abs.(rlat.-S)); iW = argmin(abs.(nlon.-W));
    if E == W;
        if gridbounds[3] != gridbounds[4]
              if iW != 1; iE = iW - 1; else; iE = length(nlon); end
        else; iE = iW
        end
    else; iE = argmin(abs.(nlon.-E));
    end

    if rlon[2] > rlon[1]; EgW = true; else; EgW = false end
    if rlat[2] > rlat[1]; NgS = true; else; NgS = false end

    while rlon[iW] < W
        if EgW; iW += 1; else; iW -= 1 end
    end

    while rlon[iE] > E
        if EgW; iE -= 1; else; iE += 1 end
    end

    while rlat[iS] < S
        if NgS; iS += 1; else; iS -= 1 end
    end

    while rlat[iN] > N
        if NgS; iN -= 1; else; iN += 1 end
    end

    if (NgS && (iN < iS)) || (!NgS && (iS < iN))
        error("$(modulelog()) - The bounds of the specified georegion do not contain any latitude points")
    end

    if (EgW && (iE < iW)) || (!EgW && (iW < iE))
        error("$(modulelog()) - The bounds of the specified georegion do not contain any longitude points")
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
          iWE = vcat(iW:length(lon),1:iE); nlon[1:(iW-1)] .+= 360
    else; iWE = [iW];
    end

    while maximum(nlon); nlon .-= 360 end
    nlon = nlon[iWE]
    nlat =  lat[iNS]

    return RectGrid{FT}(igrid,iWE,iNS,nlon,nlat)

end
