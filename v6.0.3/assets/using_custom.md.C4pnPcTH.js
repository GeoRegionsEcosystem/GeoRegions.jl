import{_ as e,c as s,o as i,a7 as a}from"./chunks/framework.B4GarBAO.js";const u=JSON.parse('{"title":"Adding GeoRegions from Templates","description":"","frontmatter":{},"headers":[],"relativePath":"using/custom.md","filePath":"using/custom.md","lastUpdated":null}'),n={name:"using/custom.md"},t=a(`<h1 id="Adding-GeoRegions-from-Templates" tabindex="-1">Adding GeoRegions from Templates <a class="header-anchor" href="#Adding-GeoRegions-from-Templates" aria-label="Permalink to &quot;Adding GeoRegions from Templates {#Adding-GeoRegions-from-Templates}&quot;">​</a></h1><p>So you have a list of areas that you want to define, but you don&#39;t want to enter them in one by one. What to do?### Setup</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> GeoRegions</span></span></code></pre></div><h2 id="Template-GeoRegion-Files" tabindex="-1">Template GeoRegion Files <a class="header-anchor" href="#Template-GeoRegion-Files" aria-label="Permalink to &quot;Template GeoRegion Files {#Template-GeoRegion-Files}&quot;">​</a></h2><p><strong>Fear not!</strong> I have template files that one can use to define <code>RectRegion</code>s and <code>PolyRegion</code>s. Simply use the <code>templateGeoRegion()</code> to copy the templates into a directory of your choice.</p><div class="tip custom-block"><p class="custom-block-title">Defining PolyRegions</p><p>When defining <code>PolyRegion</code>s, the first and last set of (lon,lat) coordinates must be the same (i.e. a <strong>closed</strong> polygon must be defined)</p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">templateGeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;your-file-path-here&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.templateGeoRegions" href="#GeoRegions.templateGeoRegions">#</a> <b><u>GeoRegions.templateGeoRegions</u></b> — <i>Function</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">templateGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(; path</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, overwrite</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Copies the template files for defining GeoRegions in textfiles, that can then be added as a batch using addGeoRegions()</p><p><strong>Keyword Arguments</strong></p><ul><li><p><code>path</code> : The folder to copy the files to</p></li><li><p><code>overwrite</code> : If template files exist in this folder, overwrite?</p></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/1a93b383da297bb50ec888ab3e0eee036a0f3da7/src/georegions/read.jl#L129-L139" target="_blank" rel="noreferrer">source</a></p></div><br><h2 id="Reading-in-GeoRegions-from-a-custom-file" tabindex="-1">Reading in GeoRegions from a custom file <a class="header-anchor" href="#Reading-in-GeoRegions-from-a-custom-file" aria-label="Permalink to &quot;Reading in GeoRegions from a custom file {#Reading-in-GeoRegions-from-a-custom-file}&quot;">​</a></h2><p>We can then read in GeoRegions from your custom file using the function <code>addGeoRegions()</code>, which will then read all the GeoRegion information in the file and add it to the list of GeoRegions.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">addGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;recttest.txt&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;TRP&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Rectilinear Region TRP has the following properties:</span></span>
<span class="line"><span>    Region ID    (ID) : TRP</span></span>
<span class="line"><span>    Parent ID   (pID) : GLB</span></span>
<span class="line"><span>    Name       (name) : Tropical</span></span>
<span class="line"><span>    Bounds  (N,S,E,W) : [30.0, -30.0, 360.0, 0.0]</span></span>
<span class="line"><span>        (is180,is360) : (false, true)</span></span></code></pre></div><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.addGeoRegions" href="#GeoRegions.addGeoRegions">#</a> <b><u>GeoRegions.addGeoRegions</u></b> — <i>Function</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">addGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(fname</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Extracts information of the GeoRegion with the ID <code>geoID</code>. If no GeoRegion with this ID exists, an error is thrown.</p><p><strong>Arguments</strong></p><ul><li><code>fname</code> : name + path of the file containing GeoRegion information</li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/1a93b383da297bb50ec888ab3e0eee036a0f3da7/src/georegions/read.jl#L269-L278" target="_blank" rel="noreferrer">source</a></p></div><br><h2 id="Reset-the-list-of-GeoRegions" tabindex="-1">Reset the list of GeoRegions <a class="header-anchor" href="#Reset-the-list-of-GeoRegions" aria-label="Permalink to &quot;Reset the list of GeoRegions {#Reset-the-list-of-GeoRegions}&quot;">​</a></h2><p>Should one wish to entirely reset the list of GeoRegions, one can call <code>resetGeoRegions()</code>:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">resetGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>[ Info: 2024-08-23T06:40:32.156 - GeoRegions.jl - Resetting the custom lists of GeoRegions back to the default</span></span>
<span class="line"><span>┌ Warning: 2024-08-23T06:40:32.156 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/rectlist.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/rectlist.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:476</span></span>
<span class="line"><span>┌ Warning: 2024-08-23T06:40:32.162 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/polylist.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/polylist.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:476</span></span>
<span class="line"><span>┌ Warning: 2024-08-23T06:40:32.162 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/tiltlist.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/tiltlist.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:476</span></span></code></pre></div><p>And if one wishes to reset the predefined list of GeoRegions, we can do:</p><div class="language-@example vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">@example</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>resetGeoRegions(allfiles=true)</span></span></code></pre></div><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.resetGeoRegions" href="#GeoRegions.resetGeoRegions">#</a> <b><u>GeoRegions.resetGeoRegions</u></b> — <i>Function</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">resetGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(; allfiles</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Reset all the files containing GeoRegion information back to the default.</p><p><strong>Arguments</strong></p><ul><li><code>allfiles</code> : If <code>true</code>, reset the GeoRegions defined in Giorgi &amp; Francisco [2000], AR6 Regions (Iturbide et al., 2020; ESSD) and Seneviratne et al. [2012] as well. If <code>false</code>, only reset the custom GeoRegions.</li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/1a93b383da297bb50ec888ab3e0eee036a0f3da7/src/georegions/read.jl#L233-L242" target="_blank" rel="noreferrer">source</a></p></div><br><hr><p><em>This page was generated using <a href="https://github.com/fredrikekre/Literate.jl" target="_blank" rel="noreferrer">Literate.jl</a>.</em></p>`,25),o=[t];function l(p,r,d,h,g,c){return i(),s("div",null,o)}const b=e(n,[["render",l]]);export{u as __pageData,b as default};
