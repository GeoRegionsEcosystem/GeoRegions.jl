import{_ as i,c as a,a5 as n,o as e}from"./chunks/framework.D0cFjeDR.js";const k=JSON.parse('{"title":"Is it in a GeoRegion?","description":"","frontmatter":{},"headers":[],"relativePath":"basics/isin.md","filePath":"basics/isin.md","lastUpdated":null}'),t={name:"basics/isin.md"};function l(p,s,o,h,d,c){return e(),a("div",null,s[0]||(s[0]=[n(`<h1 id="Is-it-in-a-GeoRegion?" tabindex="-1">Is it in a GeoRegion? <a class="header-anchor" href="#Is-it-in-a-GeoRegion?" aria-label="Permalink to &quot;Is it in a GeoRegion? {#Is-it-in-a-GeoRegion?}&quot;">​</a></h1><p>When dealing with geographic data, we often wish to check if a point or region is inside another region. GeoRegions.jl allows you to perform this check easily with the function <code>isinGeoRegion</code>.</p><div class="tip custom-block"><p class="custom-block-title">Point Type</p><p>We use the <code>Point2</code> Type from the package GeometryBasics.jl, which is reexported by GeoRegions.jl, as an easy way to denote points. This also allows us to use the package PolygonOps.jl to determine if a point is inside a region.</p></div><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>using GeoRegions</span></span>
<span class="line"><span>using DelimitedFiles</span></span>
<span class="line"><span>using CairoMakie</span></span>
<span class="line"><span></span></span>
<span class="line"><span>download(&quot;https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt&quot;,&quot;coast.cst&quot;)</span></span>
<span class="line"><span>coast = readdlm(&quot;coast.cst&quot;,comments=true)</span></span>
<span class="line"><span>clon  = coast[:,1]</span></span>
<span class="line"><span>clat  = coast[:,2]</span></span>
<span class="line"><span>nothing</span></span></code></pre></div><h2 id="Is-a-Point-in-a-GeoRegion?" tabindex="-1">Is a Point in a GeoRegion? <a class="header-anchor" href="#Is-a-Point-in-a-GeoRegion?" aria-label="Permalink to &quot;Is a Point in a GeoRegion? {#Is-a-Point-in-a-GeoRegion?}&quot;">​</a></h2><p>As an example, let us test if a point is in GeoRegion <code>AR6_EAO</code>, defined in the blue bounding box below. We define the below points:</p><ul><li><p>Point <em>A</em> at coordinates (-20,5)</p></li><li><p>Point <em>B</em> at coordinates (340,5)</p></li><li><p>Point <em>C</em> at coordinates (30,15)</p></li></ul><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">A </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Point2</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">20</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">B </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Point2</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">340</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">5</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">C </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Point2</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">45</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">7.5</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;AR6_EAO&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Polygonal Region AR6_EAO has the following properties:</span></span>
<span class="line"><span>    Region ID    (ID) : AR6_EAO</span></span>
<span class="line"><span>    Parent ID   (pID) : GLB</span></span>
<span class="line"><span>    Name       (name) : Equatorial Atlantic Ocean</span></span>
<span class="line"><span>    Bounds  (N,S,E,W) : [7.6, -10.0, 8.0, -50.0]</span></span>
<span class="line"><span>    Shape     (shape) : GeometryBasics.Point{2, Float64}[[-34.0, -10.0], [-34.0, 0.0], [-50.0, 0.0], [-50.0, 7.6], [-20.0, 7.6], [8.0, 0.0], [8.0, -10.0], [-34.0, -10.0]]</span></span>
<span class="line"><span>        (is180,is360) : (true, false)</span></span></code></pre></div><p>Here, we note that the coordinates of the GeoRegion (Equatorial Atlantic Ocean) are given in the bounds of (-180,180). It is trivial in this case to calculate if points A and C are within the bounds of the GeoRegion.</p><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>slon,slat = coordinates(geo)</span></span>
<span class="line"><span>aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))</span></span>
<span class="line"><span>fig = Figure()</span></span>
<span class="line"><span>ax = Axis(</span></span>
<span class="line"><span>    fig[1,1],width=750,height=750/aspect,</span></span>
<span class="line"><span>    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax,clon,clat,color=:black,linewidth=3)</span></span>
<span class="line"><span>lines!(ax,slon,slat,linewidth=5)</span></span>
<span class="line"><span>scatter!(ax,A,markersize=20)</span></span>
<span class="line"><span>scatter!(ax,C,markersize=20)</span></span>
<span class="line"><span>resize_to_layout!(fig)</span></span>
<span class="line"><span>fig</span></span></code></pre></div><p>By eye it is easy to see that Point A is inside the GeoRegion. However, C is not. Let us now see if we are able to corroborate this with GeoRegions.jl using the function <code>isinGeoRegion()</code></p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(A,geo), </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Point A</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(C,geo)  </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Point C</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(true, false)</span></span></code></pre></div><p>But what about Point B? Point B is also very obvious within the bounds of the GeoRegion, it is simply that the longitude of Point A is shifted by 360º such that it is now in the (0,360) coordinates frame. We see that this is of no concern to GeoRegions.jl, which can detect that it is within the bounds of the GeoRegion anyway.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isinGeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(B,geo,throw</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>true</span></span></code></pre></div><h2 id="Is-a-GeoRegion-inside-a-GeoRegion?" tabindex="-1">Is a GeoRegion inside a GeoRegion? <a class="header-anchor" href="#Is-a-GeoRegion-inside-a-GeoRegion?" aria-label="Permalink to &quot;Is a GeoRegion inside a GeoRegion? {#Is-a-GeoRegion-inside-a-GeoRegion?}&quot;">​</a></h2><p>Since any arbitrary geographic region can be defined as a <code>GeoRegion</code>, the natural extension now is to determine if a GeoRegion is wholly within another GeoRegion.</p><p>Let us consider an arbitrary GeoRegion <code>BIG</code>, and other smaller GeoRegions <code>TS1-4</code> as defined below, and plot them on a map.</p><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>geo_BIG = PolyRegion(</span></span>
<span class="line"><span>    &quot;BIG&quot;,&quot;GLB&quot;,&quot;A Big Region&quot;,</span></span>
<span class="line"><span>    [-120,-100,-100,-80,-30,15,45,75,90,115,120,105,85,45,20,-5,-45,-80,-120],</span></span>
<span class="line"><span>    [0,10,30,50,40,50,55,44,32,30,12,8,5,0,-10,-30,-40,-43,0]</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>geo_TS1 = RectRegion(&quot;TS1&quot;,&quot;GLB&quot;,&quot;Test Region 1&quot;,[45,20,20,-70])</span></span>
<span class="line"><span>geo_TS2 = PolyRegion(&quot;TS2&quot;,&quot;GLB&quot;,&quot;Test Region 2&quot;,[60,90,110,90,60],[20,25,20,15,20])</span></span>
<span class="line"><span>geo_TS3 = PolyRegion(</span></span>
<span class="line"><span>    &quot;TS3&quot;,&quot;GLB&quot;,&quot;Test Region 3&quot;,</span></span>
<span class="line"><span>    [-110,-98,-95,-90,-80,-100,-110,-110],</span></span>
<span class="line"><span>    [0,10,20,15,5,0,-20,0]</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>geo_TS4 = PolyRegion(</span></span>
<span class="line"><span>    &quot;TS4&quot;,&quot;GLB&quot;,&quot;Test Region 4&quot;,</span></span>
<span class="line"><span>    [300,325,330,355,330,325,320,300],</span></span>
<span class="line"><span>    [-10,-5,0,-10,-30,-35,-20,-10]</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>blon_b,blat_b,slon_b,slat_b = coordGeoRegion(geo_BIG)</span></span>
<span class="line"><span>              slon_1,slat_1 = coordGeoRegion(geo_TS1)</span></span>
<span class="line"><span>blon_2,blat_2,slon_2,slat_2 = coordGeoRegion(geo_TS2)</span></span>
<span class="line"><span>blon_3,blat_3,slon_3,slat_3 = coordGeoRegion(geo_TS3)</span></span>
<span class="line"><span>blon_4,blat_4,slon_4,slat_4 = coordGeoRegion(geo_TS4)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>fig = Figure()</span></span>
<span class="line"><span></span></span>
<span class="line"><span>ax = Axis(</span></span>
<span class="line"><span>    fig[1,1],width=750,height=750/2,</span></span>
<span class="line"><span>    limits=(-180,180,-90,90)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>lines!(ax,clon,clat,color=:black,linewidth=3)</span></span>
<span class="line"><span>lines!(ax,blon_b,blat_b,linewidth=5,color=:blue,linestyle=:dot)</span></span>
<span class="line"><span>lines!(ax,slon_b,slat_b,linewidth=5,color=:blue)</span></span>
<span class="line"><span>lines!(ax,slon_1,slat_1,linewidth=5,color=:red)</span></span>
<span class="line"><span>lines!(ax,blon_2,blat_2,linewidth=5,color=:green,linestyle=:dot)</span></span>
<span class="line"><span>lines!(ax,slon_2,slat_2,linewidth=5,color=:green)</span></span>
<span class="line"><span>lines!(ax,blon_3,blat_3,linewidth=5,color=:red,linestyle=:dot)</span></span>
<span class="line"><span>lines!(ax,slon_3,slat_3,linewidth=5,color=:red)</span></span>
<span class="line"><span>lines!(ax,blon_4.-360,blat_4,linewidth=5,color=:green,linestyle=:dot)</span></span>
<span class="line"><span>lines!(ax,slon_4.-360,slat_4,linewidth=5,color=:green)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>resize_to_layout!(fig)</span></span>
<span class="line"><span>fig</span></span></code></pre></div><p>We see by eye that GeoRegion <code>TS2</code> and <code>TS4</code> are in the <code>BIG</code> region, but the other GeoRegions are not. Now let us verify this with <code>isinGeoRegion()</code></p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo_TS1,geo_BIG),</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo_TS2,geo_BIG),</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo_TS3,geo_BIG),</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo_TS4,geo_BIG)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(false, true, false, true)</span></span></code></pre></div><p>And we see that this is indeed the case.</p><h2 id="api" tabindex="-1">API <a class="header-anchor" href="#api" aria-label="Permalink to &quot;API&quot;">​</a></h2><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="Base.in-Tuple{Point2{&lt;:Real}, RectRegion}" href="#Base.in-Tuple{Point2{&lt;:Real}, RectRegion}">#</a> <b><u>Base.in</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    Point  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Point2{&lt;:Real}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo    </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    tlon   </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Real</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    tlat   </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Real</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    throw  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Bool</span></span></code></pre></div><p>Check if a geographical point <code>point</code> is within a GeoRegion defined by <code>geo</code>.</p><p><strong>Arguments</strong></p><ul><li><p><code>Point</code> : A geographical point of Type <code>Point2</code>. Pass <code>Point2(plon,plat)</code>, where <code>plon</code> and <code>plat</code> are the longitude and latitudes of the point.</p></li><li><p><code>geo</code> : The GeoRegion struct container</p></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>tlon</code> : Threshold for the longitude bound</p></li><li><p><code>tlat</code> : Threshold for the latitude bound</p></li><li><p><code>throw</code> : If <code>true</code>, then if <code>Point</code> is not within <code>geo</code>, an error is thrown and the program stops running.</p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0799f6c95a633f64adea574ad2bb4082710b0faf/src/isin/point.jl#L1-L22" target="_blank" rel="noreferrer">source</a></p></div><br><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="Base.in-Tuple{GeoRegion, RectRegion}" href="#Base.in-Tuple{GeoRegion, RectRegion}">#</a> <b><u>Base.in</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    Child  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    rectG  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RectRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    throw  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Bool</span></span></code></pre></div><p>Check if a child GeoRegion defined by <code>Child</code> is within a RectRegion <code>rectG</code>.</p><p><strong>Arguments</strong></p><ul><li><p><code>Child</code> : A GeoRegion that we postulate to be a &quot;child&quot;, or a subset of the GeoRegion defined by <code>polyG</code></p></li><li><p><code>rectG</code> : A GeoRegion that we postulate to be a &quot;parent&quot;, or containing the GeoRegion defined by <code>Child</code></p></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><code>throw</code> : If <code>true</code>, then if <code>Child</code> is not within <code>polyG</code>, an error is thrown and the program stops running</li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0799f6c95a633f64adea574ad2bb4082710b0faf/src/isin/georegion.jl#L1-L18" target="_blank" rel="noreferrer">source</a></p></div><br><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="Base.in-Tuple{GeoRegion, PolyRegion}" href="#Base.in-Tuple{GeoRegion, PolyRegion}">#</a> <b><u>Base.in</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    cgeo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo   </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Union{TiltRegion,PolyRegion}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    n     </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Int</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 100</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    throw </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Bool</span></span></code></pre></div><p>Check if a child GeoRegion defined by <code>cgeo</code> is within a TiltRegion or PolyRegion <code>geo</code>.</p><p><strong>Arguments</strong></p><ul><li><p><code>cgeo</code> : A GeoRegion that we postulate to be a &quot;child&quot;, or a subset of the GeoRegion defined by <code>polyG</code></p></li><li><p><code>geo</code> : A TiltRegion or PolyRegion that we postulate to be a &quot;parent&quot;, or containing the GeoRegion defined by <code>Child</code></p></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>n</code> : Number of points per polygon side to test</p></li><li><p><code>throw</code> : If <code>true</code>, then if <code>cgeo</code> is not within <code>geo</code>, an error is thrown and the program stops running</p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0799f6c95a633f64adea574ad2bb4082710b0faf/src/isin/georegion.jl#L25-L44" target="_blank" rel="noreferrer">source</a></p></div><br>`,32)]))}const g=i(t,[["render",l]]);export{k as __pageData,g as default};
