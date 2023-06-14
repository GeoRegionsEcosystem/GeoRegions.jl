"""
    RegionGrid(
        geo :: GeoRegion,
        lon :: Union{Vector{<:Real},AbstractRange{<:Real},
        lat :: Union{Vector{<:Real},AbstractRange{<:Real}
    ) -> RectGrid, PolyGrid

Creates a `RectGrid` or `PolyGrid` type based on the following arguments. This method is suitable for rectilinear grids of longitude/latitude output such as from Isca, or from satellite and reanalysis gridded datasets.

Arguments
=========

- `geo` : A GeoRegion of interest
- `lon` : A vector or `AbstractRange` containing the longitude points
- `lat` : A vector or `AbstractRange` containing the latitude points
"""
RegionGrid(
    geo::RectRegion, lon::Vector{<:Real}, lat::Vector{<:Real}
) = RectGrid(geo,lon,lat)
RegionGrid(
    geo::PolyRegion, lon::Vector{<:Real}, lat::Vector{<:Real}
) = PolyGrid(geo,lon,lat)

RegionGrid(
    geo::RectRegion, lon::AbstractRange{<:Real}, lat::AbstractRange{<:Real}
) = RectGrid(geo,collect(lon),collect(lat))
RegionGrid(
    geo::PolyRegion, lon::AbstractRange{<:Real}, lat::AbstractRange{<:Real}
) = PolyGrid(geo,collect(lon),collect(lat))

"""
    RegionGrid(
        geo :: GeoRegion,
        lon :: Array{<:Real,2},
        lat :: Array{<:Real,2}
    ) -> RegionGrid

Creates a `RegionMask` type based on the following arguments. This method is more suitable for non-rectilinear grids of longitude and latitude points, such as in the output of WRF or CESM.

Arguments
=========

- `geo` : A GeoRegion of interest
- `lon` : An array containing the longitude points
- `lat` : An array containing the latitude points
"""
function RegionGrid(
    geo :: GeoRegion,
    lon :: Array{<:Real,2},
    lat :: Array{<:Real,2}
)

    @info "$(modulelog()) - Creating a RegionMask for the $(geo.name) GeoRegion based on an array of longitude and latitude points"

    if eltype(lon) <: AbstractFloat
        FT = eltype(lon)
    end

    if size(lon) != size(lat)
        error("$(modulelog()) - The size of the longitude and latitude arrays are not the same.")
    end

    mask = zeros(size(lon))

    for ii in eachindex(lon)
        ipnt = Point2(lon[ii],lat[ii])
        if isinGeoRegion(ipnt,geo,throw=false)
              mask[ii] = 1
        else; mask[ii] = NaN
        end
    end

    return RegionMask{FT}(lon,lat,mask)

end

function RectGrid(
    geo :: RectRegion,
    lon :: Vector{<:Real},
    lat :: Vector{<:Real}
)

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

    return RectGrid{eltype(lon)}(igrid,nlon,nlat,iWE,iNS)

end

function PolyGrid(
    geo :: PolyRegion,
    lon :: Vector{<:Real},
    lat :: Vector{<:Real};
    FT = Float64
)

    @info "$(modulelog()) - Creating a RegionGrid for the $(geo.name) GeoRegion"

    @debug "$(modulelog()) - Determining indices of longitude and latitude boundaries in the given dataset ..."
    N = geo.N
    S = geo.S
    E = geo.E
    W = geo.W

    if eltype(lon) <: AbstractFloat
        FT = eltype(lon)
    end

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

    return PolyGrid{FT}(igrid,nlon,nlat,iWE,iNS,mask)

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

    if rlon[2] > rlon[1]; EgW = true; else; EgW = false end
    if rlat[2] > rlat[1]; NgS = true; else; NgS = false end

    E = mod(E,360); W = mod(W,360); nlon = mod.(rlon,360);
    iN = argmin(abs.(rlat.-N)); iS = argmin(abs.(rlat.-S)); iW = argmin(abs.(nlon.-W));
    if E == W;
        if gridbounds[3] != gridbounds[4]
            if iW != 1; iE = iW - 1; else; iE = length(nlon); end
        else
            if EgW
                if iW > 1; iE = iW - 1; else; iE = length(rlon) end
            else
                if iW < length(rlon); iE = iW + 1; else; iE = 1 end
            end
        end
    else; iE = argmin(abs.(nlon.-E));
    end

    if !(E==W) || (gridbounds[3] == gridbounds[4])
        while mod(rlon[iW],360) < mod(W,360)
            if EgW
                iW += 1; if iW > length(rlon); iW = 1 end
            else
                iW -= 1; if iszero(iW); iW = length(rlon) end
            end
        end

        while mod(rlon[iE],360) > mod(E,360)
            if EgW
                iE -= 1; if iszero(iE); iE = length(rlon) end
            else
                iE += 1; if iE > length(rlon); iE = 1 end
            end
        end
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

    # Figure out how to ensure that bounds are respected
    # if (EgW && (iE < iW)) || (!EgW && (iW < iE))
    #     error("$(modulelog()) - The bounds of the specified georegion do not contain any longitude points")
    # end

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
