"""
    GeoRegion(RegID::AbstractString) -> geo::GeoRegion

Extracts information of the GeoRegion with the ID `RegID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========

- `RegID` : The keyword ID that will be used to identify the GeoRegion.
            If the ID is not valid (i.e. not being used), then an error will be thrown.

Returns
=======

- `geo` : A GeoRegion
"""
function GeoRegion(
    RegID::AbstractString,
    ST = String,
    FT = Float64
)

    @info "$(modulelog()) - Retrieving information for the GeoRegion defined by the ID $RegID"

    regvec,filevec,typevec = listGeoRegions(); isgeoregion(RegID,regvec)
    ind = findall(RegID.==regvec)[1]
    return getgeoregion(
        RegID,
        joinpath(DEPOT_PATH[1],"files","GeoRegions",filevec[ind]),
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

    rvec = listpolyregions(fname)
    ind  = findall(rvec.==RegID)[1]
    ind  = (ind) * 4 + 1

    flines = readlines(fname)
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

    rvec = listrectregions(fname)
    ind  = findall(rvec.==RegID)[1]

    IDinfo = readdlm(fname,',',comments=true,comment_char='#')[ind,:]
    ParID,RegName,regN,regS,regE,regW = IDinfo[[2,7,3,5,6,4]]
    ParID = replace(ParID," "=>"")
    RegName = replace(RegName," "=>"")
    RegName = replace(RegName,"-"=>" ")

    is180,is360 = checkbounds(regN,regS,regE,regW)

    return RectRegion{ST,FT}(
        RegID,ParID,RegName,
        regN,regS,regE,regW,
        is180,is360
    )

end

"""
    templateGeoRegions(; path::AbstractString, overwrite::Bool=false)

Copies the template files for defining GeoRegions in textfiles, that can then be added as a batch using addGeoRegions()

Keyword Arguments
=================

- `path`      : The folder to copy the files to
- `overwrite` : If template files exist in this folder, overwrite?
"""
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

                @debug "$(modulelog()) - Unable to find $freg, copying data from $ftem ..."

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
                @warn "$(modulelog()) - Overwriting $freg with original file in $ftem ..."
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

    return nothing

end

"""
    listGeoRegions()

List all GeoRegions, files the data are stored in, and the `Type` of `GeoRegion` they are.

Output
======

- `geovec`  : List of all the GeoRegion IDs
- `filevec` : List of the files that the GeoRegion information is stored in
- `typevec` : List of the `Type` of the `GeoRegion` corresponding to the `geovec` ID list
"""
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

"""
    resetGeoRegions(; allfiles::Bool = false)

Reset all the files containing GeoRegion information back to the default.

Arguments
=========

- `allfiles` : If `true`, reset the GeoRegions defined in Giorgi & Francisco [2000], AR6 Regions (Iturbide et al., 2020; ESSD) and Seneviratne et al. [2012] as well.  If `false`, only reset the custom GeoRegions.
"""
function resetGeoRegions(;allfiles=false)

    if allfiles

        @info "$(modulelog()) - Resetting both the master and custom lists of GeoRegions back to the default"
        flist = ["rectlist.txt","polylist.txt","giorgi.txt","srex.txt","ar6.txt"]
    else
        @info "$(modulelog()) - Resetting the custom lists of GeoRegions back to the default"
        flist = ["rectlist.txt","polylist.txt"]
    end

    for fname in flist
        copygeoregions(fname,overwrite=true)
    end

    return

end

"""
    addGeoRegions(fname::AbstractString)

Extracts information of the GeoRegion with the ID `RegID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========

- `fname` : name + path of the file containing GeoRegion information
"""
function addGeoRegions(
    fname     :: AbstractString;
    overwrite :: Bool = false
)

    @info "$(modulelog()) - Importing user-defined GeoRegions from the file $fname directly into the custom lists"

    rvec,rtype = listgeoregions(fname)
    for reg in rvec
        if !isGeoRegion(reg,throw=false)
            g = getgeoregion(reg,fname,rtype)
            if rtype == "PolyRegion"
                  _,_,lon,lat = coordGeoRegion(g)
                  PolyRegion(g.regID,g.parID,g.name,lon,lat)
            else; RectRegion(g.regID,g.parID,g.name,[g.N,g.S,g.E,g.W])
            end
        elseif overwrite
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Overwriting and replacing with new boundaries ..."
            removeGeoRegion(reg)
            g = getgeoregion(reg,fname,rtype)
            if rtype == "PolyRegion"
                  _,_,lon,lat = coordGeoRegion(g)
                  PolyRegion(g.regID,g.parID,g.name,lon,lat)
            else; RectRegion(g.regID,g.parID,g.name,[g.N,g.S,g.E,g.W])
            end
        else
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Please use a different ID, or you can remove the ID using removeGeoRegion()."
        end
    end

    return nothing

end

function readGeoRegions(
    fname   :: AbstractString;
    savegeo :: Bool = true
)

    @info "$(modulelog()) - Reading user-defined GeoRegions from the file $fname directly into the custom lists"

    rvec,rtype = listgeoregions(fname)
    ngeo = length(rvec)
    gvec = Vector{GeoRegion}(undef,ngeo)
    for igeo in 1 : ngeo
        reg = rvec[igeo]
        if !isGeoRegion(reg,throw=false)
            g = getgeoregion(reg,fname,rtype)
            if rtype == "PolyRegion"
                  _,_,lon,lat = coordGeoRegion(g)
                  geo = PolyRegion(g.regID,g.parID,g.name,lon,lat,savegeo=savegeo)
            else; geo = RectRegion(g.regID,g.parID,g.name,[g.N,g.S,g.E,g.W],savegeo=savegeo)
            end
        else
            @warn "$(modulelog()) - The GeoRegion ID $reg is already in use. Please use a different ID, or you can remove the ID using removeGeoRegion()."
        end
        gvec[igeo] = geo
    end

    return gvec

end

"""
    isGeoRegion(
        RegID :: AbstractString;
        throw :: Bool = true
    ) -> tf :: Bool

Extracts information of the GeoRegion with the ID `RegID`.  If no GeoRegion with this ID exists, an error is thrown.

Arguments
=========

- `RegID` : The keyword ID that will be used to identify the GeoRegion.
        If the ID is not valid (i.e. not being used), then an error will be thrown.
- `throw` : If `true`, then throws an error if `RegID` is not a valid `GeoRegion` identifier instead of returning the Boolean `tf`

Returns
=======

- `tf` : True / False
"""
function isGeoRegion(RegID::AbstractString;throw::Bool=true)

    regvec,_,_ = listGeoRegions()
    return isgeoregion(RegID,regvec;throw=throw,dolog=true)

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
        error("$(modulelog()) - The latitude of the GeoRegion's northern bound at $regN is not valid.")
    end

    if (regS>90) || (regS<-90)
        error("$(modulelog()) - The latitude of the GeoRegion's southern bound at $regS is not valid.")
    end

    if (regE>360) || (regE<-180)
        error("$(modulelog()) - The longitude of the GeoRegion's eastern bound at $regE is not valid.")
    end

    if (regW>360) || (regW<-180)
        error("$(modulelog()) - The longitude of the GeoRegion's western bound at $regW is not valid.")
    end

    if (regE - regW) > 360
        error("$(modulelog()) - The GeoRegion cannot be more than 360º in Longitude.")
    end

    if regE < regW
        error("$(modulelog()) - The eastern bound of the GeoRegion cannot be west of the western bound.")
    end

    if regN < regS
        error("$(modulelog()) - The northern bound of the GeoRegion cannot be south of the southern bound.")
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

            @debug "$(modulelog()) - Unable to find $freg, copying data from $ftem ..."

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
            @warn "$(modulelog()) - Overwriting $freg with original file in $ftem ..."
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

function isgeoregion(
    RegID  :: AbstractString,
    regvec :: AbstractArray;
    throw  :: Bool = true,
    dolog  :: Bool = false)

    if dolog
        @info "$(modulelog()) - Checking to see if the ID $RegID is in use"
    end

    if sum(regvec.==RegID) == 0
        if throw
            error("$(modulelog()) - $(RegID) is not a valid GeoRegion identifier, use either RectRegion() or PolyRegion() to add this GeoRegion to the list.")
        else
            @warn "$(modulelog()) - $(RegID) is not a valid GeoRegion identifier, use either RectRegion() or PolyRegion() to add this GeoRegion to the list."
            return false
        end
    else
        if dolog; @info "$(modulelog()) - The ID $RegID is already in use" end
        return true
    end

end
