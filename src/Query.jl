"""
    coordGeoRegion(geo::PolyRegion) ->
        blon::Vector{<:Real}, blat::Vector{<:Real},
        slon::Vector{<:Real}, slat::Vector{<:Real},

For a given RectRegion, extract the [N,S,E,W] bounds and create a longitude and latitude vectors for the bound and the shape of the GeoRegion

Arguments
=========

- `geo` : A PolyRegion (i.e. a polygonal GeoRegion)

Returns
=======

- `blon` : A vector of longitude points for the bound of the GeoRegion
- `blat` : A vector of latitude points for the bound of the GeoRegion
- `slon` : A vector of longitude points for the shape of the GeoRegion
- `slat` : A vector of latitude points for the shape of the GeoRegion
"""
function coordGeoRegion(GeoReg::PolyRegion)

    shape = GeoReg.shape
    npnt  = length(shape)
    lon   = zeros(npnt)
    lat   = zeros(npnt)

    for ipnt = 1 : npnt
        lon[ipnt] = shape[ipnt][1]
        lat[ipnt] = shape[ipnt][2]
    end

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W

    return [W,E,E,W,W],[N,N,S,S,N],lon,lat

end

"""
    coordGeoRegion(geo::RectRegion) -> blon::Vector{<:Real}, blat::Vector{<:Real}

For a given RectRegion, extract the [N,S,E,W] bounds and create a longitude and latitude vector.

Arguments
=========

- `geo` : A RectRegion (i.e. a rectilinear GeoRegion)

Returns
=======

- `blon` : A vector of longitude points for the bound of the GeoRegion
- `blat` : A vector of latitude points for the bound of the GeoRegion
"""
function coordGeoRegion(GeoReg::RectRegion)

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W
    return [W,E,E,W,W],[N,N,S,S,N]

end
