"""
    tableGeoRegions(;
        path :: AbstractString = geodir,
        defined :: Bool = true,
        custom  :: Bool = true
    ) -> nothing

Display all available GeoRegions in tabular format.
Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `defined` : If true, pre-defined Giorgi, SREX and IPPC AR6 list of GeoRegions will be displayed.
- `custom`  : If true, custom, user-defined list of GeoRegions will be displayed.
"""
function tableGeoRegions(;
    path :: AbstractString = geodir,
    defined :: Bool = true,
    custom  :: Bool = true
)

    flist = ["rectlist.txt","polylist.txt","tiltlist.txt"]
    fdefined = vcat(flist,"giorgi.txt","srex.txt","ar6.txt")

    regvec  = []
    filevec = []
    typevec = []

    if defined
        for fname in flist
            copygeoregions(fname,path)
            rvec,rtype = listgeoregions(joinpath(path,fname))
            regvec = vcat(regvec,rvec)
            nreg = length(rvec)
            fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
            tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
        end
    end

    if custom
        for fname in fdefined
            copygeoregions(fname,geodir)
            rvec,rtype = listgeoregions(joinpath(geodir,fname))
            regvec = vcat(regvec,rvec)
            nreg = length(rvec)
            fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
            tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
        end
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(geodir,filevec[igeo]),
            typevec[igeo]
        )

        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = typevec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = filevec[igeo]

    end

    head = ["ID","Type","Name","Parent","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c],
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
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        g = getgeoregion(rvec[igeo],fname,rtype)
        fmat[igeo,1] = g.ID
        fmat[igeo,2] = rtype
        fmat[igeo,3] = g.name
        fmat[igeo,4] = g.pID
        fmat[igeo,5] = basename(fname)
    end

    head = ["ID","Type","Name","Parent","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end

"""
    tableRectRegions(;
        path :: AbstractString = geodir
    ) -> nothing

Display all available RectRegions in tabular format.

Keyword Arguments
=================å
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
"""
function tableRectRegions(;
    path :: AbstractString = geodir,
    custom :: Bool = true,
    giorgi :: Bool = false
)

    regvec  = []
    filevec = []
    typevec = []

    if custom
        copygeoregions("rectlist.txt",path)
        rvec,rtype = listgeoregions(joinpath(path,"rectlist.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("rectlist.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    if giorgi
        copygeoregions("giorgi.txt",geodir)
        rvec,rtype = listgeoregions(joinpath(geodir,"giorgi.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("giorgi.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(geodir,filevec[igeo]),
            typevec[igeo]
        )

        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = typevec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = filevec[igeo]

    end

    head = ["ID","Type","Name","Parent","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end

"""
    tableTiltRegions(;
        path :: AbstractString = geodir,
    ) -> nothing

Display all available RectRegions in tabular format.

Keyword Arguments
=================å
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `custom` : If true, display custom user-defined GeoRegions. Default is `true`
- `giorgi` : If true, display Giorgi predefined GeoRegions. Default is `false`
"""
function tableTiltRegions(;
    path :: AbstractString = geodir,
)

    regvec  = []
    filevec = []
    typevec = []

    copygeoregions("tiltlist.txt",path)
    rvec,rtype = listgeoregions(joinpath(path,"tiltlist.txt"))
    regvec = vcat(regvec,rvec)
    nreg = length(rvec)
    fvec = fill("tiltlist.txt",nreg); filevec = vcat(filevec,fvec)
    tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(geodir,filevec[igeo]),
            typevec[igeo]
        )

        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = typevec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = filevec[igeo]

    end

    head = ["ID","Type","Name","Parent","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end

"""
    tablePolyRegions(;
        path :: AbstractString = geodir,
        custom :: Bool = true,
        srex :: Bool = false,
        ar6  :: Bool = false
    ) -> nothing

Display all available PolyRegions in tabular format.

Keyword Arguments
=================
- `path` : The path where the list of custom GeoRegions will be retrieved from.
           Defaults to the `local` package variable `geodir`
- `custom` : If true, display custom user-defined GeoRegions. Default is `true`
- `srex` : If true, display SREX predefined GeoRegions. Default is `false`
- `ar6` : If true, display IPCC AR6 predefined GeoRegions. Default is `false`
"""
function tablePolyRegions(;
    path :: AbstractString = geodir,
    custom :: Bool = true,
    srex :: Bool = false,
    ar6  :: Bool = false
)
    
    regvec  = []
    filevec = []
    typevec = []

    if custom
        copygeoregions("polylist.txt",path)
        rvec,rtype = listgeoregions(joinpath(path,"polylist.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("polylist.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    if srex
        copygeoregions("srex.txt",geodir)
        rvec,rtype = listgeoregions(joinpath(path,"srex.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("srex.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    if ar6
        copygeoregions("ar6.txt",geodir)
        rvec,rtype = listgeoregions(joinpath(path,"ar6.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("ar6.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(path,filevec[igeo]),
            typevec[igeo]
        )

        fmat[igeo,1] = geo.ID
        fmat[igeo,2] = typevec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.pID
        fmat[igeo,5] = filevec[igeo]

    end

    head = ["ID","Type","Name","Parent","File"];

    pretty_table(
        fmat,header=head,
        alignment=[:c,:c,:l,:c,:c],
        crop = :none, tf = tf_compact
    );

    return nothing

end