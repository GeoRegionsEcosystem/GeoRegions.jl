import{_ as a,c as e,a4 as n,o as i}from"./chunks/framework.CEeYBNx8.js";const g=JSON.parse('{"title":"The Shape of a GeoRegion","description":"","frontmatter":{},"headers":[],"relativePath":"basics/properties/shape.md","filePath":"basics/properties/shape.md","lastUpdated":null}'),t={name:"basics/properties/shape.md"};function p(o,s,l,h,c,r){return i(),e("div",null,s[0]||(s[0]=[n(`<h1 id="The-Shape-of-a-GeoRegion" tabindex="-1">The Shape of a GeoRegion <a class="header-anchor" href="#The-Shape-of-a-GeoRegion" aria-label="Permalink to &quot;The Shape of a GeoRegion {#The-Shape-of-a-GeoRegion}&quot;">​</a></h1><p>In this section, we go through process of extracting information on the shape of the <code>GeoRegion</code>.</p><p>Let us now setup the example</p><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>using GeoRegions</span></span>
<span class="line"><span>using DelimitedFiles</span></span>
<span class="line"><span>using CairoMakie</span></span>
<span class="line"><span></span></span>
<span class="line"><span>download(&quot;https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resl.txt&quot;,&quot;coast.cst&quot;)</span></span>
<span class="line"><span>coast = readdlm(&quot;coast.cst&quot;,comments=true)</span></span>
<span class="line"><span>clon  = coast[:,1]</span></span>
<span class="line"><span>clat  = coast[:,2]</span></span>
<span class="line"><span>nothing</span></span></code></pre></div><p>We load a predefined AR6 GeoRegion for Northwest North America:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;AR6_NWN&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Polygonal Region AR6_NWN has the following properties:</span></span>
<span class="line"><span>    Region ID     (ID) : AR6_NWN</span></span>
<span class="line"><span>    Parent ID    (pID) : GLB</span></span>
<span class="line"><span>    Name        (name) : Northwest North America</span></span>
<span class="line"><span>    Bounds   (N,S,E,W) : [81.0, 50.0, -105.0, -168.0]</span></span>
<span class="line"><span>    Shape      (shape) : Point{2, Float64}[[-105.0, 50.0], [-130.0, 50.0], [-143.0, 58.0], [-168.0, 52.5], [-168.0, 72.6], [-129.0, 72.6], [-125.0, 77.6], [-105.0, 81.0], [-105.0, 50.0]]</span></span></code></pre></div><h2 id="Retrieving-the-coordinates-of-a-GeoRegion" tabindex="-1">Retrieving the coordinates of a GeoRegion <a class="header-anchor" href="#Retrieving-the-coordinates-of-a-GeoRegion" aria-label="Permalink to &quot;Retrieving the coordinates of a GeoRegion {#Retrieving-the-coordinates-of-a-GeoRegion}&quot;">​</a></h2><p>Using the function <code>coordinates()</code>, we are able to retrieve the coordinates of the vertices that define the shape of the <code>GeoRegion</code>. In the below example, we plot the longitude and latitude points.</p><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>lon,lat = coordinates(geo)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>aspect = (maximum(slon)-minimum(slon))/(maximum(slat)-minimum(slat))</span></span>
<span class="line"><span>fig = Figure()</span></span>
<span class="line"><span>ax = Axis(</span></span>
<span class="line"><span>    fig[1,1],width=750,height=750/aspect,</span></span>
<span class="line"><span>    limits=(minimum(slon)-2,maximum(slon)+2,minimum(slat)-2,maximum(slat)+2)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax,clon,clat,color=:black,linewidth=3)</span></span>
<span class="line"><span>lines!(ax,lon,lat,linewidth=5)</span></span>
<span class="line"><span>resize_to_layout!(fig)</span></span>
<span class="line"><span>fig</span></span></code></pre></div><p>This plotting works on maps where the projection is equirectangular. However, there are many different map projections, and so we can specify the number of segments <code>n</code> on each side of the shape using the keyword argument <code>n</code> in order to ensure during plotting that is plotted correctly on the projection.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">nlon,nlat </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> coordinates</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,n</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">50</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">length</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lon), </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">length</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(nlon)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(9, 401)</span></span></code></pre></div><div class="tip custom-block"><p class="custom-block-title">Number of Points</p><p>The shape is defined by 8 sides. Therefore there are by default 8 + 1 = 9 coordinate points to close the polygon. If we specify 50 segments a side, we therefore have 400 + 1 = 401 coordinate points to close the polygon.</p></div><p>See the API <a href="/GeoRegions.jl/dev/api/properties#GeoRegions.coordinates">here</a></p>`,15)]))}const u=a(t,[["render",p]]);export{g as __pageData,u as default};