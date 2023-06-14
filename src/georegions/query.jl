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
    lon   = zeros(21,npnt-1)
    lat   = zeros(21,npnt-1)

    for ipnt = 1 : (npnt-1)
        lon[:,ipnt] .= collect(range(shape[ipnt][1],shape[ipnt+1][1],21))
        lat[:,ipnt] .= collect(range(shape[ipnt][2],shape[ipnt+1][2],21))
    end

    lon = lon[:]
    lat = lat[:]

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W

    blon = vcat(range(W,E,21),range(E,E,21),range(E,W,21),range(W,W,21))
    blat = vcat(range(N,N,21),range(N,S,21),range(S,S,21),range(S,N,21))

    return blon,blat,lon,lat

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

    blon = vcat(range(W,E,21),range(E,E,21),range(E,W,21),range(W,W,21))
    blat = vcat(range(N,N,21),range(N,S,21),range(S,S,21),range(S,N,21))

    return blon,blat

end
