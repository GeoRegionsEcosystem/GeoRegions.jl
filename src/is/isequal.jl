"""
    ==(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion,
    ) -> tf :: Bool

Checks (a) ID, (b) pID, (c) rotation, and (d) the geometry/shape of two different GeoRegions in order to determine if they are exactly the same.

The `geo1.shape` and `geo2.shape` need not be exactly the same as long as they define the same area (i.e., the points in `geo2` can be a circshift version of `geo1`). They can also be offset from each other by 360º.

Arguments
=========
- `geo1` : The first GeoRegion.
- `geo2` : The second GeoRegion.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
==(geo1 :: GeoRegion, geo2 :: GeoRegion) = isequal(geo1,geo2)
!==(geo1 :: GeoRegion, geo2 :: GeoRegion) = !isequal(geo1,geo2)

"""
    isequal(
        geo1 :: GeoRegion,
        geo2 :: GeoRegion;
        verbose :: Bool = false
    ) -> tf :: Bool

Checks (a) ID, (b) pID, (c) rotation, and (d) the geometry/shape of two different GeoRegions in order to determine if they are exactly the same.

The `geo1.shape` and `geo2.shape` need not be exactly the same as long as they define exactly the same area (i.e., the points in `geo2` can be a `circshift()` version of `geo1`).

Arguments
=========
- `geo1` : The first GeoRegion.
- `geo2` : The second GeoRegion.

Keyword Arguments
=================
- `verbose` : Verbose logging for ease of monitoring? Default is `false`.

Returns
=======
- `tf` : A `true`/`false` boolean.
"""
function isequal(
    geo1 :: GeoRegion,
    geo2 :: GeoRegion;
    verbose :: Bool = false
)
 
    tf = on(geo1,geo2,verbose=verbose)

    if (geo1.ID !== geo2.ID) || (geo1.pID !== geo2.pID) || (geo1.θ !== geo2.θ)

        tf = false
    end

    return tf

end