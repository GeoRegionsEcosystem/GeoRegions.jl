"""
    coordinates(
        geo :: GeoRegion;
        n :: Int = 1
    ) -> lon :: Vector{<:Real}, lat :: Vector{<:Real}

For a given GeoRegion, create longitude and latitude vectors of the shape.

Arguments
=========
- `geo` : A GeoRegion.
- `n` : The number of segments on each side of the shape.

Returns
=======
- `lon` : A vector of longitude points for the shape of the GeoRegion.
- `lat` : A vector of latitude points for the shape of the GeoRegion.
"""
function coordinates(
    geo :: GeoRegion;
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

N(geo :: GeoRegion) = geo.bound[1]
S(geo :: GeoRegion) = geo.bound[2]
E(geo :: GeoRegion) = geo.bound[3]
W(geo :: GeoRegion) = geo.bound[4]