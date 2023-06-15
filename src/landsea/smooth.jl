"""
    smooth(
        lsd :: LandSeaTopo;
        usetopography :: false
    ) --> 

Perform a gaussian smoothing on the Land-Sea mask given a LandSeaTopo Mask dataset.  If `usetopography` is set to true, then before the filtering, any points where height >= 0 is set to 1, and <0 is set = 0.

Arguments
=========
- `geo` : The GeoRegion of interest

Keyword Arguments
=================
- `path` :: The path to which an `ETOPO` folder is created within and ETOPO LandSea data saved into
- `resolution` : The resolution of the dataset to be downloaded, in units of arc-seconds.  Possible values are 15, 30 and 60, default is 60.
- `bedrock`, `geoid` : The type of ETOPO data (bedrock, geoid, ice-surface) to be downloaded. Bedrock has priority over geoid, so if both are `true`, the bedrock is downloaded.
- `savelsd` : Save LandSea dataset into a local NetCDF file.
- `returnlsd` : If `savelsd = true`, you can choose to simply save the data into the NetCDF file, or load return it as a `LandSea` dataset. Otherwise, if `savelsd = false`, you always return the `LandSea` dataset.
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

    olsm = deepcopy(lsd.lsm)
	flsm = deepcopy(lsd.lsm)

    if topography
        olsm[lsd.z .>= 0] .= 1
        olsm[lsd.z .<  0] .= 0
    end
    
    it = 0
	while it < iterations
        olsm .= flsm
		flsm  = log10.(imfilter(10. .^olsm, Kernel.gaussian((σlon,σlat)),"circular"));
		flsm .= (flsm .+ olsm) / 2
		it   += 1
	end

    lsd.lsm .= flsm

    return 

end

function smooth!(
    lsd  :: LandSeaFlat;
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100,
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end

    olsm = deepcopy(lsd.lsm)
    flsm = deepcopy(lsd.lsm)

    it = 0
	while it < iterations
        olsm .= flsm
		flsm  = log10.(imfilter(10. .^olsm, Kernel.gaussian((σlon,σlat)),"circular"));
		flsm .= (flsm .+ olsm) / 2
		it   += 1
	end

    lsd.lsm .= flsm

    return

end

function smooth!(
    lsm  :: Array{<:Real,2},
    oro  :: Array{<:Real,2};
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end

    olsm = deepcopy(lsm)

    if topography
        olsm[oro.>=0] .= 1
        olsm[oro.< 0] .= 0
    end
    
    it = 0
	while it < iterations
        olsm .= lsm
		lsm   = log10.(imfilter(10. .^olsm, Kernel.gaussian((σlon,σlat)),"circular"));
		lsm  .= (lsm .+ olsm) / 2
		it   += 1
	end

    return 

end

function smooth!(
    lsm  :: Array{<:Real,2},
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100,
)

    if iszero(σlon) && iszero(σlat)
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end
    
    olsm = deepcopy(lsm)

    it = 0
	while it < iterations
        olsm .= lsm
		lsm   = log10.(imfilter(10. .^olsm, Kernel.gaussian((σlon,σlat)),"circular"));
		lsm  .= (lsm .+ olsm) / 2
		it   += 1
	end

    return

end