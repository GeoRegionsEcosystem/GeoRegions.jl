"""
    tableGeoRegions(;
        path :: AbstractString = homedir(),
        predefined :: Bool = true,
        custom     :: Bool = true,
        warn :: Bool = true,
        crop :: Bool = false
    ) -> nothing

Display all available GeoRegions in tabular format.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`.
- `predefined` : If `true`, predefined Giorgi, SREX and IPPC AR6 list of GeoRegions will be displayed.
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
    crop :: Bool = false
)

    IDs    = []
    gpaths = []

    IDs,gpaths = fillinfo(IDs,gpaths,geodir,warn)
    custom ? (IDs,gpaths = fillinfo(IDs,gpaths,geopath(path),warn)) : nothing
    if predefined
        giorgi ? (IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geodir,"GF"),warn)) : nothing
        srex ? (IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geodir,"SREX"),warn)) : nothing
        ar6 ?   (IDs,gpaths = fillinfo(IDs,gpaths,joinpath(geodir,"AR6"),warn)) : nothing
    end

    ngeo = size(rvec,1)
    fmat = Array{Any,2}(undef,ngeo,6)

    for igeo = 1 : ngeo
        geo = GeoRegion(IDs[igeo],path=gpaths[igeo])
        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = "GeoRegion"
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = geo.bound
        fmat[igeo,6] = splitdir(gpaths[igeo])[end]
    end

    head = ["ID","Type","Name","Parent","Bounds [N,S,E,W]","Folder"];

    if !crop
        pretty_table(
            fmat,header=head,
            alignment=[:c,:c,:l,:c,:c,:c],
            crop = :none, tf = tf_compact
        );
    else
        pretty_table(
            fmat,header=head,
            alignment=[:c,:c,:l,:c,:c,:c],
            crop = :vertical, tf = tf_compact
        );
    end

    return nothing

end

"""
    tableGeoRegions(
        fname :: AbstractString
    ) -> nothing

Display all available GeoRegions in tabular format listed in the file `fname`.

Arguments
=========
- `fname` : Specifies the name + path of the file containing GeoRegion information.
"""
function tableGeoRegions(
    fname :: AbstractString
)

    rvec,rtype = listgeoregions(fname)
    ngeo = size(rvec,1)
    fmat = Array{Any,2}(undef,ngeo,6)

    for igeo = 1 : ngeo
        g = getgeoregion(rvec[igeo],fname,rtype)
        fmat[igeo,1] = g.ID
        fmat[igeo,2] = rtype
        fmat[igeo,3] = g.name
        fmat[igeo,4] = g.pID
        fmat[igeo,5] = geo.bound
        fmat[igeo,6] = basename(fname)
    end

    head = ["ID","Type","Name","Parent","Bounds [N,S,E,W]","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end