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
		"The Tilted Rectilinear Region $(geo.ID) has the following properties:\n",
		"    Region ID    (ID) : ", geo.ID, '\n',
		"    Parent ID   (pID) : ", geo.pID, '\n',
		"    Name       (name) : ", geo.name, '\n',
		"    Position    (X,Y) : ",[geo.X,geo.Y], '\n',
		"    Size      (ΔX,ΔY) : ",[geo.ΔX,geo.ΔY], '\n',
		"    Tilt          (θ) : ",[geo.θ], '\n',
		"    Bounds  (N,S,E,W) : ",[geo.N,geo.S,geo.E,geo.W], '\n',
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