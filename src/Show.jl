function show(io::IO, geo::RectRegion)
    print(
		io,
		"The Rectilinear Region $(geo.regID) has the following properties:\n",
		"    Region ID     : ", geo.regID, '\n',
		"    Parent ID     : ", geo.parID, '\n',
		"    Name          : ", geo.name, '\n',
		"    Bounds        : [",geo.N,geo.S,geo.E,geo.W,"]\n",
        "    (is180,is360) : ",(geo.is180,geo.is360),"\n",
	)
end

function show(io::IO, geo::PolyRegion)
    print(
		io,
		"The Polygonal Region $(geo.regID) has the following properties:\n",
		"    Region ID     : ", geo.regID, '\n',
		"    Parent ID     : ", geo.parID, '\n',
		"    Name          : ", geo.name,  '\n',
		"    Bounds        : ",[geo.N,geo.S,geo.E,geo.W], '\n',
		"    Shape         : ", geo.shape, '\n',
        "    (is180,is360) : ",(geo.is180,geo.is360),"\n",
	)
end
