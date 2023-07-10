"""
    smooth!(
        lsd  :: LandSeaTopo;
        σlon :: Int = 0,
        σlat :: Int = 0,
        iterations :: Int = 100,
        topography :: Bool = false
    ) --> nothing

Perform a gaussian smoothing on the Land-Sea mask given a LandSeaTopo Mask dataset.  If `usetopography` is set to true, then before the filtering, any points where height >= 0 is set to 1, and <0 is set = 0.

The smoothed land-sea mask will be saved into `lsd.lsm`

Arguments
=========
- `lsd` : A Land-Sea Dataset with Topography

Keyword Arguments
=================
- `σlon` : Smooth in the longitude direction (every increase of 1 in σlon roughly corresponds to 8 pixels)
- `σlat` : Smooth in the latitude direction (every increase of 1 in σlat roughly corresponds to 8 pixels)
- `iterations` : Iterations of gausssian smoothing, the higher, the closer the smoothing follows a semi-log.  50-100 iterations is generally enough.
- `topography` : If `true`, then the land-sea mask that is smoothed will be based on the topography instead of the raw ERA5 land-sea mask
"""
function smooth!(
    lsd  :: LandSeaTopo;
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100,
    topography :: Bool = false
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end

    lsm  = lsd.lsm
	flsm = deepcopy(lsd.lsm)

    if topography
        olsm[lsd.z .>  0] .= 1
        olsm[lsd.z .<= 0] .= 0
    end
    
    it = 0
	while it < iterations
		flsm .= log10.(imfilter(10. .^flsm, Kernel.gaussian((σlon,σlat)),"circular"));
		flsm .= (flsm .+ lsm) / 2
		it   += 1
	end

    lsd.lsm .= flsm

    return nothing

end

"""
    smooth!(
        lsd  :: LandSeaFlat;
        σlon :: Int = 0,
        σlat :: Int = 0,
        iterations :: Int = 100
    ) --> nothing

Perform a gaussian smoothing on the Land-Sea mask given a LandSeaFlat Mask dataset.

The smoothed land-sea mask will be saved into `lsd.lsm`

Arguments
=========
- `lsd` : A Land-Sea Dataset without Topography

Keyword Arguments
=================
- `σlon` : Smooth in the longitude direction (every increase of 1 in σlon roughly corresponds to 8 pixels)
- `σlat` : Smooth in the latitude direction (every increase of 1 in σlat roughly corresponds to 8 pixels)
- `iterations` : Iterations of gausssian smoothing, the higher, the closer the smoothing follows a semi-log.  50-100 iterations is generally enough.
"""
function smooth!(
    lsd  :: LandSeaFlat;
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100,
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end

    flsm = deepcopy(lsd.lsm)

    it = 0
	while it < iterations
		flsm .= log10.(imfilter(10. .^flsm, Kernel.gaussian((σlon,σlat)),"circular"));
		flsm .= (flsm .+ lsm) / 2
		it   += 1
	end

    lsd.lsm .= flsm

    return nothing

end

"""
    smooth!(
        lsm  :: Array{<:Real,2};
        σlon :: Int = 0,
        σlat :: Int = 0,
        iterations :: Int = 100
    ) --> nothing

Perform a gaussian smoothing on the Land-Sea mask.

The smoothed land-sea mask will be saved into `lsm`.

Arguments
=========
- `lsm` : A Land-Sea Mask

Keyword Arguments
=================
- `σlon` : Smooth in the longitude direction (every increase of 1 in σlon roughly corresponds to 8 pixels)
- `σlat` : Smooth in the latitude direction (every increase of 1 in σlat roughly corresponds to 8 pixels)
- `iterations` : Iterations of gausssian smoothing, the higher, the closer the smoothing follows a semi-log.  50-100 iterations is generally enough.
"""
function smooth!(
    lsm  :: Array{<:Real,2};
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100,
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end

    flsm = deepcopy(lsm)

    it = 0
	while it < iterations
		flsm .= log10.(imfilter(10. .^flsm, Kernel.gaussian((σlon,σlat)),"circular"));
		flsm .= (flsm .+ lsm) / 2
		it   += 1
	end

    lsm .= flsm

    return nothing

end

"""
    smooth!(
        lsm  :: Array{<:Real,2},
        oro  :: Array{<:Real,2};
        σlon :: Int = 0,
        σlat :: Int = 0,
        iterations :: Int = 100
    ) --> nothing

Perform a gaussian smoothing on the Land-Sea mask given a corresponding topographic dataset.

The smoothed land-sea mask will be saved into `lsm`.

Arguments
=========
- `olsm` : The old Land-Sea Mask
- `oro` : A topographic dataset that the smoothing will be based off

Keyword Arguments
=================
- `σlon` : Smooth in the longitude direction (every increase of 1 in σlon roughly corresponds to 8 pixels)
- `σlat` : Smooth in the latitude direction (every increase of 1 in σlat roughly corresponds to 8 pixels)
- `iterations` : Iterations of gausssian smoothing, the higher, the closer the smoothing follows a semi-log.  50-100 iterations is generally enough.
"""
function smooth!(
    lsm :: Array{<:Real,2},
    oro  :: Array{<:Real,2};
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end

    tlsm = deepcopy(lsm)
    tlsm[oro .>  0] .= 1
    tlsm[oro .<= 0] .= 0
    flsm = deepcopy(lsm)
    
    it = 0
	while it < iterations
		flsm .= log10.(imfilter(10. .^flsm, Kernel.gaussian((σlon,σlat)),"circular"));
		flsm .= (flsm .+ lsm) / 2
		it   += 1
	end

    lsm .= flsm

    return nothing

end

"""
    smoothlsm(
        oro  :: Array{<:Real,2};
        σlon :: Int = 0,
        σlat :: Int = 0,
        iterations :: Int = 100
    ) --> Array{<:Real,2}

Perform a gaussian smoothing on the Land-Sea mask

Arguments
=========
- `oro` : A topographic dataset that the smoothing will be based off

Keyword Arguments
=================
- `σlon` : Smooth in the longitude direction (every increase of 1 in σlon roughly corresponds to 8 pixels)
- `σlat` : Smooth in the latitude direction (every increase of 1 in σlat roughly corresponds to 8 pixels)
- `iterations` : Iterations of gausssian smoothing, the higher, the closer the smoothing follows a semi-log.  50-100 iterations is generally enough.
"""
function smoothlsm(
    oro  :: Array{<:Real,2};
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100,
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end
    
    lsm  = deepcopy(oro)
    lsm[oro .>  0] .= 1
    lsm[oro .<= 0] .= 0
    flsm = deepcopy(oro)

    it = 0
	while it < iterations
	    flsm .= log10.(imfilter(10. .^flsm, Kernel.gaussian((σlon,σlat)),"circular"));
	    flsm .= (flsm .+ lsm) / 2
	    it   += 1
	end

    return flsm

end