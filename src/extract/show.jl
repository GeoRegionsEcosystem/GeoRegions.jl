function show(io::IO, grd::RectGrid)
	nlon = length(grd.ilon)
	nlat = length(grd.ilat)
    print(
		io,
		"The Rectilinear Grid has the following properties:\n",
		"    Grid Bounds       (grid) : ", grd.grid, '\n',
		"    Longitude Indices (ilon) : ", grd.ilon, '\n',
		"    Latitude Indices  (ilat) : ", grd.ilat, '\n',
		"    Longitude Points   (lon) : ", grd.lon,  '\n',
		"    Latitude Points    (lat) : ", grd.lat,  '\n',
		"    Region Size (nlon * nlat) : $(nlon) lon points x $(nlat) lat points\n",
	)
end

function show(io::IO, grd::PolyGrid)
	nlon = length(grd.ilon)
	nlat = length(grd.ilat)
	mask = grd.mask
    print(
		io,
		"The Polygonal Grid has the following properties:\n",
		"    Grid Bounds       (grid) : ", grd.grid, '\n',
		"    Longitude Indices (ilon) : ", grd.ilon, '\n',
		"    Latitude Indices  (ilat) : ", grd.ilat, '\n',
		"    Longitude Points   (lon) : ", grd.lon,  '\n',
		"    Latitude Points    (lat) : ", grd.lat,  '\n',
		"    Region Size (nlon * nlat) : $(nlon) lon points x $(nlat) lat points\n",
		"    Region Mask (sum(mask) / (nlon * nlat)) : $(sum(isone.(mask))) / $(nlon*nlat)\n"
	)
end

function show(io::IO, grd::RegionMask)
	nlon = size(grd.lon,1)
	nlat = size(grd.lon,2)
    print(
		io,
		"The RegionGrid is of the RegionMask type has the following properties:\n",
		"    Grid Size (nlon * nlat) : $(nlon) lon points x $(nlat) lat points\n",
		"    Valid Mask Proportion   : $(sum(isone.(grd.mask))) / $(nlon*nlat)\n",
	)
end