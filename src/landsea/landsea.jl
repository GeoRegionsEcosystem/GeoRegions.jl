"""
    getLandSea(
        geo  :: GeoRegion = GeoRegion("GLB");
        path :: AbstractString = homedir(),
        resolution :: Int = 60,
        bedrock   :: Bool = false,
        geoid     :: Bool = false,
        returnlsd :: Bool = false,
        savelsd   :: Bool = false,
        smooth    :: Bool = false,
        σlon :: Int = 0,
        σlat :: Int = 0,
        iterations :: Int = 100,
        FT = Float32
    ) -> LandSea

Retrieve ETOPO 2022 data for a GeoRegion from OPeNDAP servers

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
- `smooth` : If `smooth = true`, then you can smooth the land-sea mask using the Gaussian Filter of ImageFiltering.jl such that the coastline (i.e. the separation between land and ocean) becomes blurred.
- `σlon` : Smooth in the longitude direction (every increase of 1 in σlon roughly corresponds to 8 pixels)
- `σlat` : Smooth in the latitude direction (every increase of 1 in σlat roughly corresponds to 8 pixels)
- `iterations` : Iterations of gausssian smoothing, the higher, the closer the smoothing follows a semi-log.  50-100 iterations is generally enough.
"""
function getLandSea(
	geo  :: GeoRegion = GeoRegion("GLB");
    path :: AbstractString = homedir(),
    resolution :: Int = 60,
    bedrock   :: Bool = false,
    geoid     :: Bool = false,
    returnlsd :: Bool = false,
    savelsd   :: Bool = false,
    smooth    :: Bool = false,
    σlon :: Int = 0,
    σlat :: Int = 0,
    iterations :: Int = 100,
    FT = Float32
)

    if bedrock
        type = "bed"
    elseif geoid
        type = "geoid"
    else
        type = "surface"
    end

    if !(resolution==30) && !(resolution==60)
        error("$(modulelog()) - The only possible specifications for the resolution are 30 and 60 arc-seconds, an option for 15 arc-seconds may be added in the future once I figure out how to manage the 288 tiles for 15 arc-second data")
    end

    if smooth && (iszero(σlon) && iszero(σlat))
        error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
    end

    if savelsd

        if !isdir(joinpath(path,"ETOPO")); mkpath(joinpath(path,"ETOPO")) end

        if !smooth
            fid = "etopo-$(type)-$(geo.ID)_$(resolution)arcsec.nc"
        else
            fid = "etopo-$(type)-$(geo.ID)_$(resolution)arcsec-smooth_$(σlon)x$(σlat).nc"
        end
        lsmfnc = joinpath(path,"ETOPO",fid)

        if !isfile(lsmfnc)

            if smooth
                tgeo = geo
                mulf = resolution / 3600
                tN = geo.N + (ceil(σlat*20*mulf)+1); if tN >   90; tN =   90 end
                tS = geo.S - (ceil(σlat*20*mulf)+1); if tS <  -90; tS =  -90 end
                tE = geo.E + (ceil(σlon*20*mulf)+1); if tE >  360; tE =  360 end
                tW = geo.W - (ceil(σlon*20*mulf)+1); if tW < -180; tW = -180 end
                if (tE - tW) > 360; tW = 0; tE = 360 end
                geo = RectRegion(
                    "TMP", "GLB", "Temporary GeoRegion",
                    [tN,tS,tE,tW], savegeo = false
                )
            end

            @info "$(modulelog()) - The ETOPO $(uppercase(type)) Land-Sea mask dataset for the \"$(geo.ID)\" GeoRegion is not available, extracting from Global ETOPO $(uppercase(type)) Land-Sea mask dataset ..."

            glbfnc = joinpath(path,"ETOPO","etopo-$(type)-GLB_$(resolution)arcsec.nc")
            if !isfile(glbfnc); setupLandSea(type,path,resolution) end

            gds  = NCDataset(glbfnc)
            glon = gds["longitude"][:]
            glat = gds["latitude"][:]
            goro = gds["z"][:]
            close(gds)

            ggrd = RegionGrid(geo,glon,glat)
            nlon = length(ggrd.ilon)
            nlat = length(ggrd.ilat)

            @info "$(modulelog()) - Extracting regional ETOPO $(uppercase(type)) Land-Sea mask for the \"$(geo.ID)\" GeoRegion from the Global ETOPO Land-Sea mask dataset ..."

            roro = extractGrid(goro,ggrd)
            rlsm = deepcopy(roro)
            rlsm[roro .>= 0] .= 1
            rlsm[roro .<  0] .= 0

            if typeof(ggrd) <: PolyGrid
                  mask = ggrd.mask; mask[isnan.(mask)] .= 0
            else; mask = ones(Int,nlon,nlat)
            end

            if smooth

                smooth!(rlsm,roro,σlon=σlon,σlat=σlat,iterations=iterations)

                geo = tgeo
                ggrd = RegionGrid(geo,ggrd.lon,ggrd.lat)
                nlon = length(ggrd.ilon)
                nlat = length(ggrd.ilat)
    
                @info "$(modulelog()) - Extracting regional ETOPO $(uppercase(type)) Land-Sea mask for the \"$(geo.ID)\" GeoRegion from the Global ETOPO Land-Sea mask dataset ..."
    
                roro = extractGrid(roro,ggrd)
                rlsm = extractGrid(rlsm,ggrd)
    
                if typeof(ggrd) <: PolyGrid
                      mask = ggrd.mask; mask[isnan.(mask)] .= 0
                else; mask = ones(Int,nlon,nlat)
                end

            end

            saveLandSea(
                geo, ggrd.lon, ggrd.lat,
                rlsm, roro, Int16.(mask),
                path, type, resolution, smooth, σlon, σlat
            )

        end

        if returnlsd

            lds = NCDataset(lsmfnc)
            lon = lds["longitude"][:]
            lat = lds["latitude"][:]
            lsm = nomissing(lds["lsm"][:], NaN)
            oro = nomissing(lds["z"][:],   NaN)
            msk = lds["mask"][:]
            close(lds)

            @info "$(modulelog()) - Retrieving the regional ETOPO $(uppercase(type)) Land-Sea mask for the \"$(geo.ID)\" GeoRegion ..."

            return LandSea{FT}(lon,lat,lsm,oro,msk)

        else

            return nothing

        end
        
    else

        if smooth
            tgeo = geo
            mulf = resolution / 3600
            tN = geo.N + (ceil(σlat*20*mulf)+1); if tN >   90; tN =   90 end
            tS = geo.S - (ceil(σlat*20*mulf)+1); if tS <  -90; tS =  -90 end
            tE = geo.E + (ceil(σlon*20*mulf)+1); if tE >  360; tE =  360 end
            tW = geo.W - (ceil(σlon*20*mulf)+1); if tW < -180; tW = -180 end
            if (tE - tW) > 360; tW = 0; tE = 360 end
            geo = RectRegion(
                "TMP", "GLB", "Temporary GeoRegion",
                [tN,tS,tE,tW], savegeo = false
            )
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

        ggrd = RegionGrid(geo,lon,lat)
        ilon = ggrd.ilon; nlon = length(ggrd.ilon)
        ilat = ggrd.ilat; nlat = length(ggrd.ilat)
        rlsm = zeros(Float32,nlon,nlat)
        roro = zeros(Float32,nlon,nlat)

        if typeof(ggrd) <: PolyGrid
              mask = ggrd.mask; mask[isnan.(mask)] .= 0
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

        @info "$(modulelog()) - Extracting regional ETOPO1 Land-Sea mask for the \"$(geo.ID)\" GeoRegion from the Global ETOPO1 Land-Sea mask dataset ..."

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

        rlsm[roro .>= 0] .= 1
        rlsm[roro .<  0] .= 0

        @info "$(modulelog()) - Extracting the regional ETOPO1 Land-Sea mask for the \"$(geo.ID)\" has completed"

        if smooth

            smooth!(rlsm,roro,σlon=σlon,σlat=σlat,iterations=iterations)

            geo = tgeo
            ggrd = RegionGrid(geo,ggrd.lon,ggrd.lat)
            nlon = length(ggrd.ilon)
            nlat = length(ggrd.ilat)

            @info "$(modulelog()) - Extracting regional ETOPO $(uppercase(type)) Land-Sea mask for the \"$(geo.ID)\" GeoRegion from the Global ETOPO Land-Sea mask dataset ..."

            roro = extractGrid(roro,ggrd)
            rlsm = extractGrid(rlsm,ggrd)

            if typeof(ggrd) <: PolyGrid
                  mask = ggrd.mask; mask[isnan.(mask)] .= 0
            else; mask = ones(Int,nlon,nlat)
            end
            
        end

        return LandSea{FT}(ggrd.lon,ggrd.lat,rlsm,roro,mask)

    end

