function listall(
    path :: AbstractString = homedir()
)

    flist    = ["rectlist.txt","polylist.txt","tiltlist.txt"]
    fdefined = ["global.txt","giorgi.txt","srex.txt","ar6.txt"]

    rvec  = []
    fvec = []
    tvec = []

    for fname in flist
        rvec,fvec,tvec = fillinfo(rvec,fvec,tvec,joinpath(path,fname))
    end

    for fname in fdefined
        rvec,fvec,tvec = fillinfo(rvec,fvec,tvec,joinpath(geodir,fname))
    end

    return rvec,fvec,tvec

end

function fillinfo(regvec,filevec,typevec,fID)

    rvec,rtype = listgeoregions(fID)
    regvec = vcat(regvec,rvec)
    nreg = length(rvec)
    fvec = fill(basename(fID),nreg); filevec = vcat(filevec,fvec)
    tvec = fill(rtype,nreg);         typevec = vcat(typevec,tvec)

    return regvec,filevec,typevec

end

function fillinfo(regvec,filevec,typevec,dirvec,fID)

    rvec,rtype = listgeoregions(fID)
    regvec = vcat(regvec,rvec)
    nreg = length(rvec)
    fvec = fill(basename(fID),nreg); filevec = vcat(filevec,fvec)
    tvec = fill(rtype,nreg);         typevec = vcat(typevec,tvec)
    dvec = fill(dirname(fID),nreg);  dirvec  = vcat(dirvec,dvec)

    return regvec,filevec,typevec,dirvec

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

    gcount = 0
    for l in eachline(fname)
        if (!occursin("#",l)) || (l == ""); gcount += 1 end
    end

    if gcount > 0
         return readdlm(fname,',',comments=true,comment_char='#')[:,1]
    else return []
    end

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