"""
This set of functions allows the user to define regions based on a set of defined/default
list of region bounds (known as GeoRegions).  This includes the following functionalities:
    * Loading all available GeoRegions information / bounds
    * Loading information for a specific GeoRegion
    * Adding custom GeoRegions to the file (which is created automatically from the template gregiontemplate.txt)
    * A set of templated GeoRegions (preference given to Tropical/Asian regions) shown in the file gregiontemplate.txt

"""

## GeoRegion Information and Attributes

function gregioncopy()
    ftem = joinpath(@__DIR__,"gregionstemplate.txt")
    freg = joinpath(@__DIR__,"gregions.txt")
    if !isfile(freg)
        @debug "$(Dates.now()) - Unable to find gregions.txt, copying data from gregionstemplate.txt ..."
        cp(ftem,freg,force=true);
    end
end

function gregioninfoload()
    @debug "$(Dates.now()) - Loading information on possible GeoRegions ..."
    gregioncopy(); return readdlm(joinpath(@__DIR__,"gregions.txt"),',',comments=true);
end

function gregioninfodisplay(gregioninfo::AbstractArray)
    @info "$(Dates.now()) - The following GeoRegions are offered in the GeoRegions.jl"
    for ii = 1 : size(gregioninfo,1); @info "$(Dates.now()) - $(ii)) $(gregioninfo[ii,7])" end
end

function gregioninfoall()
    @info "$(Dates.now()) - The following GeoRegions and their properties are offered in the GeoRegions.jl"

    greginfo = gregioninfoload(); head = ["ID","Parent","N","W","S","E","Full Name"];
    pretty_table(rinfo,head,alignment=:c);
end

function gregioninfoadd(;
    ID::AbstractString,parent::AbstractString,
    N::Integer,S::Integer,E::Integer,W::Integer,
    name::AbstractString
)

    freg = joinpath(@__DIR__,"gregions.txt"); rinfo = gregioninfoload();
    gregID = rinfo[:,1]; gregparent = rinfo[:,2]; gregname = rinfo[:,7];

    if sum(gregID.==ID) > 0
        error("$(Dates.now()) - GeoRegion ID already exists.  Please choose a new ID.")
    end

    open(freg,"a") do io
        writedlm(io,[ID parent N S E W name],',')
    end

end

## Find GeoRegion Bounds

function gregionbounds(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1]; ID = (gregions .== gregID);
    N,S,E,W = greginfo[ID,[3,5,6,4]];
    @debug "$(Dates.now()) - The bounds of the GeoRegion are, in [N,S,E,W] format, [$(N),$(S),$(E),$(W)]."
    return [N,S,E,W]
end

function gregionbounds(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,1]; ID = (gregions .== gregID);
    N,S,E,W = greginfo[ID,[3,5,6,4]];
    @debug "$(Dates.now()) - The bounds of the GeoRegion are, in [N,S,E,W] format, [$(N),$(S),$(E),$(W)]."
    return [N,S,E,W]
end

## Find Full GeoRegion Name

function gregionfullname(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1]; ID = (gregions .== gregID);
    return greginfo[ID,7][1];
end

function gregionfullname(gregID::AbstractString,greginfo::AbstractArray)
    gregions = greginfo[:,1]; ID = (gregions .== gregID);
    return greginfo[ID,7][1];
end

## Find GeoRegion Parent

function gregionparent(gregID::AbstractString)
    greginfo = gregioninfoload(); gregions = greginfo[:,1]; ID = (gregions .== gregID);
    return greginfo[ID,2][1];
end

function gregionparent(gregID::AbstractString,greginfo::AbstractArray)
    ggregions = greginfo[:,1]; ID = (gregions .== gregID);
    return greginfo[ID,2][1];
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

    @debug "$(Dates.now()) - Determining indices of longitude and latitude boundaries in the parent GeoRegion dataset ..."
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
