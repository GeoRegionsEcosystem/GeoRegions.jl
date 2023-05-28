function etopotype(type::String)
    if type == "bed"
        return "bed_elev"
    elseif type == "geoid"
        return "geoid"
    else
        return "surface_elev"
    end
end

function etoponamestring(type::String)
    if type == "bed"
        return "Bedrock"
    elseif type == "geoid"
        return "Geoid"
    else
        return "Surface"
    end
end

"""
    getLandSea(
        geo :: GeoRegion = GeoRegion("GLB");
        resolution :: Int,
        bedrock   :: Bool = false,
        geoid     :: Bool = false,
        returnlsd :: Bool = false,
        savelsd   :: Bool = false,
        FT = Float32
    ) -> LandSea

Retrieve ETOPO 2022 data for a GeoRegion from OPeNDAP servers

Arguments
=========
- `geo` : The GeoRegion of interest

Keyword Arguments
=================
- `resolution` : The resolution of the dataset to be downloaded, in units of arc-seconds.  Possible values are 15, 30 and 60, default is 60.
- `bedrock`, `geoid` : The type of ETOPO data (bedrock, geoid, ice-surface) to be downloaded. Bedrock has priority over geoid, so if both are `true`, the bedrock is downloaded.
- `savelsd` : Save LandSea dataset into a local NetCDF file.
- `returnlsd` : If `savelsd = true`, you can choose to simply save the data into the NetCDF file, or load return it as a `LandSea` dataset. Otherwise, if `savelsd = false`, you always return the `LandSea` dataset.
"""
function getLandSea(
	geo :: GeoRegion = GeoRegion("GLB");
    path :: AbstractString = homedir(),
    resolution :: Int = 60,
    bedrock   :: Bool = false,
    geoid     :: Bool = false,
    returnlsd :: Bool = false,
    savelsd   :: Bool = false,
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

    if savelsd

        if !isdir(joinpath(path,"ETOPO")); mkpath(joinpath(path,"ETOPO")) end

        lsmfnc = joinpath(path,"ETOPO","etopo-$(type)-$(geo.ID)_$(resolution)arcsec.nc")

        if !isfile(lsmfnc)

            @info "$(modulelog()) - The ETOPO $(uppercase(type)) Land-Sea mask dataset for the \"$(geo.ID)\" GeoRegion is not available, extracting from Global ETOPO $(uppercase(type)) Land-Sea mask dataset ..."

            glbfnc = joinpath(path,"ETOPO","etopo-$(type)-GLB_$(resolution)arcsec.nc")
            if !isfile(glbfnc)
                @info "$(modulelog()) - The Global ETOPO $(uppercase(type)) Land-Sea mask dataset is not available, downloading from ETOPO OPeNDAP servers ..."
                downloadLandSea(type,path,resolution)
            end

            gds  = NCDataset(glbfnc)
            glon = gds["longitude"][:]
            glat = gds["latitude"][:]
            goro = gds["z"][:]
            close(gds)

            rinfo = RegionGrid(geo,glon,glat)
            ilon  = rinfo.ilon; nlon = length(rinfo.ilon)
            ilat  = rinfo.ilat; nlat = length(rinfo.ilat)
            rlsm  = zeros(nlon,nlat)
            roro  = zeros(nlon,nlat)

            if typeof(rinfo) <: PolyGrid
                mask = rinfo.mask; mask[isnan.(mask)] .= 0
            else; mask = ones(Int,nlon,nlat)
            end

            @info "$(modulelog()) - Extracting regional ETOPO $(uppercase(type)) Land-Sea mask for the \"$(geo.ID)\" GeoRegion from the Global IMERG Land-Sea mask dataset ..."

            for iglat = 1 : nlat, iglon = 1 : nlon
                if isone(mask[iglon,iglat])
                    roro[iglon,iglat] = goro[ilon[iglon],ilat[iglat]]
                    if roro[iglon,iglat] > 0
                        rlsm[iglon,iglat] = 1
                    else; rlsm[iglon,iglat] = 0
                    end
                else
                    roro[iglon,iglat] = NaN
                    rlsm[iglon,iglat] = NaN
                end
            end

            saveLandSea(geo,rinfo.lon,rinfo.lat,rlsm,roro,Int16.(mask),path,type,resolution)

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
        rlsm  = zeros(Float32,nlon,nlat)
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
                rlsm[ilon,ilat] = NaN32
            else
                if roro[ilon,ilat] > 0
                      rlsm[ilon,ilat] = 1
                else; rlsm[ilon,ilat] = 0
                end
            end
        end

        return LandSea{FT}(rinfo.lon,rinfo.lat,rlsm,roro,mask)

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

    lon = eds["lon"][:]; nlon = length(lon); nlonstep = Int(nlon/5400)
    lat = eds["lat"][:]; nlat = length(lat); nlatstep = Int(nlat/5400)

    mask =  ones(Int16,nlon,nlat)
    lsm  = zeros(Float32,nlon,nlat)
    oro  = zeros(Float32,nlon,nlat)

    for ilatstep = 1 : nlatstep, ilonstep = 1 : nlonstep

        @info [ilonstep,ilatstep]
        ilon = (1:5400) .+ (ilonstep-1) * 5400
        ilat = (1:5400) .+ (ilatstep-1) * 5400
        NCDatasets.load!(eds["z"].var,oro[ilon,ilat],ilon,ilat)

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
    eres :: Int
)

    fnc = joinpath(path,"ETOPO","etopo-$(type)-$(geo.ID)_$(eres)arcsec.nc")
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