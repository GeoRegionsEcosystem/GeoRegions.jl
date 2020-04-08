"""
This set of functions allows the user to define regions based on a set of defined/default
list of region bounds (known as GeoRegions).  This includes the following functionalities:
    * Loading all available GeoRegions information / bounds
    * Loading information for a specific GeoRegion
    * Adding custom GeoRegions to the file (which is created automatically from the template gregiontemplate.txt)
    * A set of templated GeoRegions (preference given to Tropical/Asian regions) shown in the file gregiontemplate.txt

"""

## Load GeoRegion Information and Attributes

function gregioncopy(;overwrite::Bool=false)

    jfol = joinpath(DEPOT_PATH[1],"files/GeoRegions/"); mkpath(jfol);
    ftem = joinpath(@__DIR__,"gregionstemplate.txt")
    freg = joinpath(jfol,"gregions.txt")

    if !overwrite
        if !isfile(freg)
            @debug "$(Dates.now()) - Unable to find gregions.txt, copying data from gregionstemplate.txt ..."
            cp(ftem,freg,force=true);
        end
    else
        @warn "$(Dates.now()) - Overwriting gregions.txt in $jfol ..."
        cp(ftem,freg,force=true);
    end

    return freg

end

function gregioninfoload()
    @debug "$(Dates.now()) - Loading information on possible GeoRegions ..."
    return readdlm(gregioncopy(),',',comments=true);
end

function gregioninfodisplay(gregioninfo::AbstractArray)
    @info "$(Dates.now()) - The following GeoRegions are offered in the GeoRegions.jl"
    for ii = 1 : size(gregioninfo,1); @info "$(Dates.now()) - $(ii)) $(gregioninfo[ii,7])" end
end

function gregioninfoall()
    @info "$(Dates.now()) - The following GeoRegions and their properties are offered in the GeoRegions.jl"

    greginfo = gregioninfoload();
    head = ["ID","Parent","N","W","S","E","Full Name","Notes"];
    pretty_table(rinfo,head,alignment=:c);
end

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

function gregioninfoadd(;
    ID::AbstractString, parent::AbstractString,
    N::Integer, S::Integer, E::Integer, W::Integer,
    name::AbstractString, note::AbstractString="",
    throw::Bool=true
)

    note = "$(note).  Added to gregions.txt on $(Dates.now()).";

    freg = gregioncopy(); rinfo = gregioninfoload();
    gregID = rinfo[:,1]; gregparent = rinfo[:,2]; gregname = rinfo[:,7];

    if isgeoregion(ID,rinfo;throw=false)

        if sum(gregparent.==parent) == 0

            error("$(Dates.now()) - The GeoRegion $(parent) was defined to be the parent GeoRegion of $(ID), but the GeoRegion ID $(parent) cannot be found.  Please define the GeoRegion $(parent) and its properties.")

        else

            open(freg,"a") do io
                writedlm(io,[ID parent N S E W name note],',')
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
            gregioninfoadd(ID=ainfo[iadd,1],parent=ainfo[iadd,2],
                           N=ainfo[iadd,3],S=ainfo[iadd,5],W=ainfo[iadd,4],E=ainfo[iadd,6],
                           name=ainfo[iadd,7],throw=false,note=ainfo[iadd,8]);
        end

    elseif lprop == 7

        for iadd = 1 : nadd
            gregioninfoadd(ID=ainfo[iadd,1],parent=ainfo[iadd,2],
                           N=ainfo[iadd,3],S=ainfo[iadd,5],W=ainfo[iadd,4],E=ainfo[iadd,6],
                           name=ainfo[iadd,7],throw=false);
        end

    end

end

## Find GeoRegion Bounds

function gregionbounds(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    N,S,E,W = greginfo[ID,[3,5,6,4]];
    @debug "$(Dates.now()) - The bounds of the GeoRegion are, in [N,S,E,W] format, [$(N),$(S),$(E),$(W)]."
    return [N,S,E,W]
end

function gregionbounds(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    N,S,E,W = greginfo[ID,[3,5,6,4]];
    @debug "$(Dates.now()) - The bounds of the GeoRegion are, in [N,S,E,W] format, [$(N),$(S),$(E),$(W)]."
    return [N,S,E,W]
end

## Find Full GeoRegion Name

function gregionfullname(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    return greginfo[ID,7][1];
end

function gregionfullname(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,1];
    if isgeoregion(gregID,greginfo); ID = (gregions .== gregID); end
    return greginfo[ID,7][1];
end

## Find GeoRegion Parent

function gregionparent(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1];
    if isgeoregion(reg,greginfo); ID = (gregions .== gregID); end
    preg = greginfo[ID,2][1]; if isgeoregion(preg,greginfo); return preg; end
end

function gregionparent(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,1]; if isgeoregion(reg,greginfo); ID = (gregions .== gregID); end
    preg = greginfo[ID,2][1]; if isgeoregion(preg,greginfo); return preg; end
end

## Find GeoRegion Children

function gregionchild(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,2]; ID = (gregions .== gregID);
    cregions = greginfo[ID,:]; head = ["ID","Parent","N","W","S","E","Full Name"];
    pretty_table(cregions,head,alignment=:c);
end

function gregionchild(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,2]; ID = (gregions .== gregID);
    cregions = greginfo[ID,:]; head = ["ID","Parent","N","W","S","E","Full Name"];
    pretty_table(cregions,head,alignment=:c);
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

    reginfo = Dict("boundsID"=>igrid,"IDvec"=>[iWE,iNS],"fullname"=>gregionfullname(reg))

    return lon[iWE],lat[iNS],reginfo

end
