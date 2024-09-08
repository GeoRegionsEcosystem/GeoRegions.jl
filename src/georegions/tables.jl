"""
    tableGeoRegions(;
        path :: AbstractString = homedir(),
        predefined :: Bool = true,
        custom     :: Bool = true,
        warn   :: Bool = true
    ) -> nothing

Display all available GeoRegions in tabular format.
Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`
- `predefined` : If true, predefined Giorgi, SREX and IPPC AR6 list of GeoRegions will be displayed.
- `custom` : If true, custom, user-defined list of GeoRegions will be displayed.
- `warn` : If true, display warnings if custom files do not exist
"""
function tableGeoRegions(;
    path :: AbstractString = homedir(),
    predefined :: Bool = true,
    custom     :: Bool = true,
    warn       :: Bool = true
)

    flist = ["rectlist.txt","polylist.txt","tiltlist.txt"]
    fdefined = ["giorgi.txt","srex.txt","ar6.txt"]

    rvec = []
    fvec = []
    dvec = []
    tvec = []

    rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,joinpath(geodir,"global.txt"))

    if custom
        for fname in flist
            fID = joinpath(path,fname)
            if isfile(fID)
                rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,fID)
            else
                if warn
                    @warn "$(modulelog) - The custom file does \"$fname\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
                end
            end
        end
    end

    if predefined
        for fname in fdefined
            fID = joinpath(geodir,fname)
            rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,fID)
        end
    end

    ngeo = size(rvec,1)
    fmat = Array{Any,2}(undef,ngeo,6)

    for igeo = 1 : ngeo
        geo = getgeoregion(rvec[igeo],joinpath(dvec[igeo],fvec[igeo]),tvec[igeo])
        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = tvec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = [geo.N, geo.S, geo.E, geo.W]
        fmat[igeo,6] = fvec[igeo]
    end

    head = ["ID","Type","Name","Parent","Bounds [N,S,E,W]","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end

"""
    tableGeoRegions(
        fname :: AbstractString
    ) -> nothing

Display all available GeoRegions in tabular format listed in the file `fname`.

Arguments
=========
- `fname` : Specifies the name + path of the file containing GeoRegion information
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
        fmat[igeo,5] = [g.N, g.S, g.E, g.W]
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

"""
    tableRectRegions(;
        path :: AbstractString = homedir(),
        custom :: Bool = true,
        giorgi :: Bool = false,
        warn   :: Bool = true
    ) -> nothing

Display all available RectRegions in tabular format.

Keyword Arguments
=================
- `path` : The path where the list of custom RectRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`
- `custom` : If true, display custom user-defined RectRegions. Default is `true`
- `giorgi` : If true, display GF predefined RectRegions. Default is `false`
- `warn` : If true, display warnings if custom files do not exist
"""
function tableRectRegions(;
    path :: AbstractString = homedir(),
    custom :: Bool = true,
    giorgi :: Bool = false,
    warn   :: Bool = true
)

    rvec = []
    fvec = []
    dvec = []
    tvec = []

    rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,joinpath(geodir,"global.txt"))

    if custom
        fID = joinpath(path,"rectlist.txt")
        if isfile(fID)
            rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,fID)
        else
            if warn
                @warn "$(modulelog) - The custom file \"rectlist.txt\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
            end
        end
    end

    if giorgi
        rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,joinpath(geodir,"giorgi.txt"))
    end

    ngeo = size(rvec,1)
    fmat = Array{Any,2}(undef,ngeo,6)

    for igeo = 1 : ngeo
        geo = getgeoregion(rvec[igeo],joinpath(dvec[igeo],fvec[igeo]),tvec[igeo])
        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = tvec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = [geo.N, geo.S, geo.E, geo.W]
        fmat[igeo,6] = fvec[igeo]
    end

    head = ["ID","Type","Name","Parent","Bounds [N,S,E,W]","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end

"""
    tableTiltRegions(;
        path :: AbstractString = homedir(),
        warn   :: Bool = true
    ) -> nothing

Display all available TiltRegions in tabular format.

Keyword Arguments
=================
- `path` : The path where the list of custom TiltRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`
- `warn` : If true, display warnings if custom files do not exist
"""
function tableTiltRegions(;
    path :: AbstractString = homedir(),
    warn :: Bool = true
)

    rvec = []
    fvec = []
    dvec = []
    tvec = []

    rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,joinpath(geodir,"global.txt"))

    fID = joinpath(path,"tiltlist.txt")
    if isfile(fID)
        rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,fID)
    else
        if warn
            @warn "$(modulelog) - The custom file \"tiltlist.txt\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
        end
    end

    ngeo = size(rvec,1)
    fmat = Array{Any,2}(undef,ngeo,6)

    for igeo = 1 : ngeo
        geo = getgeoregion(rvec[igeo],joinpath(dvec[igeo],fvec[igeo]),tvec[igeo])
        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = tvec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = [geo.N, geo.S, geo.E, geo.W]
        fmat[igeo,6] = fvec[igeo]
    end

    head = ["ID","Type","Name","Parent","Bounds [N,S,E,W]","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end

"""
    tablePolyRegions(;
        path :: AbstractString = homedir(),
        custom :: Bool = true,
        srex :: Bool = false,
        ar6  :: Bool = false,
        warn   :: Bool = true
    ) -> nothing

Display all available PolyRegions in tabular format.

Keyword Arguments
=================
- `path` : The path where the list of custom PolyRegions will be retrieved from.
           Defaults to the user's home directory `homedir()`
- `custom` : If true, display custom user-defined PolyRegions. Default is `true`
- `srex` : If true, display SREX predefined PolyRegions. Default is `false`
- `ar6` : If true, display IPCC AR6 predefined PolyRegions. Default is `false`
- `warn` : If true, display warnings if custom files do not exist
"""
function tablePolyRegions(;
    path :: AbstractString = homedir(),
    custom :: Bool = true,
    srex   :: Bool = false,
    ar6    :: Bool = false,
    warn   :: Bool = true
)
    
    rvec = []
    fvec = []
    dvec = []
    tvec = []

    rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,joinpath(geodir,"global.txt"))

    if custom
        fID = joinpath(path,"polylist.txt")
        if isfile(fID)
            rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,fID)
        else
            if warn
                @warn "$(modulelog) - The custom file \"polylist.txt\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
            end
        end
    end

    if srex
        rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,joinpath(geodir,"srex.txt"))
    end

    if ar6
        rvec,fvec,tvec,dvec = fillinfo(rvec,fvec,tvec,dvec,joinpath(geodir,"ar6.txt"))
    end

    ngeo = size(rvec,1)
    fmat = Array{Any,2}(undef,ngeo,6)

    for igeo = 1 : ngeo
        geo = getgeoregion(rvec[igeo],joinpath(dvec[igeo],fvec[igeo]),tvec[igeo])
        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = tvec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = [geo.N, geo.S, geo.E, geo.W]
        fmat[igeo,6] = fvec[igeo]
    end

    head = ["ID","Type","Name","Parent","Bounds [N,S,E,W]","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end