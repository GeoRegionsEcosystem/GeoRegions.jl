"""
    coordinates(
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
function coordinates(
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

function coordinates(
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

function coordinates(
    geo :: TiltRegion;
    n :: Int = 21
)

    X  = geo.X
    Y  = geo.Y
    θ  = geo.θ
    ΔX = geo.ΔX
    ΔY = geo.ΔY

    lon1 = X - ΔX * cosd(θ) - ΔY * sind(θ); lat1 = Y + ΔY * cosd(θ) - ΔX * sind(θ)
    lon2 = X - ΔX * cosd(θ) + ΔY * sind(θ); lat2 = Y - ΔY * cosd(θ) - ΔX * sind(θ)
    lon3 = X + ΔX * cosd(θ) + ΔY * sind(θ); lat3 = Y - ΔY * cosd(θ) + ΔX * sind(θ)
    lon4 = X + ΔX * cosd(θ) - ΔY * sind(θ); lat4 = Y + ΔY * cosd(θ) + ΔX * sind(θ)

    if n > 1
        lon = vcat(
            range(lon1,lon2,n),range(lon2,lon3,n),
            range(lon3,lon4,n),range(lon4,lon1,n)
        )
        lat = vcat(
            range(lat1,lat2,n),range(lat2,lat3,n),
            range(lat3,lat4,n),range(lat4,lat1,n)
        )
    else
        lon = [lon1,lon2,lon3,lon4,lon1]
        lat = [lat1,lat2,lat3,lat4,lat1]
    end

    return lon,lat

end