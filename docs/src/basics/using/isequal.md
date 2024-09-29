# Comparing GeoRegions

Now, suppose we have two different GeoRegions, we have constructed several different ways of defining equivalence:

## 1. Are two GeoRegions Equivalent

If you want to check that two GeoRegions are equivalent, we can use the `==` or `isequal()` functions. For `==` or `isequal` to return true, the following conditions must be satisfied:
    * The `ID` and `pID` fields are the same
    * The `shape` fields define exactly the same geographic region as per the function `on()`

!!! tip "Equivalent Regions in GeoRegions.jl"
    For regions to be equivalent to each other in GeoRegions.jl, they do not need to be defined exactly in the same way.
    1. the regions can be offset by 360º
    2. the coordinates can be a `circshift()` version of each other.