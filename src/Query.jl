function coordGeoRegion(GeoReg::PolyRegion)

    shape = GeoReg.shape
    npnt  = length(shape)
    lon   = zeros(npnt)
    lat   = zeros(npnt)

    for ipnt = 1 : npnt
        lon[ipnt] = shape[ipnt][1]
        lat[ipnt] = shape[ipnt][2]
    end

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W

    return [W,E,E,W,W],[N,N,S,S,N],lon,lat

end

function coordGeoRegion(GeoReg::RectRegion)

    N = GeoReg.N
    S = GeoReg.S
    E = GeoReg.E
    W = GeoReg.W
    return [W,E,E,W,W],[N,N,S,S,N]

end
