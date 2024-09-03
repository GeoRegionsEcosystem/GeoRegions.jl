import{_ as a,c as n,a5 as e,o as i}from"./chunks/framework.HLuILII-.js";const g=JSON.parse('{"title":"Smoothing of the Land-Sea Mask Dataset","description":"","frontmatter":{},"headers":[],"relativePath":"landsea/smooth.md","filePath":"landsea/smooth.md","lastUpdated":null}'),l={name:"landsea/smooth.md"};function t(p,s,o,h,d,c){return i(),n("div",null,s[0]||(s[0]=[e(`<h1 id="Smoothing-of-the-Land-Sea-Mask-Dataset" tabindex="-1">Smoothing of the Land-Sea Mask Dataset <a class="header-anchor" href="#Smoothing-of-the-Land-Sea-Mask-Dataset" aria-label="Permalink to &quot;Smoothing of the Land-Sea Mask Dataset {#Smoothing-of-the-Land-Sea-Mask-Dataset}&quot;">​</a></h1><p>The land-sea mask created from the ETOPO dataset comprises of 1s and 0s, where 1 denotes land and 0 denotes the ocean. However, it may often be useful to sort grid points not only by their land-surface type, but how distant they are from the coastline. GeoRegions.jl uses Gaussian Filtering from <a href="https://github.com/JuliaImages/ImageFiltering.jl" target="_blank" rel="noreferrer">ImageFiltering.jl</a> to perform a smoothing of the land-sea mask.</p><p>The degree of smoothing is expressed by the arguments <code>σlon</code> and <code>σlat</code>, which are integer inputs respectively.</p><p>You can get a smoothed land-sea mask via two means:</p><ol><li><p>Calling the smoothing directly when retrieving the Land-Sea Dataset (recommended)</p></li><li><p>Smoothing a preexisting Land-Sea Dataset that has been loaded (not recommended)</p></li></ol><p>The API for smoothing is listed below. However, it is worth nothing that when implementing the smoothing, you need to first call a larger GeoRegion around the GeoRegion of interest as a buffer.</p><h3 id="setup" tabindex="-1">Setup <a class="header-anchor" href="#setup" aria-label="Permalink to &quot;Setup&quot;">​</a></h3><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> GeoRegions</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> DelimitedFiles</span></span>
<span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> CairoMakie</span></span>
<span class="line"></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">download</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;https://raw.githubusercontent.com/natgeo-wong/GeoPlottingData/main/coastline_resh.txt&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;coast.cst&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">coast </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> readdlm</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;coast.cst&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,comments</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">clon  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> coast[:,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">]</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">clat  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> coast[:,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">2</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">]</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">nothing</span></span></code></pre></div><h2 id="Example-comparison-between-Smooth-and-Unsmoothed-Masks" tabindex="-1">Example comparison between Smooth and Unsmoothed Masks <a class="header-anchor" href="#Example-comparison-between-Smooth-and-Unsmoothed-Masks" aria-label="Permalink to &quot;Example comparison between Smooth and Unsmoothed Masks {#Example-comparison-between-Smooth-and-Unsmoothed-Masks}&quot;">​</a></h2><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>geo = RectRegion(&quot;ACH&quot;,&quot;GLB&quot;,&quot;Aceh&quot;,[7,2,99,94],savegeo=false)</span></span>
<span class="line"><span>lsd_raw = getLandSea(geo,savelsd=false)</span></span>
<span class="line"><span>lsd_σ05 = getLandSea(geo,savelsd=false,smooth=true,σlon=5,σlat=5)</span></span>
<span class="line"><span>lsd_σ10 = getLandSea(geo,savelsd=false,smooth=true,σlon=10,σlat=10)</span></span></code></pre></div><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>fig = Figure()</span></span>
<span class="line"><span></span></span>
<span class="line"><span>ax1 = Axis(</span></span>
<span class="line"><span>    fig[1,1],width=225,height=225,</span></span>
<span class="line"><span>    title=&quot;Raw Land-Sea Mask&quot;,xlabel=&quot;Longitude / º&quot;,ylabel=&quot;Latitude / º&quot;,</span></span>
<span class="line"><span>    limits=(93.9,99.1,1.9,7.1)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>contourf!(</span></span>
<span class="line"><span>    ax1,lsd_raw.lon,lsd_raw.lat,lsd_raw.lsm,</span></span>
<span class="line"><span>    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax1,clon,clat,color=:black,linewidth=2)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>ax2 = Axis(</span></span>
<span class="line"><span>    fig[1,2],width=225,height=225,</span></span>
<span class="line"><span>    title=&quot;Smoothed (σ=5)&quot;,xlabel=&quot;Longitude / º&quot;,</span></span>
<span class="line"><span>    limits=(93.9,99.1,1.9,7.1)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>contourf!(</span></span>
<span class="line"><span>    ax2,lsd_σ05.lon,lsd_σ05.lat,lsd_σ05.lsm,</span></span>
<span class="line"><span>    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax2,clon,clat,color=:black,linewidth=2)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>ax3 = Axis(</span></span>
<span class="line"><span>    fig[1,3],width=225,height=225,</span></span>
<span class="line"><span>    title=&quot;Smoothed (σ=10)&quot;,xlabel=&quot;Longitude / º&quot;,</span></span>
<span class="line"><span>    limits=(93.9,99.1,1.9,7.1)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>contourf!(</span></span>
<span class="line"><span>    ax3,lsd_σ10.lon,lsd_σ10.lat,lsd_σ10.lsm,</span></span>
<span class="line"><span>    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax3,clon,clat,color=:black,linewidth=2)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>resize_to_layout!(fig)</span></span>
<span class="line"><span>fig</span></span></code></pre></div><h2 id="Smoothing-Directly-from-a-loaded-Land-Sea-Mask" tabindex="-1">Smoothing Directly from a loaded Land-Sea Mask <a class="header-anchor" href="#Smoothing-Directly-from-a-loaded-Land-Sea-Mask" aria-label="Permalink to &quot;Smoothing Directly from a loaded Land-Sea Mask {#Smoothing-Directly-from-a-loaded-Land-Sea-Mask}&quot;">​</a></h2><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>smooth!(lsd_raw,σlon=5,σlat=5)</span></span></code></pre></div><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>f2 = Figure()</span></span>
<span class="line"><span></span></span>
<span class="line"><span>ax1 = Axis(</span></span>
<span class="line"><span>    f2[1,1],width=350,height=350,</span></span>
<span class="line"><span>    title=&quot;Smoothed from Global&quot;,xlabel=&quot;Longitude / º&quot;,ylabel=&quot;Latitude / º&quot;,</span></span>
<span class="line"><span>    limits=(93.9,99.1,1.9,7.1)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>contourf!(</span></span>
<span class="line"><span>    ax1,lsd_σ05.lon,lsd_σ05.lat,lsd_σ05.lsm,</span></span>
<span class="line"><span>    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax1,clon,clat,color=:black,linewidth=2)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>ax2 = Axis(</span></span>
<span class="line"><span>    f2[1,2],width=350,height=350,</span></span>
<span class="line"><span>    title=&quot;Directly Smoothed&quot;,xlabel=&quot;Longitude / º&quot;,</span></span>
<span class="line"><span>    limits=(93.9,99.1,1.9,7.1)</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>contourf!(</span></span>
<span class="line"><span>    ax2,lsd_raw.lon,lsd_raw.lat,lsd_raw.lsm,</span></span>
<span class="line"><span>    levels=range(0.05,0.95,length=19),extendlow=:auto,extendhigh=:auto</span></span>
<span class="line"><span>)</span></span>
<span class="line"><span>lines!(ax2,clon,clat,color=:black,linewidth=2)</span></span>
<span class="line"><span></span></span>
<span class="line"><span>resize_to_layout!(f2)</span></span>
<span class="line"><span>f2</span></span></code></pre></div><p>You see here that smoothing the land-sea mask directly upon itself causes errors at the edges of the grid. This is because the smoothing applied is a circular smoothing, meaning that the boundaries are considered to be doubly-periodic, and thus bleed into each other. Thus, it is always best practice to call the smoothing directly when retrieving the Land-Sea dataset.</p><h2 id="api" tabindex="-1">API <a class="header-anchor" href="#api" aria-label="Permalink to &quot;API&quot;">​</a></h2><div class="warning custom-block"><p class="custom-block-title">Missing docstring.</p><p>Missing docstring for <code>smooth!</code>. Check Documenter&#39;s build log for details.</p></div><div class="warning custom-block"><p class="custom-block-title">Missing docstring.</p><p>Missing docstring for <code>smoothlsm</code>. Check Documenter&#39;s build log for details.</p></div>`,18)]))}const k=a(l,[["render",t]]);export{g as __pageData,k as default};
