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
    geoID :: AbstractString,
    fname :: AbstractString,
    ST = String,
    FT = Float64
)

    rvec = listrectregions(fname)
    ind  = findall(rvec.==geoID)[1]

    IDinfo = readdlm(fname,',',comments=true,comment_char='#')[ind,:]
    ParID,name,N,S,E,W = IDinfo[[2,7,3,5,6,4]]
    ParID = replace(ParID," "=>"")
    name = replace(name," "=>"")
    name = replace(name,"-"=>" ")

    is180,is360 = checkbounds(N,S,E,W)

    return RectRegion{ST,FT}(
        geoID, ParID, name, fname,
        N, S, E, W, is180, is360,
    )

end

function gettiltregion(
    geoID :: AbstractString,
    fname :: AbstractString,
    ST = String,
    FT = Float64
)

    rvec = listrectregions(fname)
    ind  = findall(rvec.==geoID)[1]

    IDinfo = readdlm(fname,',',comments=true,comment_char='#')[ind,:]
    ParID,name,X,Y,ΔX,ΔY,θ = IDinfo[[2,8,3,4,5,6,7]]
    ParID = replace(ParID," "=>"")
    name = replace(name," "=>"")
    name = replace(name,"-"=>" ")

    N,S,E,W = tilt2bounds(X,Y,ΔX,ΔY,θ)
    is180,is360 = checkbounds(N,S,E,W)

    return TiltRegion{ST,FT}(
        geoID, ParID, name, fname,
        N, S, E, W, is180, is360,
        X, Y, ΔX, ΔY, θ,
    )

end

function getpolyregion(
    geoID :: AbstractString,
    fname :: AbstractString,
    ST = String,
    FT = Float64
)

    rvec = listpolyregions(fname)
    ind  = findall(rvec.==geoID)[1]
    ind  = (ind) * 4 + 1

    flines = readlines(fname)
    IDinfo = flines[ind];   ParID,RegName = getpolyregionmeta(IDinfo)
    regIDX = flines[ind+1]; X = getpolyregionx(regIDX)
    regIDY = flines[ind+2]; Y = getpolyregiony(regIDY)

    is180,is360 = checkbounds(maximum(Y),minimum(Y),maximum(X),minimum(X))

    return PolyRegion{ST,FT}(
        geoID, ParID, RegName, fname,
        maximum(Y), minimum(Y), maximum(X), minimum(X), is180, is360,
        Point2.(X,Y)
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