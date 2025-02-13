"""
    tableGeoRegions(;
        path :: AbstractString = homedir(),
        predefined :: Bool = true,
        giorgi     :: Bool = true,
        srex       :: Bool = true,
        ar6        :: Bool = true,
        custom     :: Bool = true,
        warn :: Bool = true,
        crop :: Bool = false,
        rows :: Int = 0
    ) -> nothing

Display all available GeoRegions in tabular format.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`.
- `predefined` : If `true`, predefined Giorgi, SREX and IPPC AR6 list of GeoRegions will be displayed.
- `giorgi` : If `true` AND `predefined = true`, display predefined GF GeoRegions. Default is `true`.
- `srex` : If `true` AND `predefined = true`, display predefined SREX GeoRegions. Default is `true`.
- `ar6` : If `true` AND `predefined = true`, display predefined IPCC AR6 GeoRegions. Default is `true`.
- `custom` : If `true`, custom, user-defined list of GeoRegions will be displayed.
- `warn` : If `true`, display warnings if custom files do not exist.
- `crop` : If `true`, will crop the vertical extent of the table, default is `false`.
"""
function tableGeoRegions(;
    path :: AbstractString = homedir(),
    predefined :: Bool = true,
    giorgi     :: Bool = true,
    srex       :: Bool = true,
    ar6        :: Bool = true,
    custom     :: Bool = true,
    warn :: Bool = true,
    crop :: Bool = false,
    rows :: Int = 0
)

    IDs    = []
    gpaths = []

    IDs,gpaths = fillinfo(IDs,gpaths,geopredefined,warn)
    IDs,gpaths = custom ? fillinfo(IDs,gpaths,geopath(path),warn) : (IDs,gpaths)
    if predefined
        IDs,gpaths = giorgi ? fillinfo(IDs,gpaths,gfdir,warn)   : (IDs,gpaths)
        IDs,gpaths = srex   ? fillinfo(IDs,gpaths,srexdir,warn) : (IDs,gpaths)
        IDs,gpaths = ar6    ? fillinfo(IDs,gpaths,ar6dir,warn)  : (IDs,gpaths)
    end

    ngeo = length(IDs)
    fmat = Array{Any,2}(undef,ngeo,6)

    for igeo = 1 : ngeo
        geo = GeoRegion(IDs[igeo],path=gpaths[igeo])
        fmat[igeo,1] = geo.ID
        # fmat[igeo,2] = typeof(geo)
        fmat[igeo,2] = geo.name
        fmat[igeo,3] = geo.pID
        fmat[igeo,4] = [geo.N, geo.S, geo.E, geo.W]
        fmat[igeo,5] = geo.θ
        fmat[igeo,6] = splitdir(gpaths[igeo])[end]
    end

    head = ["ID","Name","Parent","Bounds [N,S,E,W]","Rotation θ","Folder"]
    # head = ["ID","Type","Name","Parent","Bounds [N,S,E,W]","Rotation θ","Folder"]

    if !crop || rows < 15
        pretty_table(
            fmat,header=head,
            alignment=[:c,:l,:c,:c,:c,:c],
            # alignment=[:c,:c,:l,:c,:c,:c,:c],
            crop = :none, tf = tf_compact
        );
    else
        pretty_table(
            fmat,header=head,
            alignment=[:c,:l,:c,:c,:c,:c],
            # alignment=[:c,:c,:l,:c,:c,:c,:c],
            crop = :vertical, tf = tf_compact,
            vcrop_mode = :middle, display_size = (rows,-1)
        );
    end

    return nothing

end