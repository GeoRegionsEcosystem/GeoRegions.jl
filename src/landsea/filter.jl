"""
    smooth(
        lsd :: LandSeaTopo;
        usetopography :: false
    ) --> 

Smooth the Land-Sea mask given a LandSeaTopo Mask dataset.  If `usetopography` is set to true, then before the filtering, any points where height >= 0 is set to 1, and <0 is set = 0.

Arguments
=========
- `geo` : The GeoRegion of interest

Keyword Arguments
=================
- `path` :: The path to which an `ETOPO` folder is created within and ETOPO LandSea data saved into
- `resolution` : The resolution of the dataset to be downloaded, in units of arc-seconds.  Possible values are 15, 30 and 60, default is 60.
- `bedrock`, `geoid` : The type of ETOPO data (bedrock, geoid, ice-surface) to be downloaded. Bedrock has priority over geoid, so if both are `true`, the bedrock is downloaded.
- `savelsd` : Save LandSea dataset into a local NetCDF file.
- `returnlsd` : If `savelsd = true`, you can choose to simply save the data into the NetCDF file, or load return it as a `LandSea` dataset. Otherwise, if `savelsd = false`, you always return the `LandSea` dataset.
"""
function smooth(
    lsd :: LandSeaTopo;
    topography :: false
)

end

function smooth(
    lsd :: LandSeaFlat,
)

end