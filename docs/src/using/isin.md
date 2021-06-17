# Is it in a GeoRegion?

When dealing with geographic data, we often wish to check if a point or region is inside another region.  GeoRegions.jl allows you to perform this check easily with the functions `isPointinGeoRegion` and `isGeoRegioninGeoRegion`.

!!! note "Point Type"
    We use the `Point2` Type from the package GeometryBasics.jl, which is reexported by GeoRegions.jl, as an easy way to denote points.  This also allows us to use the package PolygonOps.jl to determine if a point is inside a region.

## Is a Point in a GeoRegion?

To determine if a point is in a region, we use the `isPointinGeoRegion` function.  Take the below points in the globe:
* Point *A* at coordinates (-20,-5)
* Point *B* at coordinates (30,15)

![ispointingeoregion](ispointingeoregion.png)

Let us test if they are in the region `AR6_EAO`, defined in the blue bounding box above.

```@repl
using GeoRegions
isPointinGeoRegion(Point2(-20,5),GeoRegion("AR6_EAO"),throw=false) # Point A
isPointinGeoRegion(Point2(340,5),GeoRegion("AR6_EAO"),throw=false) # Point A
isPointinGeoRegion(Point2(30,15),GeoRegion("AR6_EAO"),throw=false) # Point B
```

```@docs
isPointinGeoRegion
```

## Is a GeoRegion inside a GeoRegion?

Since any arbitrary geographic region can be defined as a `GeoRegion`, the natural extension now is to determine if a GeoRegion is wholly within another GeoRegion.

Let us consider an arbitrary GeoRegion `BIG`, and other smaller GeoRegions `TS1-4` as defined below

```@repl
using GeoRegions

PolyRegion(
    "BIG","GLB","A Big Region",
    [-120,-100,-100,-80,-30,15,45,75,90,115,120,105,85,45,20,-5,-45,-80,-120],
    [0,10,30,50,40,50,55,44,32,30,12,8,5,0,-10,-30,-40,-43,0]
);
RectRegion("TS1","GLB","Test Region 1",[45,20,20,-70]);
PolyRegion("TS2","GLB","Test Region 2",[60,90,110,90,60],[20,25,20,15,20]);
PolyRegion(
    "TS3","GLB","Test Region 3",
    [-110,-98,-95,-90,-80,-100,-110,-110],
    [0,10,20,15,5,0,-20,0]
);
PolyRegion(
    "TS4","GLB","Test Region 4",
    [300,325,330,355,330,325,320,300],
    [-10,-5,0,-10,-30,-35,-20,-10]
);
```

And we plot the bounds (dotted) and the shape (solid) of the GeoRegions below:

![isgeoregioningeoregion](isgeoregioningeoregion.png)

We see by eye that GeoRegion `TS2` and `TS4` are in the `BIG` region, but the other GeoRegions are not.  Now let us verify this with `isGeoRegioninGeoRegion`

```@repl
using GeoRegions

geo = GeoRegion("BIG");
t1  = GeoRegion("TS1"); isGeoRegioninGeoRegion(t1,geo,throw=false)
t2  = GeoRegion("TS2"); isGeoRegioninGeoRegion(t2,geo,throw=false)
t3  = GeoRegion("TS3"); isGeoRegioninGeoRegion(t3,geo,throw=false)
t4  = GeoRegion("TS4"); isGeoRegioninGeoRegion(t4,geo,throw=false)
```

And we see that this is indeed the case.

```@docs
isGeoRegioninGeoRegion
```

## How does `isGeoRegioninGeoRegion` work?

Test
