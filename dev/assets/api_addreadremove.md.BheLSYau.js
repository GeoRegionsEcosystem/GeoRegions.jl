import{_ as o,c as l,j as i,a as e,G as t,a5 as n,B as d,o as p}from"./chunks/framework.qq-wibn1.js";const F=JSON.parse('{"title":"API for Adding, Reading and Removing GeoRegions","description":"","frontmatter":{},"headers":[],"relativePath":"api/addreadremove.md","filePath":"api/addreadremove.md","lastUpdated":null}'),r={name:"api/addreadremove.md"},h={class:"jldocstring custom-block",open:""},g={class:"jldocstring custom-block",open:""},k={class:"jldocstring custom-block",open:""};function c(u,s,m,E,y,b){const a=d("Badge");return p(),l("div",null,[s[9]||(s[9]=i("h1",{id:"API-for-Adding,-Reading-and-Removing-GeoRegions",tabindex:"-1"},[e("API for Adding, Reading and Removing GeoRegions "),i("a",{class:"header-anchor",href:"#API-for-Adding,-Reading-and-Removing-GeoRegions","aria-label":'Permalink to "API for Adding, Reading and Removing GeoRegions {#API-for-Adding,-Reading-and-Removing-GeoRegions}"'},"​")],-1)),s[10]||(s[10]=i("div",{class:"warning custom-block"},[i("p",{class:"custom-block-title"},"Missing docstring."),i("p",null,[e("Missing docstring for "),i("code",null,"GeoRegion( geoID :: AbstractString; path :: AbstractString = homedir() ) -> geo :: GeoRegion"),e(". Check Documenter's build log for details.")])],-1)),i("details",h,[i("summary",null,[s[0]||(s[0]=i("a",{id:"GeoRegions.add",href:"#GeoRegions.add"},[i("span",{class:"jlbinding"},"GeoRegions.add")],-1)),s[1]||(s[1]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[2]||(s[2]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">add</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> dirname</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">path),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    verbose </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Saves information on the GeoRegion <code>geo</code> to a directory specified by <code>path</code>.</p><p><strong>Arguments</strong></p><ul><li><code>geo</code> : The GeoRegion to be saved into the custom lists in <code>path</code></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the <code>local</code> package variable <code>geodir</code></p></li><li><p><code>verbose</code> : Verbose logging for ease of monitoring? Default is <code>true</code></p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/97b8c9d4ec01023d0d0a306a1a4e8580c0eb2de4/src/georegions/add.jl#L1-L19" target="_blank" rel="noreferrer">source</a></p>`,7))]),i("details",g,[i("summary",null,[s[3]||(s[3]=i("a",{id:"Base.Filesystem.rm",href:"#Base.Filesystem.rm"},[i("span",{class:"jlbinding"},"Base.Filesystem.rm")],-1)),s[4]||(s[4]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[5]||(s[5]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">rm</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geodir</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Removes the GeoRegion <code>geo</code> from the custom lists specified in <code>path</code>. The GeoRegion must have exactly the same properties as the one in the custom list</p><p><strong>Arguments</strong></p><ul><li><code>geo</code> : The GeoRegion to be removed from the custom lists in <code>path</code></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the <code>local</code> package variable <code>geodir</code></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/97b8c9d4ec01023d0d0a306a1a4e8580c0eb2de4/src/georegions/remove.jl#L1-L17" target="_blank" rel="noreferrer">source</a></p>`,7))]),s[11]||(s[11]=i("p",null,[e("You can also remove a GeoRegion associated with an "),i("code",null,"ID"),e(".")],-1)),i("details",k,[i("summary",null,[s[6]||(s[6]=i("a",{id:"GeoRegions.rmID",href:"#GeoRegions.rmID"},[i("span",{class:"jlbinding"},"GeoRegions.rmID")],-1)),s[7]||(s[7]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[8]||(s[8]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">rmID</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geoID </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geodir</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Removes any GeoRegion associated with the ID <code>geoID</code>. ID must be exact.</p><p><strong>Arguments</strong></p><ul><li><code>geoID</code> : The keyword ID that will be used to identify the GeoRegion. If the ID is not valid (i.e. not being used), then an error will be thrown.</li></ul><p><strong>Keyword Arguments</strong></p><ul><li><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the home directory <code>homedir()</code></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/97b8c9d4ec01023d0d0a306a1a4e8580c0eb2de4/src/georegions/remove.jl#L25-L42" target="_blank" rel="noreferrer">source</a></p>`,7))])])}const R=o(r,[["render",c]]);export{F as __pageData,R as default};
