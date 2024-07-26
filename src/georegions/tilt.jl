getTiltBounds(geo :: TiltRegion) = getTiltBounds(geo.X,geo.Y,geo.ΔX,geo.ΔY,geo.θ)
getTiltShape(geo :: TiltRegion) = getTiltShape(geo.X,geo.Y,geo.ΔX,geo.ΔY,geo.θ)

function getTiltBounds(
    X  :: Real,
    Y  :: Real,
    ΔX :: Real,
    ΔY :: Real,
    θ  :: Real;
)

    lon,lat = getTiltShape(X,Y,ΔX,ΔY,θ)

    return maximum(lat), minimum(lat) , maximum(lon), minimum(lon)

end

function getTiltShape(
    X  :: Real,
    Y  :: Real,
    ΔX :: Real,
    ΔY :: Real,
    θ  :: Real;
)

    lon1 = X - ΔX * cosd(θ) + ΔY * sind(θ); lat1 = Y + ΔY * cosd(θ) + ΔX * sind(θ)
    lon2 = X - ΔX * cosd(θ) - ΔY * sind(θ); lat2 = Y - ΔY * cosd(θ) + ΔX * sind(θ)
    lon3 = X + ΔX * cosd(θ) - ΔY * sind(θ); lat3 = Y - ΔY * cosd(θ) - ΔX * sind(θ)
    lon4 = X + ΔX * cosd(θ) + ΔY * sind(θ); lat4 = Y + ΔY * cosd(θ) - ΔX * sind(θ)

    return [lon1,lon2,lon3,lon4], [lat1,lat2,lat3,lat4]

end