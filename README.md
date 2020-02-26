# GeoRegions

A Julia Package that
* Allows the user to query if a point / grid is within a specified boundary
* Extracts point or gridded information within a specified boundary

These boundaries can be specified either using `N,S,E,W` coordinates, or by `longitude` and
`latitude` vectors.

`GeoRegions.jl` has not been added to the JuliaRegistry yet.  Please install using
```
] add https://github.com/natgeo-wong/GeoRegions.jl
```

## GeoRegions

In addition, `GeoRegions.jl` allows the user to specify a **GeoRegion**, which can be used for a multitude of purposes.  A set of predefined GeoRegions can be found in the file `gregiontemplate.txt`.  A sample of these GeoRegions can be found in the table below:

| (1)RegID | (2)RegParent | (3)N | (4)W | (5)S | (6)E | (7)Description |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| GLB | GLB | 90 | 0 | -90 | 360 | Global |
| TRP | GLB | 30 | 0 | -30 | 360 | Tropical Belt |
| ISM | GLB | 45 | 35 | -15 | 105 | Indian Summer Monsoon Region |
| EAM | GLB | 50 | 90 | 0 | 150 | East Asian Monsoon Region |
| SEA | TRP | 20 | 90 | -15 | 165 | Southeast Asia / Maritime Continent |
| MLD | SEA | 20 | 93 | 0 | 110 | Mainland Southeast Asia |
| SGP | SEA | 3 | 101.5 | 0 | 106 | Singapore / Johor |


```
] add ClimateSatellite
```
