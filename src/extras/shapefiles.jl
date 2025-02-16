function shp2georegion(
    fshp :: AbstractString;
    path :: AbstractString,
    IDsym   :: Symbol,
    pIDsym  :: Symbol,
    namesym :: Symbol,
    ST = String,
    FT = Float64
)

    table = Shapefile.Table(fshp)
    gpath = GeoRegions.geopath(path)

    IDvec = getproperty(table,IDsym)
    pIDvec = getproperty(table,pIDsym)
    namevec = getproperty(table,namesym)
    geometries = table.geometry

    nshp = length(IDvec)
    for ishp = 1 : nshp

        pnts = geometries[ishp].points; npnts = length(pnts)
        lon  = zeros(npnts)
        lat  = zeros(npnts)

        for ipnts = 1 : npnts
            lon[ipnts] = pnts[ipnts].x
            lat[ipnts] = pnts[ipnts].y
        end

        if Point2(lon[1],lat[1]) !== Point2(lon[end],lat[end])
            lon = vcat(lon,lon[1]); lat = vcat(lat,lat[1])
        end

        !isdir(gpath) ? mkpath(gpath) : nothing
        open(joinpath(gpath,"$(IDvec[ishp]).json"), "w") do io
            JSON3.write(io,JSONRegion{ST,FT}(
                string(IDvec[ishp]), string(pIDvec[ishp]), string(namevec[ishp]), 0,
                JSONGeometry{FT}(lon, lat)
            ))
        end

    end

end