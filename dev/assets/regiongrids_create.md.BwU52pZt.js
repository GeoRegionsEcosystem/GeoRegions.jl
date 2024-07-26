import{_ as s,c as i,o as a,a7 as n}from"./chunks/framework.D-rV3Mrg.js";const E=JSON.parse('{"title":"RegionGrid: Applying GeoRegions to Gridded Data","description":"","frontmatter":{},"headers":[],"relativePath":"regiongrids/create.md","filePath":"regiongrids/create.md","lastUpdated":null}'),e={name:"regiongrids/create.md"},l=n(`<h1 id="RegionGrid:-Applying-GeoRegions-to-Gridded-Data" tabindex="-1">RegionGrid: Applying GeoRegions to Gridded Data <a class="header-anchor" href="#RegionGrid:-Applying-GeoRegions-to-Gridded-Data" aria-label="Permalink to &quot;RegionGrid: Applying GeoRegions to Gridded Data {#RegionGrid:-Applying-GeoRegions-to-Gridded-Data}&quot;">​</a></h1><p>In this section, we go through the basic steps of creating a RegionGrid for <code>RectRegion</code>s and <code>PolyRegion</code>s. See if you can spot the differences between the RegionGrids generated by the two different types.</p><h3 id="setup" tabindex="-1">Setup <a class="header-anchor" href="#setup" aria-label="Permalink to &quot;Setup&quot;">​</a></h3><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> GeoRegions</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> DelimitedFiles</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> CairoMakie</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">download</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;coast.cst&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">coast </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> readdlm</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;coast.cst&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,comments</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">clon  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> coast[:,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">]</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">clat  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> coast[:,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">2</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">]</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">nothing</span></span></code></pre></div><h2 id="RectGrid-Example" tabindex="-1"><code>RectGrid</code> Example <a class="header-anchor" href="#RectGrid-Example" aria-label="Permalink to &quot;\`RectGrid\` Example {#RectGrid-Example}&quot;">​</a></h2><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SSA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lon  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> -</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">180</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">180</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lat  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> -</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">90</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">90</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">ggrd </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RegionGrid</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,lon[</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">end-</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)],lat)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Rectilinear Grid has the following properties:</span></span>
<span class="line"><span>    Grid Bounds       (grid) : [15, 7, 29, 21]</span></span>
<span class="line"><span>    Longitude Indices (ilon) : [21, 22, 23, 24, 25, 26, 27, 28, 29]</span></span>
<span class="line"><span>    Latitude Indices  (ilat) : [7, 8, 9, 10, 11, 12, 13, 14, 15]</span></span>
<span class="line"><span>    Longitude Points   (lon) : [280, 285, 290, 295, 300, 305, 310, 315, 320]</span></span>
<span class="line"><span>    Latitude Points    (lat) : [-60, -55, -50, -45, -40, -35, -30, -25, -20]</span></span>
<span class="line"><span>    Region Size (nlon * nlat) : 9 lon points x 9 lat points</span></span></code></pre></div><h2 id="PolyGrid-Example" tabindex="-1"><code>PolyGrid</code> Example <a class="header-anchor" href="#PolyGrid-Example" aria-label="Permalink to &quot;\`PolyGrid\` Example {#PolyGrid-Example}&quot;">​</a></h2><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;AR6_NWS&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lon  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> -</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">180</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">2</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">180</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lat  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> -</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">90</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">2</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">90</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">ggrd </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RegionGrid</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,lon[</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">end-</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)],lat)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Polygonal Grid has the following properties:</span></span>
<span class="line"><span>    Grid Bounds       (grid) : [52, 39, 55, 50]</span></span>
<span class="line"><span>    Longitude Indices (ilon) : [50, 51, 52, 53, 54, 55]</span></span>
<span class="line"><span>    Latitude Indices  (ilat) : [39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52]</span></span>
<span class="line"><span>    Longitude Points   (lon) : [-82.0, -80.0, -78.0, -76.0, -74.0, -72.0]</span></span>
<span class="line"><span>    Latitude Points    (lat) : [-14.0, -12.0, -10.0, -8.0, -6.0, -4.0, -2.0, 0.0, 2.0, 4.0, 6.0, 8.0, 10.0, 12.0]</span></span>
<span class="line"><span>    Region Size (nlon * nlat) : 6 lon points x 14 lat points</span></span>
<span class="line"><span>    Region Mask (sum(mask) / (nlon * nlat)) : 70 / 84</span></span></code></pre></div><p>So here, we see that in this <code>PolyGrid</code> example, the <code>RegionGrid</code> contains an additional field <code>mask</code> that, within the rectilinear longitude-latitude shape bounding the <code>GeoRegion</code> (because gridded data here is assumed to be rectilinear), the data is within the GeoRegion. Values of <code>1</code> indicate it is within the GeoRegion, otherwise the values are \`NaN.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">ggrd</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">mask</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>6×14 Matrix{Float64}:</span></span>
<span class="line"><span> NaN    NaN    1.0  1.0  1.0  1.0  1.0  …  NaN    NaN    NaN    NaN    NaN</span></span>
<span class="line"><span> NaN      1.0  1.0  1.0  1.0  1.0  1.0       1.0    1.0  NaN    NaN    NaN</span></span>
<span class="line"><span>   1.0    1.0  1.0  1.0  1.0  1.0  1.0       1.0    1.0    1.0  NaN    NaN</span></span>
<span class="line"><span>   1.0    1.0  1.0  1.0  1.0  1.0  1.0       1.0    1.0    1.0    1.0  NaN</span></span>
<span class="line"><span>   1.0    1.0  1.0  1.0  1.0  1.0  1.0       1.0    1.0    1.0    1.0    1.0</span></span>
<span class="line"><span>   1.0    1.0  1.0  1.0  1.0  1.0  1.0  …    1.0    1.0    1.0    1.0    1.0</span></span></code></pre></div><h2 id="The-Mask-of-a-PolyGrid" tabindex="-1">The Mask of a <code>PolyGrid</code> <a class="header-anchor" href="#The-Mask-of-a-PolyGrid" aria-label="Permalink to &quot;The Mask of a \`PolyGrid\` {#The-Mask-of-a-PolyGrid}&quot;">​</a></h2><p>The <code>PolyGrid</code> type derived from a <code>PolyRegion</code> allows us to apply a mask to filter out data that is within the <code>shape</code> of a <code>PolyRegion</code> on a rectilinear lon-lat grid defined by the <code>bound</code> of a PolyRegion. We consider the following example of an AR6 region over South Asia:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;AR6_SAS&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lon  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> -</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">180</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">180</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lat  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> -</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">90</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">2</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">90</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">ggrd </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RegionGrid</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,lon[</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">:</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">end-</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)],lat)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Polygonal Grid has the following properties:</span></span>
<span class="line"><span>    Grid Bounds       (grid) : [61, 50, 57, 49]</span></span>
<span class="line"><span>    Longitude Indices (ilon) : [49, 50, 51, 52, 53, 54, 55, 56, 57]</span></span>
<span class="line"><span>    Latitude Indices  (ilat) : [50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61]</span></span>
<span class="line"><span>    Longitude Points   (lon) : [60.0, 65.0, 70.0, 75.0, 80.0, 85.0, 90.0, 95.0, 100.0]</span></span>
<span class="line"><span>    Latitude Points    (lat) : [8.0, 10.0, 12.0, 14.0, 16.0, 18.0, 20.0, 22.0, 24.0, 26.0, 28.0, 30.0]</span></span>
<span class="line"><span>    Region Size (nlon * nlat) : 9 lon points x 12 lat points</span></span>
<span class="line"><span>    Region Mask (sum(mask) / (nlon * nlat)) : 55 / 108</span></span></code></pre></div><p>And using the field mask, we plot the points that are in the region (blue), and out of the region (red).</p><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>mask = ggrd.mask</span></span>
<span class="line"><span>grid = ones(size(mask))</span></span>
<span class="line"><span>inlon = grid .* ggrd.lon;  inlon = inlon[.!isnan.(mask)]</span></span>
<span class="line"><span>inlat = grid .* ggrd.lat&#39;; inlat = inlat[.!isnan.(mask)]</span></span>
<span class="line"><span>otlon = grid .* ggrd.lon;  otlon = otlon[isnan.(mask)]</span></span>
<span class="line"><span>otlat = grid .* ggrd.lat&#39;; otlat = otlat[isnan.(mask)]</span></span>
<span class="line"><span>blon,blat,slon,slat = coordGeoRegion(geo)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>fig = Figure()</span></span>
<span class="line"><span>aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))</span></span>
<span class="line"><span>ax = Axis(</span></span>
<span class="line"><span>    fig[1,1],width=750,height=750/aspect,</span></span>
<span class="line"><span>    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>lines!(ax,clon,clat,color=:black)</span></span>
<span class="line"><span>lines!(ax,blon,blat)</span></span>
<span class="line"><span>lines!(ax,slon,slat)</span></span>
<span class="line"><span>scatter!(ax,otlon,otlat)</span></span>
<span class="line"><span>scatter!(ax,inlon,inlat)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>resize_to_layout!(fig)</span></span>
<span class="line"><span>fig</span></span></code></pre></div><h2 id="api" tabindex="-1">API <a class="header-anchor" href="#api" aria-label="Permalink to &quot;API&quot;">​</a></h2><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.RegionGrid-Tuple{RectRegion, Vector{&lt;:Real}, Vector{&lt;:Real}}" href="#GeoRegions.RegionGrid-Tuple{RectRegion, Vector{&lt;:Real}, Vector{&lt;:Real}}">#</a> <b><u>GeoRegions.RegionGrid</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">RegionGrid</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    lon </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Union</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">{Vector{</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Real</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">},AbstractRange{</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Real</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">},</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    lat </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Union</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">{Vector{</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Real</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">},AbstractRange{</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Real</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">}</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> RectGrid, PolyGrid</span></span></code></pre></div><p>Creates a <code>RectGrid</code> or <code>PolyGrid</code> type based on the following arguments. This method is suitable for rectilinear grids of longitude/latitude output such as from Isca, or from satellite and reanalysis gridded datasets.</p><p><strong>Arguments</strong></p><ul><li><p><code>geo</code> : A GeoRegion of interest</p></li><li><p><code>lon</code> : A vector or <code>AbstractRange</code> containing the longitude points</p></li><li><p><code>lat</code> : A vector or <code>AbstractRange</code> containing the latitude points</p></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/d7610282fdd9802ff3c03fdbcd68132e3a38d2d9/src/extract/extract.jl#L1-L16" target="_blank" rel="noreferrer">source</a></p></div><br><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.RegionGrid-Tuple{GeoRegion, Matrix{&lt;:Real}, Matrix{&lt;:Real}}" href="#GeoRegions.RegionGrid-Tuple{GeoRegion, Matrix{&lt;:Real}, Matrix{&lt;:Real}}">#</a> <b><u>GeoRegions.RegionGrid</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">RegionGrid</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    lon </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Array{&lt;:Real,2}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    lat </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Array{&lt;:Real,2}</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> RegionGrid</span></span></code></pre></div><p>Creates a <code>RegionMask</code> type based on the following arguments. This method is more suitable for non-rectilinear grids of longitude and latitude points, such as in the output of WRF or CESM.</p><p><strong>Arguments</strong></p><ul><li><p><code>geo</code> : A GeoRegion of interest</p></li><li><p><code>lon</code> : An array containing the longitude points</p></li><li><p><code>lat</code> : An array containing the latitude points</p></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/d7610282fdd9802ff3c03fdbcd68132e3a38d2d9/src/extract/extract.jl#L31-L46" target="_blank" rel="noreferrer">source</a></p></div><br><hr><p><em>This page was generated using <a href="https://github.com/fredrikekre/Literate.jl" target="_blank" rel="noreferrer">Literate.jl</a>.</em></p>`,26),t=[l];function p(h,k,d,o,r,g){return a(),i("div",null,t)}const y=s(e,[["render",p]]);export{E as __pageData,y as default};
