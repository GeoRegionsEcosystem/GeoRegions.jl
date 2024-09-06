add(
    geo  :: GeoRegion;
    path :: AbstractString,
    verbose :: Bool = true
) = addGeoRegion(geo;path=path,verbose=verbose)

function overwrite(
    geo  :: GeoRegion;
    path :: AbstractString,
    verbose :: Bool = true
)

     rm(geo,path=path)
    add(geo,path=path,verbose=verbose)
    
    return nothing

end

function addGeoRegion(
    geo  :: RectRegion;
    path :: AbstractString,
    verbose :: Bool = true
)

    RectRegion(
        geo.ID, geo.pID, geo.name,
        [geo.N,geo.S,geo.E,geo.W],
        path = path, verbose = verbose
    )

    return nothing

end

function addGeoRegion(
    geo  :: TiltRegion;
    path :: AbstractString,
    verbose :: Bool = true
)

    TiltRegion(
        geo.ID, geo.pID, geo.name,
        geo.X, geo.Y, geo.ΔX, geo.ΔY, geo.θ,
        path = path, verbose = verbose
    )

    return nothing

end

function addGeoRegion(
    geo  :: PolyRegion;
    path :: AbstractString,
    verbose :: Bool = true
)

    lon,lat = coordGeoRegion(geo,n=1)

    PolyRegion(
        geo.ID, geo.pID, geo.name,
        lon, lat,
        path = path, verbose = verbose
    )

    return nothing

end