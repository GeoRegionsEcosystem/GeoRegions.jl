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