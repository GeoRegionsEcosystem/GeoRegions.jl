"""
    coordinates(
        geo :: GeoRegion;
        n :: Int = 1
    ) -> lon :: Vector{<:Real}, lat :: Vector{<:Real}

For a given GeoRegion, create longitude and latitude vectors of the shape.

Arguments
=========
- `geo` : A GeoRegion
- `n` : The number of segments on each side of the shape (a vertex counts as half a point)

Returns
=======
- `lon` : A vector of longitude points for the shape of the GeoRegion
- `lat` : A vector of latitude points for the shape of the GeoRegion
"""
function coordinates(
    geo :: PolyRegion;
    n :: Int = 1
)

    shape = geo.shape
    npnt  = length(shape)

    if isone(n)
        lon = zeros(npnt)
        lat = zeros(npnt)
        for ipnt = 1 : npnt
            lon[ipnt] = shape[ipnt][1]
            lat[ipnt] = shape[ipnt][2]
        end
    else
        lon = zeros(n,npnt-1)
        lat = zeros(n,npnt-1)
        for ipnt = 1 : (npnt-1)
            lon[:,ipnt] .= collect(range(shape[ipnt][1],shape[ipnt+1][1],n+1))[1:(end-1)]
            lat[:,ipnt] .= collect(range(shape[ipnt][2],shape[ipnt+1][2],n+1))[1:(end-1)]
        end
        lon = vcat(lon[:],lon[1])
        lat = vcat(lat[:],lat[1])
    end

    return lon,lat

end

function coordinates(
    geo :: RectRegion;
    n :: Int = 1
)

    N = geo.N
    S = geo.S
    E = geo.E
    W = geo.W

    if isone(n)
        lon = [W,E,E,W,W]
        lat = [N,N,S,S,N]
    else
        lon = vcat(
            range(W,E,n+1)[1:(end-1)], range(E,E,n+1)[1:(end-1)],
            range(E,W,n+1)[1:(end-1)], range(W,W,n+1)[1:(end-1)],
            W
        )
        lat = vcat(
            range(N,N,n+1)[1:(end-1)], range(N,S,n+1)[1:(end-1)],
            range(S,S,n+1)[1:(end-1)], range(S,N,n+1)[1:(end-1)],
            N
        )
    end

    return lon,lat

end

function coordinates(
    geo :: TiltRegion;
    n :: Int = 1
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

    if isone(n)
        lon = [lon1,lon2,lon3,lon4,lon1]
        lat = [lat1,lat2,lat3,lat4,lat1]
    else
        lon = vcat(
            range(lon1,lon2,n+1)[1:(end-1)], range(lon2,lon3,n+1)[1:(end-1)],
            range(lon3,lon4,n+1)[1:(end-1)], range(lon4,lon1,n+1)[1:(end-1)],
            lon1
        )
        lat = vcat(
            range(lat1,lat2,n+1)[1:(end-1)], range(lat2,lat3,n+1)[1:(end-1)],
            range(lat3,lat4,n+1)[1:(end-1)], range(lat4,lat1,n+1)[1:(end-1)],
            lat1
        )
    end

    return lon,lat

end