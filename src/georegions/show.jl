function show(io::IO, geo::RectRegion)
    print(
		io,
		"The Rectilinear Region $(geo.ID) has the following properties:\n",
		"    Region ID    (ID) : ", geo.ID, '\n',
		"    Parent ID   (pID) : ", geo.pID, '\n',
		"    Name       (name) : ", geo.name, '\n',
		"    Bounds  (N,S,E,W) : ",[geo.N,geo.S,geo.E,geo.W], '\n',
        "        (is180,is360) : ",(geo.is180,geo.is360),"\n",
	)
end

function show(io::IO, geo::TiltRegion)
    print(
		io,
		"The Rectilinear Region $(geo.ID) has the following properties:\n",
		"    Region ID    (ID) : ", geo.ID, '\n',
		"    Parent ID   (pID) : ", geo.pID, '\n',
		"    Name       (name) : ", geo.name, '\n',
		"    Position    (X,Y) : ",[geo.X,geo.Y], '\n',
		"    Size      (ΔX,ΔY) : ",[geo.ΔX,geo.ΔY], '\n',
		"    Tilt 		   (θ) : ",[geo.θ], '\n',
        "        (is180,is360) : ",(geo.is180,geo.is360),"\n",
	)
end

function show(io::IO, geo::PolyRegion)
    print(
		io,
		"The Polygonal Region $(geo.ID) has the following properties:\n",
		"    Region ID    (ID) : ", geo.ID, '\n',
		"    Parent ID   (pID) : ", geo.pID, '\n',
		"    Name       (name) : ", geo.name,  '\n',
		"    Bounds  (N,S,E,W) : ",[geo.N,geo.S,geo.E,geo.W], '\n',
		"    Shape     (shape) : ", geo.shape, '\n',
        "        (is180,is360) : ",(geo.is180,geo.is360),"\n",
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

function show(io::IO, lsd::LandSeaTopo)
	nlon = length(lsd.lon)
	nlat = length(lsd.lat)
    print(
		io,
		"The Land-Sea Dataset (with Topography) has the following properties:\n",
		"    Longitude Points    (lon) : ", lsd.lon,  '\n',
		"    Latitude Points     (lat) : ", lsd.lat,  '\n',
		"    Region Size (nlon * nlat) : $(nlon) lon points x $(nlat) lat points\n",
	)
end

function show(io::IO, lsd::LandSeaFlat)
	nlon = length(lsd.lon)
	nlat = length(lsd.lat)
    print(
		io,
		"The Land-Sea Dataset (no Topography) has the following properties:\n",
		"    Longitude Points    (lon) : ", lsd.lon,  '\n',
		"    Latitude Points     (lat) : ", lsd.lat,  '\n',
		"    Region Size (nlon * nlat) : $(nlon) lon points x $(nlat) lat points\n",
	)
end