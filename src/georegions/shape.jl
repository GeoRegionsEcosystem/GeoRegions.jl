"""
    coordinates(
        geo :: GeoRegion;
        n   :: Int = 1
    ) -> lon :: Vector{<:Real}, lat :: Vector{<:Real}

For a given GeoRegion, create longitude and latitude vectors of the shape.

Arguments
=========
- `geo` : A GeoRegion.

Keyword Arguments
=================
- `n` : The number of segments on each side of the shape.

Returns
=======
- `lon` : A vector of longitude points for the shape of the GeoRegion.
- `lat` : A vector of latitude points for the shape of the GeoRegion.
"""
function coordinates(
    geo :: GeoRegion;
    n   :: Int = 1
)

    shape = geo.geometry.shape
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
    unrotatedcartesian(
        geo :: GeoRegion;
        n   :: Int = 1
        rotation :: Real = geo.θ
    ) -> X :: Vector{<:Real}, Y :: Vector{<:Real}

For a given GeoRegion, calculate the shape (in meters) in the x-y cartesian coordinate system around the centroid of the GeoRegion.

Arguments
=========
- `geo` : A GeoRegion.

Keyword Arguments
=================
- `n` : The number of segments on each side of the shape.
- `rotation` : Angle (in degrees) at which to "unrotate" the shape about the GeoRegion centroid and project into the X-Y cartesian coordinate system (in meters). A positive value will turn the shape in the clockwise direction.

Returns
=======
- `X` : A vector of X-coordinates (in meters) about the centroid for the shape of the GeoRegion.
- `Y` : A vector of Y-coordinates (in meters) about the centroid for the shape of the GeoRegion.
"""
function unrotatedcartesian(
    geo :: GeoRegion;
    n   :: Int = 1,
    rotation :: Real = geo.θ
)

    lon,lat = coordinates(geo,n=n); npnts = length(lon)
    Xc, Yc  = centroid(geo)

    X = zeros(npnts)
    Y = zeros(npnts)

    for ipnt = 1 : npnts
        ir = haversine((lon[ipnt],lat[ipnt]),(Xc,Yc))
        iθ = atand(lat[ipnt]-Yc,lon[ipnt]-Xc) - rotation
        X[ipnt] = ir * cosd(iθ)
        Y[ipnt] = ir * sind(iθ)
    end

    return X,Y

end

"""
    centroid(geo :: GeoRegion) -> lonc, latc

For a given GeoRegion, calculate the longitude and latitude of the centroid.

Arguments
=========
- `geo` : A GeoRegion.

Returns
=======
- `lonc` : The longitude of the GeoRegion's centroid.
- `latc` : The latitude of the GeoRegion's centroid.
"""
centroid(geo :: GeoRegion) = centroid(geo.geometry.polygon)