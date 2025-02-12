function listall(
    path :: AbstractString = homedir(),
    warn :: Bool = false
)

    IDs    = []
    gpaths = []

    IDs,gpaths = fillinfo(IDs,gpaths,geodir,warn)
    IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geodir,"GF"),warn)
    IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geodir,"SRX"),warn)
    IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geodir,"AR6"),warn)
    IDs,gpaths = fillinfo(IDs,gpaths,geopath(path),warn)

    return IDs,gpaths

end

function fillinfo(IDs,gpaths,geopath,warn)

    IDvec = replace.(basename.(glob("*.json",geopath)),".json"=>"")
    nID   = length(IDvec)

    if isempty(IDvec) && warn
        @warn "$(modulelog()) - No custom GeoRegions are available in $geopath, please check to ensure the path specified is correct."
    end

    return vcat(IDs,IDvec),vcat(gpaths,fill(path,nID))

end