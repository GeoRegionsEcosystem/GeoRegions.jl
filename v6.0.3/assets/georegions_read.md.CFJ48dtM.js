import{_ as i,c as s,o as e,a7 as a}from"./chunks/framework.B4GarBAO.js";const u=JSON.parse('{"title":"Reading in Defined GeoRegion Information","description":"","frontmatter":{},"headers":[],"relativePath":"georegions/read.md","filePath":"georegions/read.md","lastUpdated":null}'),n={name:"georegions/read.md"},t=a(`<h1 id="Reading-in-Defined-GeoRegion-Information" tabindex="-1">Reading in Defined GeoRegion Information <a class="header-anchor" href="#Reading-in-Defined-GeoRegion-Information" aria-label="Permalink to &quot;Reading in Defined GeoRegion Information {#Reading-in-Defined-GeoRegion-Information}&quot;">​</a></h1><p>In this section, we go through process of extracting information regarding a GeoRegion.</p><h3 id="setup" tabindex="-1">Setup <a class="header-anchor" href="#setup" aria-label="Permalink to &quot;Setup&quot;">​</a></h3><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> GeoRegions</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> DelimitedFiles</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> CairoMakie</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">download</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;coast.cst&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">coast </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> readdlm</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;coast.cst&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,comments</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">clon  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> coast[:,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">]</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">clat  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> coast[:,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">2</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">]</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">nothing</span></span></code></pre></div><h2 id="Retrieving-Information-about-a-Previously-Defined-GeoRegion" tabindex="-1">Retrieving Information about a Previously Defined GeoRegion <a class="header-anchor" href="#Retrieving-Information-about-a-Previously-Defined-GeoRegion" aria-label="Permalink to &quot;Retrieving Information about a Previously Defined GeoRegion {#Retrieving-Information-about-a-Previously-Defined-GeoRegion}&quot;">​</a></h2><p>We use the function <code>GeoRegion(ID)</code>, where <code>ID</code> is the ID of the GeoRegion, in order to extract the information for the GeoRegion.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;AR6_NWN&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Polygonal Region AR6_NWN has the following properties:</span></span>
<span class="line"><span>    Region ID    (ID) : AR6_NWN</span></span>
<span class="line"><span>    Parent ID   (pID) : GLB</span></span>
<span class="line"><span>    Name       (name) : Northwest North America</span></span>
<span class="line"><span>    Bounds  (N,S,E,W) : [81.0, 50.0, -105.0, -168.0]</span></span>
<span class="line"><span>    Shape     (shape) : Point{2, Float64}[[-105.0, 50.0], [-130.0, 50.0], [-143.0, 58.0], [-168.0, 52.5], [-168.0, 72.6], [-129.0, 72.6], [-125.0, 77.6], [-105.0, 81.0], [-105.0, 50.0]]</span></span>
<span class="line"><span>        (is180,is360) : (true, false)</span></span></code></pre></div><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.GeoRegion-Tuple{AbstractString}" href="#GeoRegions.GeoRegion-Tuple{AbstractString}">#</a> <b><u>GeoRegions.GeoRegion</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geoID</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">GeoRegion</span></span></code></pre></div><p>Extracts information of the GeoRegion with the ID <code>geoID</code>. If no GeoRegion with this ID exists, an error is thrown.</p><p><strong>Arguments</strong></p><ul><li><code>geoID</code> : The keyword ID that will be used to identify the GeoRegion. If the ID is not valid (i.e. not being used), then an error will be thrown.</li></ul><p><strong>Returns</strong></p><ul><li><code>geo</code> : A GeoRegion</li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/1a93b383da297bb50ec888ab3e0eee036a0f3da7/src/georegions/read.jl#L1-L16" target="_blank" rel="noreferrer">source</a></p></div><br><h2 id="The-Difference-between-Bounds-and-Shape-in-a-PolyRegion" tabindex="-1">The Difference between Bounds and Shape in a <code>PolyRegion</code> <a class="header-anchor" href="#The-Difference-between-Bounds-and-Shape-in-a-PolyRegion" aria-label="Permalink to &quot;The Difference between Bounds and Shape in a \`PolyRegion\` {#The-Difference-between-Bounds-and-Shape-in-a-PolyRegion}&quot;">​</a></h2><p>What is the difference between the fields <code>bound</code> and <code>shape</code> in a <code>PolyRegion</code>? The answer is simple: a <code>bound</code> is a rectilinear-region in the lon-lat coordinate system, while the <code>shape</code> denotes the actual <code>PolyRegion</code>. We retrieve the longitude and latitude coordinates for the <code>bound</code> and <code>shape</code> fields using the function <code>coordGeoRegion()</code>.</p><div class="tip custom-block"><p class="custom-block-title">Bound and Shape in <code>RectRegion</code></p><p>There is no field <code>shape</code> in a <code>RectRegion</code> because the <code>shape</code> of a <code>RectRegion</code> is defined by its rectilinear bound.</p></div><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>blon,blat,slon,slat = coordGeoRegion(GeoRegion(&quot;AR6_NWN&quot;))</span></span></code></pre></div><p>From plotting the bounds (blon,blat) and the shape(slon,slat), we see that the bound is the region defined by the westernmost, easternmost, northernmost and southernmost coordinates of the shape.</p><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))</span></span>
<span class="line"><span>fig = Figure()</span></span>
<span class="line"><span>ax = Axis(</span></span>
<span class="line"><span>    fig[1,1],width=750,height=750/aspect,</span></span>
<span class="line"><span>    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax,clon,clat,color=:black,linewidth=3)</span></span>
<span class="line"><span>lines!(ax,slon,slat,linewidth=5)</span></span>
<span class="line"><span>lines!(ax,blon,blat,linewidth=5)</span></span>
<span class="line"><span>resize_to_layout!(fig)</span></span>
<span class="line"><span>fig</span></span></code></pre></div><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.coordGeoRegion-Tuple{RectRegion}" href="#GeoRegions.coordGeoRegion-Tuple{RectRegion}">#</a> <b><u>GeoRegions.coordGeoRegion</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">coordGeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">RectRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> blon</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Vector{&lt;:Real}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, blat</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Vector{&lt;:Real}</span></span></code></pre></div><p>For a given RectRegion, extract the [N,S,E,W] bounds and create a longitude and latitude vector.</p><p><strong>Arguments</strong></p><ul><li><code>geo</code> : A RectRegion (i.e. a rectilinear GeoRegion)</li></ul><p><strong>Returns</strong></p><ul><li><p><code>lon</code> : A vector of longitude points for the bound of the GeoRegion</p></li><li><p><code>lat</code> : A vector of latitude points for the bound of the GeoRegion</p></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/1a93b383da297bb50ec888ab3e0eee036a0f3da7/src/georegions/query.jl#L50-L65" target="_blank" rel="noreferrer">source</a></p></div><br><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.coordGeoRegion-Tuple{PolyRegion}" href="#GeoRegions.coordGeoRegion-Tuple{PolyRegion}">#</a> <b><u>GeoRegions.coordGeoRegion</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">coordGeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">PolyRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    blon</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Vector{&lt;:Real}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, blat</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Vector{&lt;:Real}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    slon</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Vector{&lt;:Real}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, slat</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Vector{&lt;:Real}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span></code></pre></div><p>For a given RectRegion, extract the [N,S,E,W] bounds and create a longitude and latitude vectors for the bound and the shape of the GeoRegion</p><p><strong>Arguments</strong></p><ul><li><code>geo</code> : A PolyRegion (i.e. a polygonal GeoRegion)</li></ul><p><strong>Returns</strong></p><ul><li><p><code>lon</code> : A vector of longitude points for the shape of the GeoRegion</p></li><li><p><code>lat</code> : A vector of latitude points for the shape of the GeoRegion</p></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/1a93b383da297bb50ec888ab3e0eee036a0f3da7/src/georegions/query.jl#L1-L18" target="_blank" rel="noreferrer">source</a></p></div><br>`,20),o=[t];function l(p,h,d,r,g,c){return e(),s("div",null,o)}const E=i(n,[["render",l]]);export{u as __pageData,E as default};
