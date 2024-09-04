"""
    coordGeoRegion(
        geo :: GeoRegion;
        n :: Int = 21
    ) -> lon :: Vector{<:Real}, lat :: Vector{<:Real}

For a given GeoRegion, create longitude and latitude vectors of the shape.

Arguments
=========
- `geo` : A GeoRegion
- `n` : The number of points on each side of the shape (a vertex counts as half a point)

Returns
=======
- `lon` : A vector of longitude points for the shape of the GeoRegion
- `lat` : A vector of latitude points for the shape of the GeoRegion
"""
function coordGeoRegion(
    geo :: PolyRegion;
    n :: Int = 21
)

    shape = geo.shape
    npnt  = length(shape)

    if n > 1
        lon = zeros(n,npnt-1)
        lat = zeros(n,npnt-1)
        for ipnt = 1 : (npnt-1)
            lon[:,ipnt] .= collect(range(shape[ipnt][1],shape[ipnt+1][1],n))
            lat[:,ipnt] .= collect(range(shape[ipnt][2],shape[ipnt+1][2],n))
        end
    else
        lon = zeros(npnt)
        lat = zeros(npnt)
        for ipnt = 1 : npnt
            lon[ipnt] = shape[ipnt][1]
            lat[ipnt] = shape[ipnt][2]
        end
    end

    lon = lon[:]
    lat = lat[:]

    return lon,lat

end

function coordGeoRegion(
    geo :: RectRegion;
    n :: Int = 21
)

    N = geo.N
    S = geo.S
    E = geo.E
    W = geo.W

    if n > 1
        lon = vcat(range(W,E,n),range(E,E,n),range(E,W,n),range(W,W,n))
        lat = vcat(range(N,N,n),range(N,S,n),range(S,S,n),range(S,N,n))
    else
        lon = [W,E,E,W,W]
        lat = [N,N,S,S,N]
    end

    return lon,lat

end

function coordGeoRegion(
    geo :: TiltRegion;
    n :: Int = 21
)

    lon,lat = getTiltShape(geo)

    if n > 1
        lon = vcat(
            range(lon[1],lon[2],n),range(lon[2],lon[3],n),
            range(lon[3],lon[4],n),range(lon[4],lon[1],n)
        )
        lat = vcat(
            range(lat[1],lat[2],n),range(lat[2],lat[3],n),
            range(lat[3],lat[4],n),range(lat[4],lat[1],n)
        )
    else
        lon = vcat(lon,lon[1])
        lat = vcat(lat,lat[1])
    end

    return lon,lat

end