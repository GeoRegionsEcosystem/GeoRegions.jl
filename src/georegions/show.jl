function show(io::IO, geo::GeoRegion)
    print(io,
		"The GeoRegion $(geo.ID) has the following properties:\n",
		"    Region ID      (ID) : ", geo.ID, 		  	 		  '\n',
		"    Parent ID     (pID) : ", geo.pID, 			 		  '\n',
		"    Name         (name) : ", geo.name, 				  '\n',
		"    Bounds    (N,S,E,W) : ", geo.N, geo.S, geo.E, geo.W, '\n',
		"    Rotation        (θ) : ", geo.θ, 		 			  '\n',
		"    Shape       (shape) : ", geo.geometry.shape, 		  '\n',
		"    File Path    (path) : ", geo.path, 		 		  '\n',
	)
end