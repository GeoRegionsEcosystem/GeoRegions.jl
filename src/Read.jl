function GeoRegion(
    RegID::AbstractString,
    ST = String,
    FT = Float64
)

    regvec,filevec,typevec = listGeoRegions(); isgeoregion(RegID,regvec)
    ind = findall(RegID.==regvec)[1]
    return getgeoregion(
        RegID,
        filevec[ind],
        typevec[ind],
        ST,FT
    )

end

function getgeoregion(
    RegID :: AbstractString,
    fname :: AbstractString,
    GType :: AbstractString,
    ST = String,
    FT = Float64
)

    if GType == "PolyRegion"
          return PolyRegion(RegID,fname,ST,FT)
    else; return RectRegion(RegID,fname,ST,FT)
    end

end

function PolyRegion(
    RegID :: AbstractString,
    fname :: AbstractString,
    ST = String,
    FT = Float64
)

    rvec = listpolyregions(joinpath(DEPOT_PATH[1],"files","GeoRegions",fname))
    ind  = findall(rvec.==RegID)[1]
    ind  = (ind) * 4 + 1

    flines = readlines(joinpath(DEPOT_PATH[1],"files","GeoRegions",fname))
    IDinfo = flines[ind];   ParID,RegName = getpolymeta(IDinfo)
    regIDX = flines[ind+1]; X = getpolyx(regIDX)
    regIDY = flines[ind+2]; Y = getpolyy(regIDY)

    is180,is360 = checkbounds(maximum(Y),minimum(Y),maximum(X),minimum(X))

    return PolyRegion{ST,FT}(
        RegID,ParID,RegName,
        maximum(Y),minimum(Y),maximum(X),minimum(X),Point2.(X,Y),
        is180,is360
    )

end

function RectRegion(
    RegID :: AbstractString,
    fname :: AbstractString,
    ST = String,
    FT = Float64
)

    rvec = listrectregions(joinpath(DEPOT_PATH[1],"files","GeoRegions",fname))
    ind  = findall(rvec.==RegID)[1]

    IDinfo = readdlm(
        joinpath(DEPOT_PATH[1],"files","GeoRegions",fname),',',
        comments=true,comment_char='#'
    )[ind,:]
    ParID,RegName,regN,regS,regE,regW = IDinfo[[2,7,3,5,6,4]]

    is180,is360 = checkbounds(regN,regS,regE,regW)

    return RectRegion{ST,FT}(
        RegID,ParID,RegName,
        regN,regS,regE,regW,
        is180,is360
    )

end

function templateGeoRegions(;
    path      :: AbstractString=pwd(),
    overwrite :: Bool=false
)

    if !isdir(path); mkpath(path) end
    for fname in ["recttemplate.txt","polytemplate.txt"]

        ftem = joinpath(@__DIR__,"..","extra",fname)
        freg = joinpath(path,fname)

        if !overwrite
            if !isfile(freg)

                @debug "$(now()) - Unable to find $freg, copying data from $ftem ..."

                open(freg,"w") do io
                    open(ftem) do f
                        for line in readlines(f)
                            write(io,"$line\n")
                        end
                    end
                end

            end
        else

            if isfile(freg)
                @warn "$(now()) - Overwriting $freg with original file in $ftem ..."
                rm(freg,force=true)
            end

            open(freg,"w") do io
                open(ftem) do f
                    for line in readlines(f)
                        write(io,"$line\n")
                    end
                end
            end

        end

    end

    return

end

function listGeoRegions()

    flist   = ["rectlist.txt","polylist.txt","giorgi.txt","srex.txt","ar6.txt"]
    regvec  = []
    filevec = []
    typevec = []

    for fname in flist
        copygeoregions(fname)
        rvec,rtype = listgeoregions(joinpath(DEPOT_PATH[1],"files","GeoRegions",fname))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    return regvec,filevec,typevec

end

