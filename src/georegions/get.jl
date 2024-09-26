function getgeoregion(
    geoID :: AbstractString,
    fname :: AbstractString,
    GType :: AbstractString,
    ST = String,
    FT = Float64
)

    if GType == "PolyRegion"
        return getpolyregion(geoID,fname,ST,FT)
    elseif GType == "RectRegion"
        return getrectregion(geoID,fname,ST,FT)
    elseif GType == "TiltRegion"
        return gettiltregion(geoID,fname,ST,FT)
    end

end

function getrectregion(
    ID  :: AbstractString,
    fID :: AbstractString,
    ST = String,
    FT = Float64
)

    IDvec = listrectregions(fID)
    ind  = findall(IDvec.==ID)[1]

    IDinfo = readdlm(fID,',',comments=true,comment_char='#')[ind,:]
    pID,name,N,S,E,W = IDinfo[[2,7,3,5,6,4]]
    pID = replace(pID," "=>"")
    name = replace(name," "=>"")
    name = replace(name,"-"=>" ")

    is180,is360 = checkbounds(N,S,E,W)
    lon,lat = rect2shape(N,S,E,W)

    return RectRegion{ST,FT}(
        ID, pID, name, fID,
        [N, S, E, W], Point2.(lon,lat), is180, is360,
    )

end

function gettiltregion(
    ID  :: AbstractString,
    fID :: AbstractString,
    ST = String,
    FT = Float64
)

    IDvec = listrectregions(fID)
    ind  = findall(IDvec.==ID)[1]

    IDinfo = readdlm(fID,',',comments=true,comment_char='#')[ind,:]
    pID,name,X,Y,ΔX,ΔY,θ = IDinfo[[2,8,3,4,5,6,7]]
    pID = replace(pID," "=>"")
    name = replace(name," "=>"")
    name = replace(name,"-"=>" ")

    N,S,E,W = tilt2bounds(X,Y,ΔX,ΔY,θ)
    is180,is360 = checkbounds(N,S,E,W)
    lon,lat = tilt2shape(X,Y,ΔX,ΔY,θ)

    return TiltRegion{ST,FT}(
        ID, pID, name, fID,
        [N, S, E, W], Point2.(lon,lat), is180, is360,
        [X, Y, ΔX, ΔY, θ]
    )

end

function getpolyregion(
    ID  :: AbstractString,
    fID :: AbstractString,
    ST = String,
    FT = Float64
)

    IDvec = listpolyregions(fID)
    ind  = findall(IDvec.==ID)[1]
    ind  = (ind) * 4 + 1

    flines = readlines(fID)
    IDinfo = flines[ind];   pID,name = getpolyregionmeta(IDinfo)
    regIDX = flines[ind+1]; lon = getpolyregionx(regIDX)
    regIDY = flines[ind+2]; lat = getpolyregiony(regIDY)

    N = maximum(lat); S = minimum(lat)
    E = maximum(lon); W = minimum(lon)
    is180,is360 = checkbounds(N,S,E,W)

    return PolyRegion{ST,FT}(
        ID, pID, name, fID,
        [N, S, E, W], Point2.(lon,lat), is180, is360,
    )

end

function getpolyregionmeta(metastring::AbstractString)

    metastring = replace(metastring," "=>"")
    metastring = replace(metastring,"RegID"=>"")
    metastring = replace(metastring,"-"=>" ")
    return split(metastring,",")[2:3]

end

function getpolyregionx(xstring::AbstractString)

    xstring = replace(xstring," "=>"")
    xstring = replace(xstring,"RegX"=>"")
    return parse.(Float64,split(xstring,","))

end

function getpolyregiony(ystring::AbstractString)

    ystring = replace(ystring," "=>"")
    ystring = replace(ystring,"RegY"=>"")
    return parse.(Float64,split(ystring,","))

end