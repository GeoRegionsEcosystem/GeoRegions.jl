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

"""
    N(geo :: GeoRegion) -> north :: Real

For a given GeoRegion, find the northern bound of the GeoRegion

Arguments
=========
- `geo` : A GeoRegion.

Returns
=======
- `north` : The northern latitude bound.
"""
N(geo :: GeoRegion) = geo.bound[1]

"""
    S(geo :: GeoRegion) -> south :: Real

For a given GeoRegion, find the southern bound of the GeoRegion

Arguments
=========
- `geo` : A GeoRegion.

Returns
=======
- `south` : The southern latitude bound, a `Float` type.
"""
S(geo :: GeoRegion) = geo.bound[2]

"""
    E(geo :: GeoRegion) -> east :: Real

For a given GeoRegion, find the eastern bound of the GeoRegion.

Arguments
=========
- `geo` : A GeoRegion.

Returns
=======
- `east` : The eastern longitude bound.
"""
E(geo :: GeoRegion) = geo.bound[3]

"""
    W(geo :: GeoRegion) -> west :: Real

For a given GeoRegion, find the western bound of the GeoRegion.

Arguments
=========
- `geo` : A GeoRegion.

Returns
=======
- `west` : The western longitude bound, a `Float` type.
"""
W(geo :: GeoRegion) = geo.bound[4]

"""
    X(geo :: TiltRegion) -> x :: Real

For a given TiltRegion, find the longitude of the center.

Arguments
=========
- `geo` : A TiltRegion.

Returns
=======
- `x` : The longitude of the center of the `TiltRegion`, a `Float` type.
"""
X(geo :: TiltRegion) = geo.tilt[1]

"""
    Y(geo :: TiltRegion) -> y :: Real

For a given TiltRegion, find the latitude of the center.

Arguments
=========
- `geo` : A TiltRegion.

Returns
=======
- `y` : The latitude of the center of the `TiltRegion`, a `Float` type.
"""
Y(geo :: TiltRegion) = geo.tilt[2]

"""
    ΔX(geo :: TiltRegion) -> dx :: Real

For a given TiltRegion, find the unrotated longitude half-width.

Arguments
=========
- `geo` : A TiltRegion.

Returns
=======
- `dx` : The unrotated longitude half-width, a `Float` type.
"""
ΔX(geo :: TiltRegion) = geo.tilt[3]

"""
    ΔY(geo :: GeoRegion) -> dy :: Real

For a given TiltRegion, find the unrotated latitude half-width.

Arguments
=========
- `geo` : A TiltRegion.

Returns
=======
- `dY` : The unrotated latitude half-width, a `Float` type.
"""
ΔY(geo :: TiltRegion) = geo.tilt[4]

"""
    θ(geo :: GeoRegion) -> angle :: Real

For a given GeoRegion, find the western bound of the GeoRegion.

Arguments
=========
- `geo` : A TiltRegion.

Returns
=======
- `angle` : The tilt of the region.
"""
θ(geo :: TiltRegion) = geo.tilt[5]