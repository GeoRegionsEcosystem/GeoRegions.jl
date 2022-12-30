function etopotype(type::String)
    if type == "bed"
        return "bed_elev"
    elseif type == "geoid"
        return "geoid"
    else
        return "surface_elev"
    end
end

function getLandSea(
	geo  :: GeoRegion = GeoRegion("GLB");
    resolution :: Int,
    bedrock :: Bool = false,
    geoid   :: Bool = false,
    FT = Float32
)

    if bedrock
        type = "bed"
    elseif geoid
        type = "geoid"
    else
        type = "surface"
    end

    @info "$(modulelog()) - Opneing global ETOPO1 Land-Sea mask dataset from OPeNDAP servers ..."

    etopods = NCDataset(joinpath(
        "https://www.ngdc.noaa.gov/thredds/dodsC/global/ETOPO2022","$(resolution)s",
        "$(resolution)s_$(etopotype(type))_netcdf",
        "ETOPO_2022_v1_$(resolution)s_N90W180_$(type).nc"
    ))

    lon = etopods["lon"].var[:]; nlon = length(lon)
    lat = etopods["lat"].var[:]; nlat = length(lat)

    @info "$(modulelog()) - Extracting RegionGrid information for later extraction ..."

    rinfo = RegionGrid(geo,lon,lat)
    ilon  = rinfo.ilon; nlon = length(rinfo.ilon)
    ilat  = rinfo.ilat; nlat = length(rinfo.ilat)
    roro  = zeros(Float32,nlon,nlat)
    
    if typeof(rinfo) <: PolyGrid
          mask = rinfo.mask; mask[isnan.(mask)] .= 0
    else; mask = ones(Int16,nlon,nlat)
    end

    if ilon[1] > ilon[end]
		shift = true
		ilon1 = ilon[1] : nlon; nilon1 = length(ilon1)
		ilon2 = 1 : ilon[end];  nilon2 = length(ilon2)
		tmp1 = @view roro[:,1:nilon1]
		tmp2 = @view roro[:,(nilon1+1):nilon2]
	else
		shift = false
		ilon = ilon[1] : ilon[end]
	end

	if ilat[1] > ilat[end]
		ilat = ilat[1] : -1 : ilat[end]
	else
		ilat = ilat[1] : ilat[end]
	end

    @info "$(modulelog()) - Extracting regional ETOPO1 Land-Sea mask for the \"$(geo.regID)\" GeoRegion from the Global ETOPO1 Land-Sea mask dataset ..."

    if !shift
        NCDatasets.load!(etopods["z"].var,roro,ilon,ilat)
    else
        NCDatasets.load!(etopods["z"].var,tmp1,ilon1,ilat)
        NCDatasets.load!(etopods["z"].var,tmp2,ilon2,ilat)
    end

	close(etopods)

    for ilat = 1 : nlat, ilon = 1 : nlon
        if !isone(mask[ilon,ilat])
            roro[ilon,ilat] = NaN32
        end
    end

    return LandSea{FT}(rinfo.lon,rinfo.lat,roro,mask)

end