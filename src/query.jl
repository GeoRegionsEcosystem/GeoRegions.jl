"""
This set of functions allows the user to define regions based on a set of defined/default
list of region bounds (known as GeoRegions).  This includes the following functionalities:
    * Loading all available GeoRegions information / bounds
    * Loading information for a specific GeoRegion
    * Adding custom GeoRegions to the file (which is created automatically from the template gregiontemplate.txt)
    * A set of templated GeoRegions (preference given to Tropical/Asian regions) shown in the file gregiontemplate.txt

"""

## Load GeoRegion Information and Attributes

"""
    gregioncopy(; overwrite=false) -> String

Check if a `gregions.txt` file exists in the directory `JULIA_DEPOT_PATH/files/GeoRegions/`.  If the file does not exist, copy a template from the default list in `GeoRegions.txt`. Alternatively, if one wants to override an existing `gregions.txt` file, use the `overwrite` keyword.

Keyword Arguments:
* `overwrite` : if set to `true`, overwrite any existing `gregions.txt` file.
"""
function gregioncopy(;overwrite::Bool=false)

    jfol = joinpath(DEPOT_PATH[1],"files/GeoRegions/"); mkpath(jfol);
    ftem = joinpath(@__DIR__,"gregionslist.txt")
    freg = joinpath(jfol,"gregions.txt")

    info = readdlm(ftem,',',comments=true);
    nadd = size(info,1)

    if !overwrite
        if !isfile(freg)
            @debug "$(Dates.now()) - Unable to find gregions.txt, copying data from gregionslist.txt ..."
            cp(ftem,freg,force=true);
        end
    else

        if isfile(freg)
            @warn "$(Dates.now()) - Overwriting gregions.txt in $jfol ..."
        end

        open(freg,"w") do io
            write(io,"# (1)ID,(2)pID,(3)N,(4)W,(5)S,(6)E,(7)Description,(8)Notes")
        end

        for iadd = 1 : nadd
            gregioninfoaddclean(
                ID=info[iadd,1],parent=info[iadd,2],
                N=info[iadd,3],S=info[iadd,5],W=info[iadd,4],E=info[iadd,6],
                name=info[iadd,7],throw=false,note=info[iadd,8]
            );
        end

    end

    return freg

end

"""
    gregioninfoload() -> Array{Any,2}

Load information on existing `GeoRegion`s and export into an Array.
"""
function gregioninfoload()
    @debug "$(Dates.now()) - Loading information on possible GeoRegions ..."
    return readdlm(gregioncopy(),',',comments=true);
end

"""
    gregioninfodisplay(gregioninfo) -> nothing

Takes an Array containing information on existing `GeoRegion`s (the output from `gregioninfoload()`) and print into `@info` statements.
"""
function gregioninfodisplay(gregioninfo::AbstractArray)
    @info "$(Dates.now()) - The following GeoRegions are offered in the GeoRegions.jl"
    for ii = 1 : size(gregioninfo,1); @info "$(Dates.now()) - $(ii)) $(gregioninfo[ii,7])" end
end

"""
    gregioninfoall() -> nothing

Load information on existing `GeoRegions` and print in REPL using PrettyTables backends.  Does not return anything else.
"""
function gregioninfoall()

    @info "$(Dates.now()) - The following GeoRegions and their properties are offered in the GeoRegions.jl"

    greginfo = gregioninfoload();
    head = ["ID","pID","N","W","S","E","Full Name","Notes"];

    pretty_table(
        greginfo,head,
        alignment=[:c,:c,:c,:c,:c,:c,:l,:l],
        tf=compact
    );

end

"""
    isgeoregion(ID; throw=true) -> Bool

Checks if `ID` is a valid `GeoRegion` identifier.
"""
function isgeoregion(greg::AbstractString;throw::Bool=true)

    rinfo = gregioninfoload(); gregID = rinfo[:,1];
    if sum(gregID.==greg) == 0
        if throw
            error("$(Dates.now()) - $(greg) is not a valid GeoRegion.  If this is not a typo, then use gregioninfoadd() to gregions.txt.")
        else
            @warn "$(Dates.now()) - The GeoRegion ID $(greg) has not been added to gregions.txt."
            return false
        end
    else;   return true
    end

end

"""
    isgeoregion(ID, gregioninfo; throw=true) -> Bool

Checks if `ID` is a valid `GeoRegion` identifier based on the Array of information provided by `gregioninfo`.
"""
function isgeoregion(greg::AbstractString,gregioninfo::AbstractArray;throw::Bool=true)

    gregID = gregioninfo[:,1];
    if sum(gregID.==greg) == 0
        if throw
            error("$(Dates.now()) - $(greg) is not a valid GeoRegion.  If this is not a typo, then use gregioninfoadd() to gregions.txt.")
        else
            @warn "$(Dates.now()) - The GeoRegion ID $(greg) has not been added to gregions.txt."
            return false
        end
    else;   return true
    end

