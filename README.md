# **<div align="center">GeoRegions.jl</div>**

**Created By:** Nathanael Wong (nathanaelwong@fas.harvard.edu)

## **Introduction**

`GeoRegions.jl` is a Julia package that aims to streamline the following processes:
* query if a point / grid is within a specified boundary
* extract point data (given coordinates) from a given region
* extract gridded data (given grid boundaries) from a larger (parent) region (grid must be entirely within the parent region)

In general, these boundaries can be specified either using `[N,S,E,W]` coordinates, or by `longitude` and `latitude` vectors.

`GeoRegions.jl` can be installed via
```
] add GeoRegions
```

## **Workflow**

### **Is Point/Grid in (Region)?**
**Relevant Functions:** `ispointinregion`, `isgridinregion`

Let us define a `(Region)` domain specified by `[rN,rS,rE,rW]`, with `rlon` and `rlat` being the longitude and latitude vectors of the region.\
Given that we have a point coordinate `(plon,plat)`, and grid boundaries defined by `[N,S,E,W]`,

We can check if the point is within the region via:
```
ispointinregion(plon,plat,rlon,rlat)
ispointinregion([plon,plat],rlon,rlat)
ispointinregion(plon,plat,[rN,rS,rE,rW])
ispointinregion([plon,plat],[rN,rS,rE,rW])
```

And we can check if the grid is within the region via:
```
isgridinregion([N,S,E,W],rlon,rlat)
isgridinregion([N,S,E,W],[rN,rS,rE,rW])
```

### **Extract Point/Grid Data from Parent (Region)**
**Relevant Functions:** `regionextractpoint`, `regionextractgrid`, `regionextractgrid!`

If we have a set of **gridded** data `rdata` in a `(Region)` domain with `rlon` and `rlat` being the longitude and latitude vectors defining the region, then given that we have a point coordinate `(plon,plat)`, and grid boundaries defined by `[N,S,E,W]`,

We can extract the data nearest the coordinate `(plon,plat)` via:
```
regionextractpoint(rdata,plon,plat,rlon,rlat)
```

We can extract gridded data for a region bounded by `[N,S,E,W]` via:
```
regionextractgrid(rdata,[N,S,E,W],rlon,rlat)
```

## **GeoRegions**

`GeoRegions.jl` also utilizes the concept of a `GeoRegion` (short for Geographical Region), which is simply a set of predefined rectilinear regions specified by `[N,S,E,W]` coordinates.  This is similar to the Python module `regionmasks` (see https://github.com/mathause/regionmask), which has also inspired many of the functionalities found in `GeoRegions.jl`.

In `GeoRegions.jl`, a set of GeoRegions have already been specified in `gregiontemplate.txt` in the `src` folder.  These include:
* A global region `GLB` encompassing the entire globe
* Giorgi Regions (from *Giorgi and Franciso [2000]*), specified by `GF_xxx`, where `xxx` is a region in *Giorgi and Franciso [2000]*

Currently, all GeoRegions are rectilinear in the `(lon,lat)` domain.  However, future releases of `GeoRegions.jl` aim to be more flexible in their specification of region boundaries, allowing for arbitrary `polygons` as defined in `GeometryTypes.jl` and `PolygonOps.jl`

#### **Setup / `gregioncopy()`**
Upon running any function from `GeoRegions.jl` involving the usage of **GeoRegions**, unless an array containing GeoRegion information is included as input, the function `gregioncopy()` is called.  `gregioncopy()` does several things:
* `gregioncopy()` checks for a file named `gregions.txt` in `jfol = $(DEPOT_PATH[1])/files/GeoRegions/`
* if `$(jfol)/gregions.txt` does not exist, `gregioncopy()` will
    * create the directory `jfol` (if it does not already exist)
    * copy the information from `src/gregionstemplate.txt` into `$(jfol)/gregions.txt`
* **NB:** If you want to reset `gregions.txt` to the default GeoRegions template, `gregioncopy(overwrite=true)` will overwrite `gregions.txt` if it already exists

#### **Query for GeoRegion Information**
* `gregioninfoall()` displays all the available GeoRegions in `gregions.txt` and their properties in a table format
* `isgeoregion(ID)` checks if `$(ID)` is a valid GeoRegion identifier in `gregions.txt`

#### **Adding Custom GeoRegions**
You can add your own custom GeoRegions to `gregions.txt` using the function `gregioninfoadd()`.  There are two methods to accomplish this:
* You can create a textfile in the same format as `gregions.txt` (e.g. `$(path)/addgreg.txt`), and point `gregioninfoadd()` to this textfile, so for example
	* `gregioninfoadd("$(path)/addgreg.txt")`
* Or if you want to add in individual GeoRegions manually, you can do it as follows, for example:
	* `gregioninfoadd(ID="TST",parent="GLB",N=30,S=25,W=5,E=8,name="Test",throw=false,note="Test")`
	* will add the line `TST,GLB,30,5,25,8,Test,Test` to `gregions.txt`

#### Extracting data for GeoRegion
Suppose we are given gridded data `rdata` spanning longitude `rlon` and latitude `rlat`, we extract data for a GeoRegion `greg` via the following steps:
 1. `gregiongridvec(greg,rlon,rlat)` returns a `Dict` (let's call it `rinfo`) containing necessary information required for extraction of data from `rdata`
 2. `regionextractgrid(rdata,rinfo)` will return the data `gdata` for the GeoRegion `greg`

Therefore we can call `regionextractgrid()` multiple times in loops for the same region `greg` without needing to reextract region information, thus saving time.  This is particularly useful when dealing with data over many timesteps.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTIwMzEwNDk1MjQsMTI4NDg4MDk4NywxOT
I1MTM2ODUwLDk2MjY3MDM0OSwtMTA3MzAxNDY2NSw4NjczNjc1
MTUsLTEwMjEyMzM4OTVdfQ==
-->