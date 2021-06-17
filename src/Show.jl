function show(io::IO, geo::RectRegion)
    print(
		io,
		"The Rectilinear Region $(geo.regID) has the following properties:\n",
		"    Region ID (regID) : ", geo.regID, '\n',
		"    Parent ID (parID) : ", geo.parID, '\n',
		"    Name      (name)  : ", geo.name, '\n',
		"    Bounds    (bound) : ",[geo.N,geo.S,geo.E,geo.W], '\n',
        "        (is180,is360) : ",(geo.is180,geo.is360),"\n",
	)
end

function show(io::IO, geo::PolyRegion)
    print(
		io,
		"The Polygonal Region $(geo.regID) has the following properties:\n",
		"    Region ID (regID) : ", geo.regID, '\n',
		"    Parent ID (parID) : ", geo.parID, '\n',
		"    Name       (name) : ", geo.name,  '\n',
		"    Bounds    (bound) : ",[geo.N,geo.S,geo.E,geo.W], '\n',
		"    Shape     (shape) : ", geo.shape, '\n',
        "        (is180,is360) : ",(geo.is180,geo.is360),"\n",
	)
end

function show(io::IO, grd::PolyGrid)
	nlon = length(grd.ilon)
	nlat = length(grd.ilat)
    print(
		io,
		"The Polygonal Grid has the following properties:\n",
		"    Grid Bounds       (igrid) : ", grd.igrid, '\n',
		"    Longitude Indices  (ilon) : ", grd.ilon,  '\n',
		"    Latitude Indices   (ilat) : ", grd.ilat,  '\n',
		"    Longitude Points   (glon) : ", grd.glon,  '\n',
		"    Latitude Points    (glat) : ", grd.glat,  '\n',
		"    Region Size (nlon * nlat) : $(nlon) lon points x $(nlat) lat points\n",
		"    Region Mask (sum(mask) / (nlon * nlat)) : $(sum(grd.mask)) / $(nlon*nlat)\n"
	)
end

function show(io::IO, grd::RectGrid)
	nlon = length(grd.ilon)
	nlat = length(grd.ilat)
    print(
		io,
		"The Rectilinear Grid has the following properties:\n",
		"    Grid Bounds       (igrid) : ", grd.igrid, '\n',
		"    Longitude Indices  (ilon) : ", grd.ilon,  '\n',
		"    Latitude Indices   (ilat) : ", grd.ilat,  '\n',
		"    Longitude Points   (glon) : ", grd.glon,  '\n',
		"    Latitude Points    (glat) : ", grd.glat,  '\n',
		"    Region Size (nlon * nlat) : $(nlon) lon points x $(nlat) lat points\n",
	)
end
