function listall(
    path :: AbstractString = geodir
)

    flist    = ["rectlist.txt","polylist.txt","tiltlist.txt"]
    fdefined = ["giorgi.txt","srex.txt","ar6.txt"]

    regvec  = []
    filevec = []
    typevec = []

    for fname in flist
        copygeoregions(fname,path)
        rvec,rtype = listgeoregions(joinpath(path,fname))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    for fname in fdefined
        copygeoregions(fname,geodir)
        rvec,rtype = listgeoregions(joinpath(geodir,fname))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    return regvec,filevec,typevec

end

function listgeoregions(fname::AbstractString)

    gtype = readlines(fname)[1]
    if     occursin("PolyRegion",gtype)
        return listpolyregions(fname), "PolyRegion"
    elseif occursin("TiltRegion",gtype)
        return listtiltregions(fname), "TiltRegion"
    elseif occursin("RectRegion",gtype)
        return listrectregions(fname), "RectRegion"
    end

end

function listpolyregions(fname::AbstractString)

    gcount = -1
    for l in eachline(fname)
        if occursin("RegID",l); gcount += 1 end
    end

    regvec = Vector{String}(undef,gcount)
    gcount = -1
    for l in eachline(fname)
        if occursin("RegID",l)
            gcount += 1
            if gcount > 0
                l = replace(l," "=>"")
                l = replace(l,"RegID"=>"")
                regvec[gcount] = split(l,",")[1]
            end
        end
    end

    return regvec

end

function listrectregions(fname::AbstractString)

    return readdlm(fname,',',comments=true,comment_char='#')[:,1]

end

function listtiltregions(fname::AbstractString)

    gcount = 0
    for l in eachline(fname)
        if (!occursin("#",l)) || (l == ""); gcount += 1 end
    end

    if gcount > 0
         return readdlm(fname,',',comments=true,comment_char='#')[:,1]
    else return []
    end

end