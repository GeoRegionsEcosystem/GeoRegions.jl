import{_ as i,c as s,o as e,a7 as a}from"./chunks/framework.D6bE-mmG.js";const u=JSON.parse('{"title":"Tabular Listings of GeoRegions","description":"","frontmatter":{},"headers":[],"relativePath":"lists/api.md","filePath":"lists/api.md","lastUpdated":null}'),l={name:"lists/api.md"},o=a(`<h1 id="Tabular-Listings-of-GeoRegions" tabindex="-1">Tabular Listings of GeoRegions <a class="header-anchor" href="#Tabular-Listings-of-GeoRegions" aria-label="Permalink to &quot;Tabular Listings of GeoRegions {#Tabular-Listings-of-GeoRegions}&quot;">​</a></h1><p>A list of GeoRegions and their basic properties can be called using the function <code>tableGeoRegions()</code>, which lists all available GeoRegions, both predefined and custom/user-defined.</p><div class="language-julia-repl vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia-repl</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span></span></span></code></pre></div><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.tableGeoRegions-Tuple{}" href="#GeoRegions.tableGeoRegions-Tuple{}">#</a> <b><u>GeoRegions.tableGeoRegions</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(; onlycustom</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">Bool</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Display all available GeoRegions in tabular format.</p><p><strong>Keyword Arguments</strong></p><ul><li><code>onlycustom</code> : If true, only custom, user-defined GeoRegions will be displayed. To show all available GeoRegions (including predefined GeoRegions), set <code>onlycustom</code> to <code>false</code></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/fd5f3052f6401aded6c675dd3113b458c68deada/src/georegions/tables.jl#L1-L10" target="_blank" rel="noreferrer">source</a></p></div><br><h2 id="More-specific-lists-of-GeoRegions" tabindex="-1">More specific lists of GeoRegions <a class="header-anchor" href="#More-specific-lists-of-GeoRegions" aria-label="Permalink to &quot;More specific lists of GeoRegions {#More-specific-lists-of-GeoRegions}&quot;">​</a></h2><p>Besides listing all available GeoRegions, it is also possible to list a variety of different specifications of GeoRegions with the <code>tableGeoRegions()</code> function, as well as <code>tableRectRegions()</code> and <code>tablePolyRegions()</code>.</p><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.tableRectRegions" href="#GeoRegions.tableRectRegions">#</a> <b><u>GeoRegions.tableRectRegions</u></b> — <i>Function</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableRectRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    custom </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    giorgi </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Display all available RectRegions in tabular format.</p><p><strong>Keyword Arguments</strong></p><ul><li><p><code>custom</code> : If true, display custom user-defined GeoRegions. Default is <code>true</code></p></li><li><p><code>giorgi</code> : If true, display Giorgi predefined GeoRegions. Default is <code>false</code></p></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/fd5f3052f6401aded6c675dd3113b458c68deada/src/georegions/tables.jl#L102-L115" target="_blank" rel="noreferrer">source</a></p></div><br><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.tablePolyRegions" href="#GeoRegions.tablePolyRegions">#</a> <b><u>GeoRegions.tablePolyRegions</u></b> — <i>Function</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tablePolyRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    custom </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    srex </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    ar6  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Display all available PolyRegions in tabular format.</p><p><strong>Keyword Arguments</strong></p><ul><li><p><code>custom</code> : If true, display custom user-defined GeoRegions. Default is <code>true</code></p></li><li><p><code>srex</code> : If true, display SREX predefined GeoRegions. Default is <code>false</code></p></li><li><p><code>ar6</code> : If true, display IPCC AR6 predefined GeoRegions. Default is <code>false</code></p></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/fd5f3052f6401aded6c675dd3113b458c68deada/src/georegions/tables.jl#L172-L187" target="_blank" rel="noreferrer">source</a></p></div><br><h2 id="Listing-GeoRegions-inside-a-Custom-File" tabindex="-1">Listing GeoRegions inside a Custom File <a class="header-anchor" href="#Listing-GeoRegions-inside-a-Custom-File" aria-label="Permalink to &quot;Listing GeoRegions inside a Custom File {#Listing-GeoRegions-inside-a-Custom-File}&quot;">​</a></h2><p>Similarly, it is also possible to list the GeoRegions in custom files. The template for these files can be retrieved using the function <code>templateGeoRegions()</code></p><div style="border-width:1px;border-style:solid;border-color:black;padding:1em;border-radius:25px;"><a id="GeoRegions.tableGeoRegions-Tuple{AbstractString}" href="#GeoRegions.tableGeoRegions-Tuple{AbstractString}">#</a> <b><u>GeoRegions.tableGeoRegions</u></b> — <i>Method</i>. <div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(fname</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Display all available GeoRegions in tabular format.</p><p><strong>Keyword Arguments</strong></p><ul><li><code>onlycustom</code> : If true, only custom, user-defined GeoRegions will be displayed. To show all available GeoRegions (including predefined GeoRegions), set <code>onlycustom</code> to <code>false</code></li></ul><p><a href="https://github.com/JuliaClimate/GeoRegions.jl/blob/fd5f3052f6401aded6c675dd3113b458c68deada/src/georegions/tables.jl#L63-L72" target="_blank" rel="noreferrer">source</a></p></div><br>`,15),t=[o];function n(d,p,r,h,g,c){return e(),s("div",null,t)}const b=i(l,[["render",n]]);export{u as __pageData,b as default};