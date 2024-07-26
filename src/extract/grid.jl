"""
    extractGrid(
        odata :: AbstractArray{<:Real,N},
        ggrd  :: RegionGrid
    ) where N <: Int -> Array{<:Real,N}

Extracts data from odata, an Array of dimension N (where N ∈ 2,3,4) that contains data of a Parent `GeoRegion`, into another Array of dimension N, containing _**only**_ within a sub `GeoRegion` we are interested in.

!!! warning
    Please ensure that the 1st dimension is longitude and 2nd dimension is latitude before proceeding. The order of the 3rd and 4th dimensions (when used), however, is not significant.

Arguments
=========
- `odata` : An array of dimension N containing gridded data in the region we are interesting in extracting from
- `ggrd` : A `RegionGrid` containing detailed information on what to extract
"""
function extractGrid(
    odata :: AbstractArray{<:Real,2},
    ggrd  :: RectGrid
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
	ndata = zeros(nlon,nlat)
	for glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat] = odata[ilon[glon],ilat[glat]]
	end

    return ndata

end

"""
    extractGrid!(
        odata :: AbstractArray{<:Real,N},
        ndata :: AbstractArray{<:Real,N},
        ggrd  :: RegionGrid
    ) where N <: Int -> nothing

Extracts data from odata, an Array of dimension N (where N ∈ 2,3,4) that contains data of a Parent `GeoRegion`, into ndata, another Array of dimension N, containing _**only**_ within a sub `GeoRegion` we are interested in.

This allows for iterable in-place modification to save memory space and reduce allocations if the dimensions are fixed.

!!! warning
    Please ensure that the 1st dimension is longitude and 2nd dimension is latitude before proceeding. The order of the 3rd and 4th dimensions (when used), however, is not significant.

Arguments
=========
- `odata` : An array of dimension N containing gridded data in the region we are interesting in extracting from
- `ndata` : An array of dimension N meant as a placeholder for the extracted data to minimize allocations
- `ggrd` : A `RegionGrid` containing detailed information on what to extract
"""
function extractGrid!(
    ndata :: AbstractArray{<:Real,2},
    odata :: AbstractArray{<:Real,2},
    ggrd  :: RectGrid
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
	for glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat] = odata[ilon[glon],ilat[glat]]
	end

    return

end

function extractGrid(
    odata :: AbstractArray{<:Real,2},
    ggrd  :: Union{TiltGrid,PolyGrid}
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
    mask  = ggrd.mask
	ndata = zeros(nlon,nlat)
	for glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat] = odata[ilon[glon],ilat[glat]] * mask[glon,glat]
	end

    return ndata

end

function extractGrid!(
    ndata :: AbstractArray{<:Real,2},
    odata :: AbstractArray{<:Real,2},
    ggrd  :: Union{TiltGrid,PolyGrid}
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
    mask  = ggrd.mask
	for glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat] = odata[ilon[glon],ilat[glat]] * mask[glon,glat]
	end

    return

end

function extractGrid(
    odata :: AbstractArray{<:Real,3},
    ggrd  :: RectGrid
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
	ndata = zeros(nlon,nlat,n3D)
	for i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D] = odata[ilon[glon],ilat[glat],i3D]
	end

    return ndata

end

function extractGrid!(
    ndata :: AbstractArray{<:Real,3},
    odata :: AbstractArray{<:Real,3},
    ggrd  :: RectGrid
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
	for i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D] = odata[ilon[glon],ilat[glat],i3D]
	end

    return

end

function extractGrid(
    odata :: AbstractArray{<:Real,3},
    ggrd  :: Union{TiltGrid,PolyGrid}
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
    ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
    mask  = ggrd.mask
	ndata = zeros(nlon,nlat,n3D)
	for i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D] = odata[ilon[glon],ilat[glat],i3D] * mask[glon,glat]
	end

    return ndata

end

function extractGrid!(
    ndata :: AbstractArray{<:Real,3},
    odata :: AbstractArray{<:Real,3},
    ggrd  :: Union{TiltGrid,PolyGrid}
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
    mask  = ggrd.mask
	for i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D] = odata[ilon[glon],ilat[glat],i3D] * mask[glon,glat]
	end

    return

end

function extractGrid(
    odata :: AbstractArray{<:Real,4},
    ggrd  :: RectGrid
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
                       n4D  = size(odata,4)
	ndata = zeros(nlon,nlat,n3D,n4D)
	for i4D = 1 : n4D, i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D,i4D] = odata[ilon[glon],ilat[glat],i3D,i4D]
	end

    return ndata

end

function extractGrid!(
    ndata :: AbstractArray{<:Real,4},
    odata :: AbstractArray{<:Real,4},
    ggrd  :: RectGrid
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
                       n4D  = size(odata,4)
	for i4D = 1 : n4D, i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D,i4D] = odata[ilon[glon],ilat[glat],i3D,i4D]
	end

    return

end

function extractGrid(
    odata :: AbstractArray{<:Real,4},
    ggrd  :: Union{TiltGrid,PolyGrid}
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
    ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
                       n4D  = size(odata,4)
    mask  = ggrd.mask
	ndata = zeros(nlon,nlat,n3D,n4D)
	for i4D = 1 : n4D, i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D,i4D] = odata[ilon[glon],ilat[glat],i3D,i4D] * mask[glon,glat]
	end

    return ndata

end

function extractGrid!(
    ndata :: AbstractArray{<:Real,4},
    odata :: AbstractArray{<:Real,4},
    ggrd  :: Union{TiltGrid,PolyGrid}
)

    ilon  = ggrd.ilon; nlon = length(ggrd.ilon)
	ilat  = ggrd.ilat; nlat = length(ggrd.ilat)
                       n3D  = size(odata,3)
                       n4D  = size(odata,4)
    mask  = ggrd.mask
	for i4D = 1 : n4D, i3D = 1 : n3D, glat in 1 : nlat, glon in 1 : nlon
		ndata[glon,glat,i3D,i4D] = odata[ilon[glon],ilat[glat],i3D,i4D] * mask[glon,glat]
	end

    return

end