end

function downloadLandSea(
    type :: AbstractString,
    path :: AbstractString = homedir(),
    resolution :: Int = 60,
)

    eds = NCDataset(joinpath(
        "https://www.ngdc.noaa.gov/thredds/dodsC/global/ETOPO2022","$(resolution)s",
        "$(resolution)s_$(etopotype(type))_netcdf",
        "ETOPO_2022_v1_$(resolution)s_N90W180_$(type).nc"
    ))

    lon = eds["lon"][:]; nlon = length(lon)
    lat = eds["lat"][:]; nlat = length(lat); nstep = Int(nlat/1800)

    mask =  ones(Int16,nlon,nlat)
    lsm  = zeros(Float32,nlon,nlat)
    oro  = zeros(Float32,nlon,nlat)

    @info "$(modulelog()) - The Global ETOPO1 Land-Sea mask is too big to download at one-shot, splitting into $nstep regions ..."

    for istep = 1 : nstep

        @info "$(modulelog()) - Extracting Region $istep of $nstep ..."
        ilat = (1:1800)  .+ (istep-1) * 1800
        roro = @view oro[:,ilat]
        NCDatasets.load!(eds["z"].var,roro,:,ilat)

    end

    for ilat = 1 : nlat, ilon = 1 : nlon
        if oro[ilon,ilat] > 0
            lsm[ilon,ilat] = 1
        end
    end

    close(eds)

	saveLandSea(GeoRegion("GLB"),lon,lat,lsm,oro,mask,path,type,resolution)