function resetGeoRegions(;allfiles=false)

    if allfiles
          flist = ["rectlist.txt","polylist.txt","giorgi.txt","srex.txt","ar6.txt"]
    else; flist = ["rectlist.txt","polylist.txt"]
    end

    for fname in flist
        copygeoregions(fname,overwrite=true)
    end

    return

end

function getpolymeta(metastring::AbstractString)

    metastring = replace(metastring," "=>"")
    metastring = replace(metastring,"RegID"=>"")
    metastring = replace(metastring,"-"=>" ")
    return split(metastring,",")[2:3]

end

function getpolyx(xstring::AbstractString)

    xstring = replace(xstring," "=>"")
    xstring = replace(xstring,"RegX"=>"")
    return parse.(Float64,split(xstring,","))

end

function getpolyy(ystring::AbstractString)

    ystring = replace(ystring," "=>"")
    ystring = replace(ystring,"RegY"=>"")
    return parse.(Float64,split(ystring,","))

end

function checkbounds(
    regN :: Real,
    regS :: Real,
    regE :: Real,
    regW :: Real
)

    if (regN>90) || (regN<-90)
        error("$(now()) - The latitude of the GeoRegion's northern bound at $regN is not valid.")
    end

    if (regS>90) || (regS<-90)
        error("$(now()) - The latitude of the GeoRegion's southern bound at $regS is not valid.")
    end

    if (regE>360) || (regE<-180)
        error("$(now()) - The longitude of the GeoRegion's eastern bound at $regE is not valid.")
    end

    if (regW>360) || (regW<-180)
        error("$(now()) - The longitude of the GeoRegion's western bound at $regW is not valid.")
    end

    if (regE - regW) > 360
        error("$(now()) - The GeoRegion cannot be more than 360º in Longitude.")
    end

    if regE < regW
        error("$(now()) - The eastern bound of the GeoRegion cannot be west of the western bound.")
    end

    if regN < regS
        error("$(now()) - The northern bound of the GeoRegion cannot be south of the southern bound.")
    end

    if regE > 180; is360 = true; else is360 = false end
    if regW < 0;   is180 = true; else is180 = false end
    if !(is180) && !(is360); is360 = true end

    return is180,is360

end

function copygeoregions(
    fname::AbstractString;
    overwrite::Bool=false
)

    jfol = joinpath(DEPOT_PATH[1],"files","GeoRegions"); mkpath(jfol);
    ftem = joinpath(@__DIR__,"..","extra",fname)
    freg = joinpath(jfol,fname)

    if !overwrite
        if !isfile(freg)

            @debug "$(now()) - Unable to find $freg, copying data from $ftem ..."

            open(freg,"w") do io
                open(ftem) do f
                    for line in readlines(f)
                        write(io,"$line\n")
                    end
                end
            end

        end
    else

        if isfile(freg)
            @warn "$(now()) - Overwriting $freg with original file in $ftem ..."
            rm(freg,force=true)
        end

        open(freg,"w") do io
            open(ftem) do f
                for line in readlines(f)
                    write(io,"$line\n")
                end
            end
        end

    end

    return

end

function listgeoregions(fname::AbstractString)

    gtype = readlines(fname)[1]
    if occursin("PolyRegion",gtype)
          return listpolyregions(fname), "PolyRegion"
    else; return listrectregions(fname), "RectRegion"
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

function isgeoregion(RegID::AbstractString,regvec::AbstractArray;throw::Bool=true)

    if sum(regvec.==RegID) == 0
        if throw
            error("$(now()) - $(RegID) is not a valid GeoRegion.  Use addgeoregion() to add this GeoRegion to the list.")
        else
            @warn "$(now()) - $(RegID) is not a valid GeoRegion.  Use addgeoregion() to add this GeoRegion to the list."
            return false
        end
    else;   return true
    end

end

function isgeoregion(RegID::AbstractString;throw::Bool=true)

    regvec,filevec,typevec = listGeoRegions()
    return isgeoregion(RegID,regvec;throw=throw)

end