end


## Manipulation of GeoRegion Data

function gregiontemplate(fdir::AbstractString="")

    if fdir == ""; fdir = pwd(); end

    jfol = joinpath(DEPOT_PATH[1],"files/GeoRegions/"); mkpath(jfol);
    ftem = joinpath(@__DIR__,"gregionstemplate.txt")
    freg = joinpath(fdir,"gregionsadd.txt")

    cp(ftem,freg,force=true);

    return freg

end

function gregioninfoadd(;
    ID::AbstractString, parent::AbstractString,
    N::Integer, S::Integer, E::Integer, W::Integer,
    name::AbstractString, note::AbstractString="",
    throw::Bool=true
)

    note = "$(note).  Added to gregions.txt on $(Dates.now()).";

    freg = gregioncopy(); rinfo = gregioninfoload();
    gregID = rinfo[:,1]; gregname = rinfo[:,7];

    if !isgeoregion(ID,rinfo;throw=false)

        if sum(gregID.==parent) == 0

            error("$(Dates.now()) - The GeoRegion $(parent) was defined to be the parent GeoRegion of $(ID), but the GeoRegion ID $(parent) cannot be found.  Please define the GeoRegion $(parent) and its properties.")

        else

            open(freg,"a") do io
                writedlm(io,[ID parent N W S E name note],',')
            end

        end

    else

        if throw
            error("$(Dates.now()) - The GeoRegion ID $(ID) is already in use.  Please choose a new GeoRegion ID.")
        else
            @info "$(Dates.now()) - GeoRegion ID $(ID) has already been added to gregions.txt in $(freg)"
        end

    end

end

function gregioninfoadd(fadd::AbstractString)

    if !isfile(fadd); error("$(Dates.now()) - The file $(fadd) does not exist."); end
    ainfo = readdlm(fadd,',',comments=true); agregID = ainfo[:,1]; nadd = length(agregID);
    lprop = size(ainfo,2);

    if lprop == 8

        for iadd = 1 : nadd
            gregioninfoadd(
                ID=ainfo[iadd,1],parent=ainfo[iadd,2],
                N=ainfo[iadd,3],S=ainfo[iadd,5],W=ainfo[iadd,4],E=ainfo[iadd,6],
                name=ainfo[iadd,7],throw=false,note=ainfo[iadd,8]
            );
        end

    elseif lprop == 7

        for iadd = 1 : nadd
            gregioninfoadd(
                ID=ainfo[iadd,1],parent=ainfo[iadd,2],
                N=ainfo[iadd,3],S=ainfo[iadd,5],W=ainfo[iadd,4],E=ainfo[iadd,6],
                name=ainfo[iadd,7],throw=false,
                note="Custom User-Defined GeoRegion"
            );
        end

    end

end

function gregioninfoaddclean(;
    ID::AbstractString, parent::AbstractString,
    N::Integer, S::Integer, E::Integer, W::Integer,
    name::AbstractString, note::AbstractString="",
    throw::Bool=true
)

    freg = gregioncopy(); open(freg,"a") do io
        writedlm(io,[ID parent N W S E name note],',')
    end

end

function gregioninform(ID::AbstractString)

    freg = gregioncopy(); rinfo = gregioninfoload();

    if isgeoregion(ID,rinfo;throw=false)

        rID = rinfo[:,1]; ninfo = rinfo[rID.!=ID,:]; nadd = size(ninfo,1)
        freg = gregioncopy();
        open(freg,"w") do io
            write(io,"# (1)ID,(2)pID,(3)N,(4)W,(5)S,(6)E,(7)Description,(8)Notes")
        end

        for iadd = 1 : nadd
            gregioninfoaddclean(
                ID=ninfo[iadd,1],parent=ninfo[iadd,2],
                N=ninfo[iadd,3],S=ninfo[iadd,5],W=ninfo[iadd,4],E=ninfo[iadd,6],
                name=ninfo[iadd,7],throw=false,note=ninfo[iadd,8]
            );
        end

        @info "$(Dates.now()) - The GeoRegion ID $(ID) has been succesfully removed from gregions.txt in $(freg)."

    else

        @warn "$(Dates.now()) - The GeoRegion ID $(ID) that you want to remove does not exist in gregions.txt in $(freg)."

    end

end

## Find GeoRegion Bounds

