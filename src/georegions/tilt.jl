getTiltBounds(geo :: TiltRegion) = getTiltBounds(geo.X,geo.Y,geo.ΔX,geo.ΔY,geo.θ)
getTiltShape(geo :: TiltRegion) = getTiltShape(geo.X,geo.Y,geo.ΔX,geo.ΔY,geo.θ)

function getTiltBounds(
    X  :: Real,
    Y  :: Real,
    ΔX :: Real,
    ΔY :: Real,
    θ  :: Real;
)

    W = X - ΔX * cosd(θ)
    E = X + ΔX * cosd(θ)
    S = Y - ΔY * sind(θ)
    N = Y + ΔY * sind(θ)

    return N,S,E,W

end

function getTiltShape(
    X  :: Real,
    Y  :: Real,
    ΔX :: Real,
    ΔY :: Real,
    θ  :: Real;
)

    lon1 = X - ΔX * cosd(θ) + ΔY * sind(θ); lon1 = Y + ΔY * cosd(θ) + Δx * sind(θ)
    lon2 = X - ΔX * cosd(θ) - ΔY * sind(θ); lon2 = Y - ΔY * cosd(θ) + Δx * sind(θ)
    lon3 = X + ΔX * cosd(θ) + ΔY * sind(θ); lon3 = Y + ΔY * cosd(θ) - Δx * sind(θ)
    lon4 = X + ΔX * cosd(θ) - ΔY * sind(θ); lon4 = Y - ΔY * cosd(θ) - Δx * sind(θ)

    return [lon1,lon2,lon3,lon4], [lat1,lat2,lat3,lat4]

end