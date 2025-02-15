"""
    derotatecoordinates(
        lon :: Vector{<:Real},
        lat :: Vector{<:Real},
        geo :: GeoRegion;
        rotation :: Real = geo.θ
    ) -> X :: Vector{<:Real}, Y :: Vector{<:Real}

Derotate coordinates given by the vectors of longitude and latitude, around the centroid of the GeoRegion, and return their X and Y cartesian positions in meters.

Arguments
=========
- `lon` : A `Vector` containing the longitudes of the points.
- `lat` : A `Vector` containing the latitudes of the points.
- `geo` : A GeoRegion.

Keyword Arguments
=================
- `rotation` : Angle (in degrees) at which to "unrotate" the shape about the GeoRegion centroid and project into the X-Y cartesian coordinate system (in meters). A positive value will turn the shape in the clockwise direction. Default is `geo.θ`.

Returns
=======
- `X` : A vector of X-coordinates (in meters) about the centroid for the shape of the GeoRegion.
- `Y` : A vector of Y-coordinates (in meters) about the centroid for the shape of the GeoRegion.
"""
function derotatecoordinates(
    lon :: Vector{<:Real},
    lat :: Vector{<:Real},
    geo :: GeoRegion;
    rotation :: Real = 0
)

    npnts = length(lon)
    X = zeros(npnts)
    Y = zeros(npnts)

    for ipnt = 1 : npnts
        X[ipnt],Y[ipnt] = derotatepoint(lon[ipnt],lat[ipnt],geo,rotation=rotation)
    end

    return X,Y

end

"""
    derotatecoordinates!(
        lon :: Vector{<:Real},
        lat :: Vector{<:Real},
        geo :: GeoRegion;
        rotation :: Real = geo.θ
    ) -> nothing

In-place mutation of the `lon` and `lat` vectors. Derotate coordinates given by the vectors of longitude and latitude, around the centroid of the GeoRegion, and return their X and Y cartesian positions in meters.

Arguments
=========
- `lon` : A `Vector` containing the longitudes of the points, values will be replaced by the derotated x-coordinates (in meters) about the centroid.
- `lat` : A `Vector` containing the latitudes of the points, values will be replaced by the derotated y-coordinates (in meters) about the centroid.
- `geo` : A GeoRegion.

Keyword Arguments
=================
- `rotation` : Angle (in degrees) at which to "unrotate" the shape about the GeoRegion centroid and project into the X-Y cartesian coordinate system (in meters). A positive value will turn the shape in the clockwise direction. Default is `geo.θ`.
"""
function derotatecoordinates!(
    lon :: Vector{<:Real},
    lat :: Vector{<:Real},
    geo :: GeoRegion;
    rotation :: Real = 0
)

    npnts = length(lon)

    for ipnt = 1 : npnts
        lon[ipnt],lat[ipnt] = derotatepoint(lon[ipnt],lat[ipnt],geo,rotation=rotation)
    end

    return nothing

end

"""
    derotatecoordinates(
        pnts :: Vector{<:Real},
        geo  :: GeoRegion;
        rotation :: Real = geo.θ
    ) -> X :: Vector{<:Real}, Y :: Vector{<:Real}

Derotate coordinates given by a vector of `Point2` Type, around the centroid of the GeoRegion `geo`, and return their X and Y cartesian positions in meters.

Arguments
=========
- `pnts` : A `Vector` of `Point2` type, each containing a (lon,lat) point.
- `geo` : A GeoRegion.

Keyword Arguments
=================
- `rotation` : Angle (in degrees) at which to "unrotate" the shape about the GeoRegion centroid and project into the X-Y cartesian coordinate system (in meters). A positive value will turn the shape in the clockwise direction. Default is `geo.θ`.

Returns
=======
- `X` : A vector of X-coordinates (in meters) about the centroid for the shape of the GeoRegion.
- `Y` : A vector of Y-coordinates (in meters) about the centroid for the shape of the GeoRegion.
"""
function derotatecoordinates(
    pnts :: Vector{Point2{<:Real}},
    geo  :: GeoRegion;
    rotation :: Real = 0
)

    npnts = length(pnts)
    X = zeros(npnts)
    Y = zeros(npnts)

    for ipnt = 1 : npnts
        X[ipnt],Y[ipnt] = derotatepoint(pnts[ipnt],geo,rotation=rotation)
    end

    return X,Y

end

"""
    derotatepoint(
        lon :: Real,
        lat :: Real,
        geo :: GeoRegion;
        rotation :: Real = geo.θ
    ) -> X :: Real, Y :: Real

Derotate a coordinate point given by (lon,lat), around the centroid of the GeoRegion `geo`, and return its X and Y cartesian positions in meters.

Arguments
=========
- `lon` : The longitudinal coordinate of the point
- `lat` : The latitudinal coordinate of the point
- `geo` : A GeoRegion.

Keyword Arguments
=================
- `rotation` : Angle (in degrees) at which to "unrotate" the shape about the GeoRegion centroid and project into the X-Y cartesian coordinate system (in meters). A positive value will turn the shape in the clockwise direction. Default is `geo.θ`.

Returns
=======
- `X` : A vector of X-coordinates (in meters) about the centroid for the shape of the GeoRegion.
- `Y` : A vector of Y-coordinates (in meters) about the centroid for the shape of the GeoRegion.
"""
function derotatepoint(
    lon :: Real,
    lat :: Real,
    geo :: GeoRegion;
    rotation :: Real = 0
)

    Xc,Yc = geo.geometry.centroid
    ir = haversine((lon,lat),(Xc,Yc))
    iθ = atand(lat-Yc,lon-Xc) - (geo.θ - rotation)

    return ir * cosd(iθ), ir * sind(iθ)

end

"""
    derotatepoint(
        pnt :: Point2{<:Real},
        geo :: GeoRegion;
        rotation :: Real = geo.θ
    ) -> X :: Real, Y :: Real

Derotate a coordinate point given by (lon,lat), around the centroid of the GeoRegion `geo`, and return its X and Y cartesian positions in meters.

Arguments
=========
- `pnt` : A `Point2` type, containing the (lon,lat) coordinates.
- `geo` : A GeoRegion.

Keyword Arguments
=================
- `rotation` : Angle (in degrees) at which to "unrotate" the shape about the GeoRegion centroid and project into the X-Y cartesian coordinate system (in meters). A positive value will turn the shape in the clockwise direction. Default is `geo.θ`.

Returns
=======
- `X` : A vector of X-coordinates (in meters) about the centroid for the shape of the GeoRegion.
- `Y` : A vector of Y-coordinates (in meters) about the centroid for the shape of the GeoRegion.
"""
function derotatepoint(
    pnt :: Point2{<:Real},
    geo :: GeoRegion;
    rotation :: Real = 0
)

    Xc,Yc = geo.geometry.centroid
    ir = haversine((pnt[1],pnt[2]),(Xc,Yc))
    iθ = atand(pnt[2]-Yc,pnt[1]-Xc) - (geo.θ - rotation)

    return ir * cosd(iθ),ir * sind(iθ)

end