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
    fdefined = ["giorgi.txt","srex.txt","ar6.txt"]

    regvec  = []
    filevec = []
    dirvec  = []
    typevec = []

    if custom
        for fname in flist
            fID = joinpath(path,fname)
            if isfile(fID)
                rvec,rtype = listgeoregions(fID)
                regvec = vcat(regvec,rvec)
                nreg = length(rvec)
                fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
                tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
                dvec = fill(path,nreg);  dirvec = vcat(dirvec,dvec)
            else
                @warn "$(modulelog()) - The custom file does \"$fname\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
            end
        end
    end

    if defined
        for fname in fdefined
            rvec,rtype = listgeoregions(joinpath(geodir,fname))
            regvec = vcat(regvec,rvec)
            nreg = length(rvec)
            fvec = fill(fname,nreg); filevec = vcat(filevec,fvec)
            tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
            dvec = fill(geodir,nreg); dirvec = vcat(dirvec,dvec)
        end
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(dirvec[igeo],filevec[igeo]),
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
    dirvec  = []
    typevec = []

    if custom
        fID = joinpath(path,"rectlist.txt")
        if isfile(fID)
            rvec,rtype = listgeoregions(fID)
            regvec = vcat(regvec,rvec)
            nreg = length(rvec)
            fvec = fill("rectlist.txt",nreg); filevec = vcat(filevec,fvec)
            tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
            dvec = fill(path,nreg);  dirvec  = vcat(dirvec,dvec)
        else
            @warn "$(modulelog()) - The custom file \"rectlist.txt\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
        end
    end

    if giorgi
        rvec,rtype = listgeoregions(joinpath(geodir,"giorgi.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("giorgi.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
        dvec = fill(geodir,nreg);  dirvec  = vcat(dirvec,dvec)
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(dirvec[igeo],filevec[igeo]),
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

    fID = joinpath(path,"tiltlist.txt")
    if isfile(fID)
        rvec,rtype = listgeoregions(joinpath(path,"tiltlist.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("tiltlist.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
    else
        @warn "$(modulelog()) - The custom file \"tiltlist.txt\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
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
    dirvec  = []
    typevec = []

    if custom
        fID = joinpath(path,"polylist.txt")
        if isfile(fID)
            rvec,rtype = listgeoregions(fID)
            regvec = vcat(regvec,rvec)
            nreg = length(rvec)
            fvec = fill("polylist.txt",nreg); filevec = vcat(filevec,fvec)
            tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
            dvec = fill(path,nreg);  dirvec  = vcat(dirvec,dvec)
        else
            @warn "$(modulelog()) - The custom file \"polylist.txt\" does not exist in $path, use `setupGeoRegions()` to copy templates and empty custom lists to $path"
        end
    end

    if srex
        rvec,rtype = listgeoregions(joinpath(geodir,"srex.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("srex.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
        dvec = fill(geodir,nreg); dirvec = vcat(dirvec,dvec)
    end

    if ar6
        rvec,rtype = listgeoregions(joinpath(geodir,"ar6.txt"))
        regvec = vcat(regvec,rvec)
        nreg = length(rvec)
        fvec = fill("ar6.txt",nreg); filevec = vcat(filevec,fvec)
        tvec = fill(rtype,nreg); typevec = vcat(typevec,tvec)
        dvec = fill(geodir,nreg); dirvec = vcat(dirvec,dvec)
    end

    ngeo = size(regvec,1)
    fmat = Array{Any,2}(undef,ngeo,5)

    for igeo = 1 : ngeo
        geo = getgeoregion(
            regvec[igeo],
            joinpath(dirvec[igeo],filevec[igeo]),
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