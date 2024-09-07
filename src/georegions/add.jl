function add(
    geo  :: RectRegion,
    path :: AbstractString = dirname(geo.path);
    verbose :: Bool = true
)

    RectRegion(
        geo.ID, geo.pID, geo.name,
        [geo.N,geo.S,geo.E,geo.W],
        path = path, verbose = verbose, save = true
    )

    return nothing

end

function add(
    geo  :: TiltRegion,
    path :: AbstractString = dirname(geo.path);
    verbose :: Bool = true
)

    TiltRegion(
        geo.ID, geo.pID, geo.name,
        geo.X, geo.Y, geo.ΔX, geo.ΔY, geo.θ,
        path = path, verbose = verbose, save = true
    )

    return nothing

end

function add(
    geo  :: PolyRegion,
    path :: AbstractString = dirname(geo.path);
    verbose :: Bool = true
)

    lon,lat = coordGeoRegion(geo,n=1)

    PolyRegion(
        geo.ID, geo.pID, geo.name,
        lon, lat,
        path = path, verbose = verbose, save = true
    )

    return nothing

end

function overwrite(
    geo  :: GeoRegion;
    path :: AbstractString,
    verbose :: Bool = true
)

    rmID(geo.ID,path=path)
    add(geo,path=path,verbose=verbose)
    
    return nothing

end