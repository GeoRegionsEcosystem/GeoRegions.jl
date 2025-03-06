function listall(
    path :: AbstractString = homedir(),
    warn :: Bool = false
)

    IDs    = []
    gpaths = []

    IDs,gpaths = fillinfo(IDs,gpaths,geopredefined,warn)
    IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geopredefined,"GF"),warn)
    IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geopredefined,"SREX"),warn)
    IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geopredefined,"AR6"),warn)
    IDs,gpaths = fillinfo(IDs,gpaths,geopath(path),warn)

    return IDs,gpaths

end

function fillinfo(IDs,gpaths,geopath,warn)

    IDvec = replace.(basename.(glob("*.json",geopath)),".json"=>"")
    nID   = length(IDvec)

    isempty(IDvec) && warn ? (@warn "$(modulelog()) - No custom GeoRegions are available in $geopath, please check to ensure the path specified is correct.") : nothing
    flush(stderr)

    return vcat(IDs,IDvec),vcat(gpaths,fill(geopath,nID))

end