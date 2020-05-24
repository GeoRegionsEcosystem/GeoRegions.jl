var documenterSearchIndex = {"docs":
[{"location":"tutorials/isin.html#Is-Point/Grid-in-Region?-1","page":"IsIn Region?","title":"Is Point/Grid in Region?","text":"","category":"section"},{"location":"tutorials/isin.html#","page":"IsIn Region?","title":"IsIn Region?","text":"Text","category":"page"},{"location":"tutorials/isin.html#Brief-Introduction-fo-GeoRegions.jl-1","page":"IsIn Region?","title":"Brief Introduction fo GeoRegions.jl","text":"","category":"section"},{"location":"index.html#GeoRegions.jl-1","page":"Home","title":"GeoRegions.jl","text":"","category":"section"},{"location":"index.html#","page":"Home","title":"Home","text":"Extract Point/Gridded Data from a Regional Dataset","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"GeoRegions.jl is a Julia package that aims to streamline the following processes:","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"query if a point / grid is within a specified boundary\nextract point data (given coordinates) from a given region\nextract gridded data (given grid bounds) from a larger (parent) region (grid must be entirely within parent region)","category":"page"},{"location":"index.html#Installation-1","page":"Home","title":"Installation","text":"","category":"section"},{"location":"index.html#","page":"Home","title":"Home","text":"GeoRegions.jl can be installed using Julia's built-in package manager as follows:","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"julia> ]\n(@v1.4) pkg> add GeoRegions","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"You can update GeoRegions.jl to the latest version using","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"(@v1.4) pkg> update GeoRegions","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"And if you want to get the latest release without waiting for me to update the Julia Registry (although this generally isn't necessary since I make a point to release patch versions as soon as I find bugs or add new working features), you may fix the version to the master branch of the GitHub repository:","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"(@v1.4) pkg> add GeoRegions#master","category":"page"},{"location":"index.html#Documentation-1","page":"Home","title":"Documentation","text":"","category":"section"},{"location":"index.html#","page":"Home","title":"Home","text":"The documentation for GeoRegions.jl is divided into three components:","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"Tutorials - meant as an introduction to the package\nHow-to Examples - geared towards those looking for specific examples of what can be done\nAPI Reference - comprehensive summary of all exported functionalities","category":"page"},{"location":"index.html#","page":"Home","title":"Home","text":"tip: Obtaining Example Datasets\nAll the output for the coding examples were produced using my computer with key security information (such as login info) omitted.  The examples cannot be run online because the file size requirements are too big.  Copying and pasting the code examples (with relevant directory and login information changes) should produce the same results.","category":"page"},{"location":"index.html#Getting-help-1","page":"Home","title":"Getting help","text":"","category":"section"},{"location":"index.html#","page":"Home","title":"Home","text":"If you are interested in using GeoRegions.jl or are trying to figure out how to use it, please feel free to ask me questions and get in touch!  Please feel free to open an issue if you have any questions, comments, suggestions, etc!","category":"page"},{"location":"tutorials/list.html#List-of-Available-GeoRegions-1","page":"GeoRegions List","title":"List of Available GeoRegions","text":"","category":"section"},{"location":"tutorials/list.html#","page":"GeoRegions List","title":"GeoRegions List","text":"This page contains a list of the GeoRegions that are currently available in GeoRegions.jl.","category":"page"},{"location":"tutorials/list.html#","page":"GeoRegions List","title":"GeoRegions List","text":"The default GeoRegion covers the global domain |  identified as GLB","category":"page"},{"location":"tutorials/list.html#","page":"GeoRegions List","title":"GeoRegions List","text":"ID Parent N W S E Name\nGLB GLB 90 0 90 360 Global","category":"page"},{"location":"tutorials/list.html#Adapted-from-Giorgi-and-Francisco-[2000]-1","page":"GeoRegions List","title":"Adapted from Giorgi & Francisco [2000]","text":"","category":"section"},{"location":"tutorials/list.html#","page":"GeoRegions List","title":"GeoRegions List","text":"ID Parent N W S E Name\nGF_AUS GLB -10 110 -45 155 Australia\nGF_AMZ GLB 15 275 -20 330 Amazon Basin\nGF_SSA GLB -20 280 -60 320 Southern South America\nGF_CAM GLB 30 240 10 280 Central America\nGF_WNA GLB 60 230 30 255 Western North America\nGF_CNA GLB 50 255 30 275 Central North America\nGF_ENA GLB 50 275 25 300 Eastern North America\nGF_ALA GLB 75 180 50 255 Alaska\nGF_GRL GLB 85 255 50 350 Greenland\nGF_MED GLB 50 350 30 40 Mediterranean Basin\nGF_NEU GLB 75 350 50 40 Northern Europe\nGF_WAF GLB 20 340 -15 25 Western Africa\nGF_EAF GLB 20 20 -15 55 Eastern Africa\nGF_SAF GLB -10 350 -35 55 Southern Africa\nGF_SAH GLB 30 340 15 65 Sahara\nGF_SEA GLB 20 90 -15 165 Southeast Asia\nGF_EAS GLB 50 100 20 145 East Asia\nGF_SAS GLB 30 65 5 100 South Asia\nGF_CAS GLB 50 40 30 75 Central Asia\nGF_TIB GLB 50 75 30 100 Tibet\nGF_NAS GLB 85 40 50 180 North Asia","category":"page"}]
}