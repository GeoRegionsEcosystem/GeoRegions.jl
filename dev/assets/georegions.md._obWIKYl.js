import{_ as i,c as o,a5 as s,o as t}from"./chunks/framework.D0cFjeDR.js";const h=JSON.parse('{"title":"What is a GeoRegion?","description":"","frontmatter":{},"headers":[],"relativePath":"georegions.md","filePath":"georegions.md","lastUpdated":null}'),a={name:"georegions.md"};function l(n,e,d,r,c,p){return t(),o("div",null,e[0]||(e[0]=[s('<h1 id="What-is-a-GeoRegion?" tabindex="-1">What is a GeoRegion? <a class="header-anchor" href="#What-is-a-GeoRegion?" aria-label="Permalink to &quot;What is a GeoRegion? {#What-is-a-GeoRegion?}&quot;">​</a></h1><p>In essence, a <code>GeoRegion</code> is:</p><ul><li><p>a geographical region of interest</p></li><li><p>identified by an <code>ID</code></p></li><li><p>a subregion of a <strong>parent</strong> <code>GeoRegion</code> (identified by <code>pID</code>, which must also be a valid <code>ID</code>)</p></li></ul><div class="tip custom-block"><p class="custom-block-title">Default GeoRegions</p><p>When using GeoRegions.jl, the default <code>GeoRegion</code> should generally be the global domain, specified by <code>GLB</code> and given by the <code>[N,S,E,W]</code> coordinates <code>[90,-90,360,0]</code>. The Global GeoRegion <code>GLB</code> is considered to be a subset of itself.</p></div><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.GeoRegion" href="#GeoRegions.GeoRegion">#</a> <b><u>GeoRegions.GeoRegion</u></b> — <i>Type</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">GeoRegion</span></span></code></pre></div><p>Abstract supertype for geographical regions. All <code>GeoRegion</code> types contain the following fields:</p><ul><li><p><code>ID</code> - A <code>String</code> Type, the identifier for the GeoRegion</p></li><li><p><code>pID</code> - A <code>String</code> Type, the identifier for the parent GeoRegion</p></li><li><p><code>name</code> - A <code>String</code> Type, the full name of the GeoRegion</p></li><li><p><code>N</code> - A <code>Float</code> Type, the north boundary of the GeoRegion</p></li><li><p><code>S</code> - A <code>Float</code> Type, the south boundary of the GeoRegion</p></li><li><p><code>E</code> - A <code>Float</code> Type, the east boundary of the GeoRegion</p></li><li><p><code>W</code> - A <code>Float</code> Type, the est boundary of the GeoRegion</p></li><li><p><code>is180</code> - A <code>Bool</code> Type, is <code>W</code> &lt; 0</p></li><li><p><code>is360</code> - A <code>Bool</code> Type, is <code>E</code> &gt; 180</p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/ee46cdbf1c54d921f2593047d3f610d677bd17ee/src/GeoRegions.jl#L29-L42" target="_blank" rel="noreferrer">source</a></p></div><br><p>In GeoRegions.jl, we differentiate between several different types of GeoRegions:</p><ul><li><p>Rectilinear GeoRegions are denoted by the <code>RectRegion</code> type, available in all version of GeoRegions.jl</p></li><li><p>Tilted rectangular GeoRegions are denoted by the <code>TiltRegion</code> type, available in ≥v6</p></li><li><p>Polygonal GeoRegions are denoted by the <code>PolyRegion</code> type, available in ≥v2</p></li></ul><h2 id="rectregions" tabindex="-1">RectRegions <a class="header-anchor" href="#rectregions" aria-label="Permalink to &quot;RectRegions&quot;">​</a></h2><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.RectRegion" href="#GeoRegions.RectRegion">#</a> <b><u>GeoRegions.RectRegion</u></b> — <i>Type</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">RectRegion{ST</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, FT</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Real</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">} </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span></span></code></pre></div><p>A rectangular region on a rectilinear grid. Defined by its N,S,E,W boundaries.</p><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/ee46cdbf1c54d921f2593047d3f610d677bd17ee/src/GeoRegions.jl#L45-L49" target="_blank" rel="noreferrer">source</a></p></div><br><h2 id="tiltregions" tabindex="-1">TiltRegions <a class="header-anchor" href="#tiltregions" aria-label="Permalink to &quot;TiltRegions&quot;">​</a></h2><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.TiltRegion" href="#GeoRegions.TiltRegion">#</a> <b><u>GeoRegions.TiltRegion</u></b> — <i>Type</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">TiltRegion{ST</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, FT</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Real</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">} </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span></span></code></pre></div><p>A <strong>tilted</strong> rectangular region on a rectilinear grid. Defined by</p><ul><li><p>the (lon,lat) coordinates of its centre</p></li><li><p>the width in both the longitude and latitude directions (pre-rotation)</p></li><li><p>the angle of tilt in degrees (clockwise)</p></li></ul><p>In addition to all the fields common to the <code>GeoRegion</code> <code>abstract type</code>, <code>TiltRegion</code>s will also contain the following field:</p><ul><li><p><code>X</code> : Longitude coordinate of region centre</p></li><li><p><code>Y</code> : Latitude coordinate of region centre</p></li><li><p><code>θ</code> : Tilt of rectangular region in <strong>degrees</strong> in the clockwise direction</p></li><li><p><code>ΔX</code> : Half-width in longitude coordinates (before tilting)</p></li><li><p><code>ΔY</code> : Half-width in latitude coordinates (before tilting)</p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/ee46cdbf1c54d921f2593047d3f610d677bd17ee/src/GeoRegions.jl#L85-L99" target="_blank" rel="noreferrer">source</a></p></div><br><h2 id="polyregions" tabindex="-1">PolyRegions <a class="header-anchor" href="#polyregions" aria-label="Permalink to &quot;PolyRegions&quot;">​</a></h2><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.PolyRegion" href="#GeoRegions.PolyRegion">#</a> <b><u>GeoRegions.PolyRegion</u></b> — <i>Type</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">PolyRegion{ST</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, FT</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Real</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">} </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&lt;:</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span></span></code></pre></div><p>A polygonal region on a rectilinear lon-lat grid, defined by the (lon,lat) coordinates of its vertices.</p><p>In addition to all the fields common to the <code>GeoRegion</code> <code>abstract type</code>, <code>PolyRegion</code>s will also contain the following field:</p><ul><li><code>shape</code> - A vector of <code>Point2</code> Types, defining a non-rectilinear shape of the GeoRegion</li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/ee46cdbf1c54d921f2593047d3f610d677bd17ee/src/GeoRegions.jl#L63-L70" target="_blank" rel="noreferrer">source</a></p></div><br>',17)]))}const b=i(a,[["render",l]]);export{h as __pageData,b as default};