end

function saveLandSea(
    geo  :: GeoRegion,
    lon  :: Vector{<:Real},
    lat  :: Vector{<:Real},
    lsm  :: Array{<:Real,2},
    oro  :: Array{<:Real,2},
    mask :: Array{Int16,2},
    path :: AbstractString,
    type :: AbstractString,
    eres :: Int,
    smooth :: Bool = false,
    σlon :: Int = 0,
    σlat :: Int = 0,
)

    if !smooth
        fnc = joinpath(path,"ETOPO","etopo-$(type)-$(geo.ID)_$(eres)arcsec.nc")
    else
        if iszero(σlon) && iszero(σlat)
            error("$(modulelog()) - Incomplete specification of smoothing parameters, at least one of σlon and σlat must be nonzero")
        end
        fnc = joinpath(path,"ETOPO",
            "etopo-$(type)-$(geo.ID)_$(eres)arcsec-smooth_$(σlon)x$(σlat).nc"
        )
    end

    if isfile(fnc)
        rm(fnc,force=true)
    end

    ds = NCDataset(fnc,"c",attrib = Dict(
        "Conventions" => "CF-1.5",
        "history"     => "Created on $(Dates.now()) by GeoRegions.jl",
        "GDAL_AREA_OR_POINT"     =>"Area",
        "node_offset"            => 1,
        "GDAL_TIFFTAG_COPYRIGHT" => "DOC/NOAA/NESDIS/NCEI > National Centers for Environmental Information, NESDIS, NOAA, U.S. Department of Commerce",
        "GDAL_TIFFTAG_DATETIME"  => 2.0220929123913e13,
        "GDAL_TIFFTAG_IMAGEDESCRIPTION" => "Topography-Bathymetry; EGM2008 height",
        "GDAL"                   => "GDAL 3.3.2, released 2021/09/01",
        "NCO"                    => "netCDF Operators version 4.9.1 (Homepage = http://nco.sf.net, Code = http://github.com/nco/nco)",
        "DODS.strlen"            => 0
    )) 

    ds.dim["longitude"] = length(lon)
    ds.dim["latitude"]  = length(lat)

    nclon = defVar(ds,"longitude",Float32,("longitude",),attrib = Dict(
        "units"     => "degrees_east",
        "long_name" => "longitude",
    ))

    nclat = defVar(ds,"latitude",Float32,("latitude",),attrib = Dict(
        "units"     => "degrees_north",
        "long_name" => "latitude",
    ))

    nclsm = defVar(ds,"lsm",Float32,("longitude","latitude",),attrib = Dict(
        "long_name" => "land_sea_mask",
        "full_name" => "Land-Sea Mask",
        "units"     => "0-1",
    ))

    ncoro = defVar(ds,"z",Float32,("longitude","latitude",),attrib = Dict(
        "long_name" => "height",
        "full_name" => "$(etoponamestring(type)) Height",
        "units"     => "m",
    ))

    ncmsk = defVar(ds,"mask",Int16,("longitude","latitude",),attrib = Dict(
        "long_name" => "georegion_mask",
        "full_name" => "GeoRegion Mask",
        "units"     => "0-1",
    ))

    nclon[:] = lon
    nclat[:] = lat
    nclsm[:] = lsm
    ncoro[:] = oro
    ncmsk[:] = mask

    close(ds)

end

function setupLandSea(
    type :: AbstractString,
    path :: AbstractString,
    resolution :: Int,
)

    @info "$(modulelog()) - The Global ETOPO $(uppercase(type)) Land-Sea mask dataset is not available, downloading from ETOPO OPeNDAP servers ..."
    downloadLandSea(type,path,resolution)

    gds  = NCDataset(joinpath(path,"ETOPO","etopo-$(type)-GLB_$(resolution)arcsec.nc"))
    glon = gds["longitude"][:]
    glat = gds["latitude"][:]
    goro = gds["z"][:]
    close(gds)

    ggrd = RegionGrid(GeoRegion("GLB"),glon,glat)
    nlon = length(ggrd.ilon)
    nlat = length(ggrd.ilat)
    mask = ones(Int,nlon,nlat)

    @info "$(modulelog()) - Extracting regional ETOPO $(uppercase(type)) Land-Sea mask for the \"GLB\" GeoRegion from the Global ETOPO Land-Sea mask dataset ..."
    
    roro = extractGrid(goro,ggrd)
    rlsm = deepcopy(roro)
    rlsm[roro .>= 0] .= 1
    rlsm[roro .<  0] .= 0

    saveLandSea(
        GeoRegion("GLB"),ggrd.lon,ggrd.lat,rlsm,roro,Int16.(mask),
        path,type,resolution
    )

end