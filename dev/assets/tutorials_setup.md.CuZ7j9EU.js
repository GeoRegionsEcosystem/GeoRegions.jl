import{_ as s,c as i,a5 as t,o as a}from"./chunks/framework.DMxYrb0F.js";const c=JSON.parse('{"title":"Setup GeoRegions.jl for a Project","description":"","frontmatter":{},"headers":[],"relativePath":"tutorials/setup.md","filePath":"tutorials/setup.md","lastUpdated":null}'),o={name:"tutorials/setup.md"};function n(l,e,r,p,h,d){return a(),i("div",null,e[0]||(e[0]=[t(`<h1 id="Setup-GeoRegions.jl-for-a-Project" tabindex="-1">Setup GeoRegions.jl for a Project <a class="header-anchor" href="#Setup-GeoRegions.jl-for-a-Project" aria-label="Permalink to &quot;Setup GeoRegions.jl for a Project {#Setup-GeoRegions.jl-for-a-Project}&quot;">​</a></h1><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.setupGeoRegions" href="#GeoRegions.setupGeoRegions">#</a> <b><u>GeoRegions.setupGeoRegions</u></b> — <i>Function</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">setupGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> pwd</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    overwrite </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Setup the directory specified by <code>path</code> with files for custom <code>GeoRegion</code>s. If <code>overwrite = true</code>, then any preexisting files are overwritten</p><p><strong>Keyword Arguments</strong></p><ul><li><p><code>path</code> : The path where the template list of custom GeoRegions will be copied to. Defaults to the current working directory <code>pwd()</code>.</p></li><li><p><code>overwrite</code> : If template files exist in this folder, overwrite?</p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/f4a0c07ed5e827c7548fa290c59d3952d1a3f066/src/georegions/project.jl#L1-L14" target="_blank" rel="noreferrer">source</a></p></div><br><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.deleteGeoRegions" href="#GeoRegions.deleteGeoRegions">#</a> <b><u>GeoRegions.deleteGeoRegions</u></b> — <i>Function</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">deleteGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> pwd</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Reset all the files containing GeoRegion information back to the default.</p><p><strong>Keyword Arguments</strong></p><ul><li><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the current working directory <code>pwd()</code></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/f4a0c07ed5e827c7548fa290c59d3952d1a3f066/src/georegions/project.jl#L142-L153" target="_blank" rel="noreferrer">source</a></p></div><br>`,5)]))}const g=s(o,[["render",n]]);export{c as __pageData,g as default};