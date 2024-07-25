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

- `lon` : A vector of longitude points for the shape of the GeoRegion
- `lat` : A vector of latitude points for the shape of the GeoRegion
"""
function coordGeoRegion(
    GeoReg :: PolyRegion;
    n :: Int = 21
)

    shape = GeoReg.shape
    npnt  = length(shape)
    lon   = zeros(n,npnt-1)
    lat   = zeros(n,npnt-1)

    for ipnt = 1 : (npnt-1)
        lon[:,ipnt] .= collect(range(shape[ipnt][1],shape[ipnt+1][1],n))
        lat[:,ipnt] .= collect(range(shape[ipnt][2],shape[ipnt+1][2],n))
    end

    lon = lon[:]
    lat = lat[:]

    return lon,lat

end

"""
    coordGeoRegion(geo::RectRegion) -> blon::Vector{<:Real}, blat::Vector{<:Real}

For a given RectRegion, extract the [N,S,E,W] bounds and create a longitude and latitude vector.

Arguments
=========

- `geo` : A RectRegion (i.e. a rectilinear GeoRegion)

Returns
=======

- `lon` : A vector of longitude points for the bound of the GeoRegion
- `lat` : A vector of latitude points for the bound of the GeoRegion
"""
function coordGeoRegion(
    GeoReg :: RectRegion;
    n :: Int = 21
)

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W

    lon = vcat(range(W,E,n),range(E,E,n),range(E,W,n),range(W,W,n))
    lat = vcat(range(N,N,n),range(N,S,n),range(S,S,n),range(S,N,n))

    return lon,lat

end

"""
    coordGeoRegion(geo::RectRegion) -> blon::Vector{<:Real}, blat::Vector{<:Real}

For a given RectRegion, extract the [N,S,E,W] bounds and create a longitude and latitude vector.

Arguments
=========

- `geo` : A RectRegion (i.e. a rectilinear GeoRegion)

Returns
=======

- `lon` : A vector of longitude points for the bound of the GeoRegion
- `lat` : A vector of latitude points for the bound of the GeoRegion
"""
function coordGeoRegion(
    GeoReg :: TiltRegion;
    n :: Int = 21
)

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W

    lon = vcat(range(W,E,n),range(E,E,n),range(E,W,n),range(W,W,n))
    lat = vcat(range(N,N,n),range(N,S,n),range(S,S,n),range(S,N,n))

    return lon,lat

end