"""
    gregionbounds(ID) -> Vector{Int64}

Finds the bounds of a given `GeoRegion` represented by `ID`.  If `ID` is not valid, then the function throws an error.
"""
function gregionbounds(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    N,S,E,W = greginfo[ID,[3,5,6,4]];
    @debug "$(Dates.now()) - The bounds of the GeoRegion are, in [N,S,E,W] format, [$(N),$(S),$(E),$(W)]."
    return [N,S,E,W]
end

"""
    gregionbounds(ID, gregioninfo) -> Vector{Int64}

Finds the bounds of a given `GeoRegion` represented by `ID`, using the info provided in `gregioninfo()`.  If `ID` is not valid, then the function throws an error.
"""
function gregionbounds(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    N,S,E,W = greginfo[ID,[3,5,6,4]];
    @debug "$(Dates.now()) - The bounds of the GeoRegion are, in [N,S,E,W] format, [$(N),$(S),$(E),$(W)]."
    return [N,S,E,W]
end

## Find Full GeoRegion Name

"""
    gregionfullname(ID) -> String

Finds the full name description of a given `GeoRegion` represented by `ID`.  If `ID` is not valid, then the function throws an error.
"""
function gregionfullname(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    return greginfo[ID,7][1];
end

"""
    gregionfullname(ID, gregioninfo) -> String

Finds the full name description of a given `GeoRegion` represented by `ID`, using the info provided in `gregioninfo()`.  If `ID` is not valid, then the function throws an error.
"""
function gregionfullname(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    return greginfo[ID,7][1];
end

## Find GeoRegion Parent

"""
    gregionparent(ID; levels=1) -> String

Finds the Parent ID `pID` of a given `GeoRegion` represented by `ID`.  If `ID` is not valid, then the function throws an error.
"""
function gregionparent(gregID::AbstractString;levels::Integer=1)
    greginfo = gregioninfoload(); gregions = greginfo[:,1];
    for ilvl = 1 : levels
        if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
        gregID = greginfo[ID,2][1];
    end
    if isgeoregion(gregID,greginfo); return gregID; end
end

"""
    gregionparent(ID, gregioninfo; levels=1) -> String

Finds the Parent ID `pID` of a given `GeoRegion` represented by `ID`, using the info provided in `gregioninfo()`.  If `ID` is not valid, then the function throws an error.
"""
function gregionparent(gregID::AbstractString,greginfo::AbstractArray;levels::Integer=1)
    gregions = greginfo[:,1];
    for ilvl = 1 : levels
        if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
        gregID = greginfo[ID,2][1];
    end
    if isgeoregion(gregID,greginfo); return gregID; end
end

## Find GeoRegion Children

function gregionchild(gregID::AbstractString;throw=true)

    greginfo = gregioninfoload(); gregions = greginfo[:,2]; ID = (gregions .== gregID);

    if sum(ID) != 0
        cregions = greginfo[ID,:]; head = ["ID","pID","N","W","S","E","Full Name","Notes"];
        pretty_table(cregions,head,alignment=[:c,:c,:c,:c,:c,:c,:l,:l],tf=compact);
        return cregions[:,1];
    else
        if throw
            error("$(Dates.now()) - The GeoRegion $(gregID) has no child GeoRegion defined.")
        else
            @warn "$(Dates.now()) - The GeoRegion $(gregID) has no child GeoRegion defined."
        end
    end

end

function gregionchild(gregID::AbstractString,greginfo::AbstractArray;throw=true)

    gregions = greginfo[:,2]; ID = (gregions .== gregID);

    if sum(ID) != 0
        cregions = greginfo[ID,:]; head = ["ID","pID","N","W","S","E","Full Name","Notes"];
        pretty_table(cregions,head,alignment=[:c,:c,:c,:c,:c,:c,:l,:l],tf=compact);
        return cregions[:,1];
    else
        if throw
            error("$(Dates.now()) - The GeoRegion $(gregID) has no child GeoRegion defined.")
        else
            @warn "$(Dates.now()) - The GeoRegion $(gregID) has no child GeoRegion defined."
        end
    end

end

##

function gregiongridvec(reg::AbstractString,lon::Vector{<:Real},lat::Vector{<:Real})

    @debug "$(Dates.now()) - Determining indices of longitude and latitude boundaries in the given dataset ..."
    bounds = gregionbounds(reg); igrid = regiongrid(bounds,lon,lat);
    iN = igrid[1]; iS = igrid[2]; iE = igrid[3]; iW = igrid[4];

    @debug "$(Dates.now()) - Creating vector of latitude indices to extract ..."
    if     iN < iS; iNS = iN : iS
    elseif iS < iN; iNS = iS : iN
    else;           iNS = iN;
    end

    @debug "$(Dates.now()) - Creating vector of longitude indices to extract ..."
    if     iW < iE; iWE = iW : iE
    elseif iW > iE || (iW == iE && bounds[3] != bounds[4])
        iWE = 1 : (iE + length(lon) + 1 - iW);
        lon[1:(iW-1)] = lon[1:(iW-1)] .+ 360; lon = circshift(lon,1-iW);
    else
        iWE = iW;
    end

    reginfo = Dict(
        "gridindices"=>igrid, "lonlatindices"=>[iWE,iNS],
        "fullname"=>gregionfullname(reg)
    )

    return lon[iWE],lat[iNS],reginfo

end
