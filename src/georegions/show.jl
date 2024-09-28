function show(io::IO, geo::RectRegion)
    print(
		io,
		"The Rectilinear Region $(geo.ID) has the following properties:\n",
		"    Region ID     (ID) : ", geo.ID, '\n',
		"    Parent ID    (pID) : ", geo.pID, '\n',
		"    Name        (name) : ", geo.name, '\n',
		"    Bounds   (N,S,E,W) : ", geo.bound, '\n',
		"    Shape      (shape) : ", geo.shape, '\n',
	)
end

function show(io::IO, geo::TiltRegion)
    print(
		io,
		"The Tilted Rectilinear Region $(geo.ID) has the following properties:\n",
		"    Region ID     (ID) : ", geo.ID, '\n',
		"    Parent ID    (pID) : ", geo.pID, '\n',
		"    Name        (name) : ", geo.name, '\n',
		"    Bounds   (N,S,E,W) : ", geo.bound, '\n',
		"    Shape      (shape) : ", geo.shape, '\n',
		"    Tilt (X,Y,ΔX,ΔY,θ) : ", geo.tilt, '\n',
	)
end

function show(io::IO, geo::PolyRegion)
    print(
		io,
		"The Polygonal Region $(geo.ID) has the following properties:\n",
		"    Region ID     (ID) : ", geo.ID, '\n',
		"    Parent ID    (pID) : ", geo.pID, '\n',
		"    Name        (name) : ", geo.name,  '\n',
		"    Bounds   (N,S,E,W) : ", geo.bound, '\n',
		"    Shape      (shape) : ", geo.shape, '\n',
	)
end