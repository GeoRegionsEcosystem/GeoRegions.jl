"""
    tableGeoRegions(; onlycustom::Bool) -> nothing

Display all available GeoRegions in tabular format.

Keyword Arguments
=================

- `onlycustom` : If true, only custom, user-defined GeoRegions will be displayed. To show all available GeoRegions (including predefined GeoRegions), set `onlycustom` to `false`
"""
function tableGeoRegions(;
    onlycustom :: Bool = false
)

    flist = ["rectlist.txt","polylist.txt"]
    if !onlycustom
        flist = vcat(flist,"giorgi.txt","srex.txt","ar6.txt")
    end

    regvec  = []
    filevec = []
    typevec = []

    for fname in flist
        copygeoregions(fname)
        rvec,rtype = listgeoregions(joinpath(DEPOT_PATH[1],"files","GeoRegions",fname))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(DEPOT_PATH[1],"files","GeoRegions",filevec[igeo]),
            typevec[igeo]
        )

        fmat[igeo,1] = geo.regID
        fmat[igeo,2] = typevec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.parID
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
    tableGeoRegions(fname::AbstractString) -> nothing

Display all available GeoRegions in tabular format.

Keyword Arguments
=================

- `onlycustom` : If true, only custom, user-defined GeoRegions will be displayed. To show all available GeoRegions (including predefined GeoRegions), set `onlycustom` to `false`
"""
function tableGeoRegions(
    fname::AbstractString
)

    rvec,rtype = listgeoregions(fname)
    ngeo = size(rvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        g = getgeoregion(rvec[igeo],fname,rtype)
        fmat[igeo,1] = g.regID
        fmat[igeo,2] = rtype
        fmat[igeo,3] = g.name
        fmat[igeo,4] = g.parID
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
        custom :: Bool = true,
        giorgi :: Bool = false
    ) -> nothing

Display all available RectRegions in tabular format.

Keyword Arguments
=================

- `custom` : If true, display custom user-defined GeoRegions. Default is `true`
- `giorgi` : If true, display Giorgi predefined GeoRegions. Default is `false`
"""
function tableRectRegions(;
    custom :: Bool = true,
    giorgi :: Bool = false
)

    flist = []
    if custom
        flist = vcat(flist,"rectlist.txt")
    end
    if giorgi
        flist = vcat(flist,"giorgi.txt")
    end

    regvec  = []
    filevec = []
    typevec = []

    for fname in flist
        copygeoregions(fname)
        rvec,rtype = listgeoregions(joinpath(DEPOT_PATH[1],"files","GeoRegions",fname))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(DEPOT_PATH[1],"files","GeoRegions",filevec[igeo]),
            typevec[igeo]
        )

        fmat[igeo,1] = geo.regID
        fmat[igeo,2] = typevec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.parID
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
        custom :: Bool = true,
        srex :: Bool = false,
        ar6  :: Bool = false
    ) -> nothing

Display all available PolyRegions in tabular format.

Keyword Arguments
=================

- `custom` : If true, display custom user-defined GeoRegions. Default is `true`
- `srex` : If true, display SREX predefined GeoRegions. Default is `false`
- `ar6` : If true, display IPCC AR6 predefined GeoRegions. Default is `false`
"""
function tablePolyRegions(;
    custom :: Bool = true,
    srex :: Bool = false,
    ar6  :: Bool = false
)

    flist = []
    if custom
        flist = vcat(flist,"polylist.txt")
    end
    if srex
        flist = vcat(flist,"srex.txt")
    end
    if ar6
        flist = vcat(flist,"ar6.txt")
    end
    
    regvec  = []
    filevec = []
    typevec = []

    for fname in flist
        copygeoregions(fname)
        rvec,rtype = listgeoregions(joinpath(DEPOT_PATH[1],"files","GeoRegions",fname))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(DEPOT_PATH[1],"files","GeoRegions",filevec[igeo]),
            typevec[igeo]
        )

        fmat[igeo,1] = geo.regID
        fmat[igeo,2] = typevec[igeo]
        fmat[igeo,3] = geo.name
        fmat[igeo,4] = geo.parID
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