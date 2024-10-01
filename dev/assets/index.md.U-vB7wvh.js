import{_ as e,c as s,a4 as a,o as t}from"./chunks/framework.CEeYBNx8.js";const c=JSON.parse('{"title":"","description":"","frontmatter":{"layout":"home","hero":{"name":"GeoRegions.jl","text":"Geographic Regions for Geospatial Data","tagline":"Defining Geographic Regions of Interest for Geospatial Data in Geoscience and Climate.","image":{"src":"/logo.png","alt":"GeoRegions"},"actions":[{"theme":"brand","text":"Getting Started","link":"/georegions"},{"theme":"alt","text":"Basics","link":"/basics/read/overview"},{"theme":"alt","text":"Tutorials","link":"/tutorials/projects"},{"theme":"alt","text":"View on Github","link":"https://github.com/georegionsecosystem/GeoRegions.jl"}]},"features":[{"icon":"<img width=\\"64\\" height=\\"64\\" src=\\"https://img.icons8.com/arcade/64/markdown.png\\" alt=\\"markdown\\"/>","title":"Simple","details":"Geographic Regions are defined using Longitude/Latitude coordinates","link":"/basics/properties/shape"},{"icon":"<img width=\\"64\\" height=\\"64\\" src=\\"https://img.icons8.com/arcade/64/markdown.png\\" alt=\\"markdown\\"/>","title":"Predefined GeoRegions","details":"Many Geographic Regions have been predefined, including regions from the IPCC AR6 report","link":"/georegions"},{"icon":"<img width=\\"64\\" height=\\"64\\" src=\\"https://img.icons8.com/arcade/64/markdown.png\\" alt=\\"markdown\\"/>","title":"Customizable","details":"Define your own custom Geographic Regions and save them for later","link":"/tutorials/addreadrm"},{"icon":"<img width=\\"64\\" height=\\"64\\" src=\\"https://img.icons8.com/arcade/64/markdown.png\\" alt=\\"markdown\\"/>","title":"Useful","details":"Are points in/on a GeoRegion for extraction?","link":"/basics/properties/isin"}]},"headers":[],"relativePath":"index.md","filePath":"index.md","lastUpdated":null}'),n={name:"index.md"};function o(l,i,h,r,p,d){return t(),s("div",null,i[0]||(i[0]=[a(`<h2 id="Installation-Instructions" tabindex="-1">Installation Instructions <a class="header-anchor" href="#Installation-Instructions" aria-label="Permalink to &quot;Installation Instructions {#Installation-Instructions}&quot;">​</a></h2><p>The latest version of GeoRegions can be installed using the Julia package manager (accessed by pressing <code>]</code> in the Julia command prompt)</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">julia</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> ]</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">@v1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">10</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) pkg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> add GeoRegions</span></span></code></pre></div><p>You can update <code>GeoRegions.jl</code> to the latest version using</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">@v1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">10</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) pkg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> update GeoRegions</span></span></code></pre></div><p>And if you want to get the latest release without waiting for me to update the Julia Registry (although this generally isn&#39;t necessary since I make a point to release patch versions as soon as I find bugs or add new working features), you may fix the version to the <code>main</code> branch of the GitHub repository:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">@v1</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">.</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">10</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) pkg</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> add GeoRegions</span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;">#main</span></span></code></pre></div><h2 id="Getting-help" tabindex="-1">Getting help <a class="header-anchor" href="#Getting-help" aria-label="Permalink to &quot;Getting help {#Getting-help}&quot;">​</a></h2><p>If you are interested in using <code>GeoRegions.jl</code> or are trying to figure out how to use it, please feel free to ask me questions and get in touch! Please feel free to <a href="https://github.com/JuliaClimate/GeoRegions.jl/issues/new" target="_blank" rel="noreferrer">open an issue</a> if you have any questions, comments, suggestions, etc!</p>`,9)]))}const k=e(n,[["render",o]]);export{c as __pageData,k as default};