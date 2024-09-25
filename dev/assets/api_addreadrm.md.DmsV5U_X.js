import{_ as o,c as l,j as i,a as e,G as t,a5 as n,B as h,o as p}from"./chunks/framework.qq-wibn1.js";const D=JSON.parse('{"title":"API for Adding, Reading and Removing GeoRegions","description":"","frontmatter":{},"headers":[],"relativePath":"api/addreadrm.md","filePath":"api/addreadrm.md","lastUpdated":null}'),r={name:"api/addreadrm.md"},d={class:"jldocstring custom-block",open:""},g={class:"jldocstring custom-block",open:""},k={class:"jldocstring custom-block",open:""},c={class:"jldocstring custom-block",open:""},E={class:"jldocstring custom-block",open:""},u={class:"jldocstring custom-block",open:""};function y(m,s,b,F,f,R){const a=h("Badge");return p(),l("div",null,[s[18]||(s[18]=i("h1",{id:"API-for-Adding,-Reading-and-Removing-GeoRegions",tabindex:"-1"},[e("API for Adding, Reading and Removing GeoRegions "),i("a",{class:"header-anchor",href:"#API-for-Adding,-Reading-and-Removing-GeoRegions","aria-label":'Permalink to "API for Adding, Reading and Removing GeoRegions {#API-for-Adding,-Reading-and-Removing-GeoRegions}"'},"​")],-1)),i("details",d,[i("summary",null,[s[0]||(s[0]=i("a",{id:"GeoRegions.GeoRegion-Tuple{AbstractString}",href:"#GeoRegions.GeoRegion-Tuple{AbstractString}"},[i("span",{class:"jlbinding"},"GeoRegions.GeoRegion")],-1)),s[1]||(s[1]=e()),t(a,{type:"info",class:"jlObjectType jlMethod",text:"Method"})]),s[2]||(s[2]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geoID </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> homedir</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span></span></code></pre></div><p>Extracts information of the GeoRegion with the ID <code>geoID</code>. If no GeoRegion with this ID exists, an error is thrown.</p><p><strong>Arguments</strong></p><ul><li><code>geoID</code> : The ID that will be used to identify the GeoRegion. If the ID is not valid (i.e. not being used), then an error will be thrown.</li></ul><p><strong>Keyword Arguments</strong></p><ul><li><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the user&#39;s home directory <code>homedir()</code></li></ul><p><strong>Returns</strong></p><ul><li><code>geo</code> : A GeoRegion</li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0b9d4563722d961a02a66af737dc72ac038a8910/src/georegions/define.jl#L1-L22" target="_blank" rel="noreferrer">source</a></p>`,9))]),i("details",g,[i("summary",null,[s[3]||(s[3]=i("a",{id:"GeoRegions.add",href:"#GeoRegions.add"},[i("span",{class:"jlbinding"},"GeoRegions.add")],-1)),s[4]||(s[4]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[5]||(s[5]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">add</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> dirname</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">path),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    verbose </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Saves information on the GeoRegion <code>geo</code> to a directory specified by <code>path</code>.</p><p><strong>Arguments</strong></p><ul><li><code>geo</code> : The GeoRegion to be saved into the custom lists in <code>path</code></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the <code>local</code> package variable <code>geodir</code></p></li><li><p><code>verbose</code> : Verbose logging for ease of monitoring? Default is <code>true</code></p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0b9d4563722d961a02a66af737dc72ac038a8910/src/georegions/add.jl#L1-L19" target="_blank" rel="noreferrer">source</a></p>`,7))]),i("details",k,[i("summary",null,[s[6]||(s[6]=i("a",{id:"GeoRegions.overwrite",href:"#GeoRegions.overwrite"},[i("span",{class:"jlbinding"},"GeoRegions.overwrite")],-1)),s[7]||(s[7]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[8]||(s[8]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">overwrite</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> dirname</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">path),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    verbose </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> nothing</span></span></code></pre></div><p>Overwrites preexisting information associated with the ID <code>geo.ID</code> in <code>path</code>, with new information from the <code>GeoRegion</code> specified by <code>geo</code></p><p><strong>Arguments</strong></p><ul><li><code>geo</code> : The GeoRegion to be saved into the custom lists in <code>path</code>, overwriting any preexisting information associated with the ID <code>geo.ID</code>.</li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the <code>local</code> package variable <code>geodir</code></p></li><li><p><code>verbose</code> : Verbose logging for ease of monitoring? Default is <code>true</code></p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0b9d4563722d961a02a66af737dc72ac038a8910/src/georegions/add.jl#L70-L88" target="_blank" rel="noreferrer">source</a></p>`,7))]),i("details",c,[i("summary",null,[s[9]||(s[9]=i("a",{id:"Base.Filesystem.rm",href:"#Base.Filesystem.rm"},[i("span",{class:"jlbinding"},"Base.Filesystem.rm")],-1)),s[10]||(s[10]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[11]||(s[11]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">rm</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geodir</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Removes the GeoRegion <code>geo</code> from the custom lists specified in <code>path</code>. The GeoRegion must have exactly the same properties as the one in the custom list</p><p><strong>Arguments</strong></p><ul><li><code>geo</code> : The GeoRegion to be removed from the custom lists in <code>path</code></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the <code>local</code> package variable <code>geodir</code></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0b9d4563722d961a02a66af737dc72ac038a8910/src/georegions/remove.jl#L1-L17" target="_blank" rel="noreferrer">source</a></p>`,7))]),i("details",E,[i("summary",null,[s[12]||(s[12]=i("a",{id:"GeoRegions.isID",href:"#GeoRegions.isID"},[i("span",{class:"jlbinding"},"GeoRegions.isID")],-1)),s[13]||(s[13]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[14]||(s[14]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isGeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geoID </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> homedir</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(),</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    throw </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> tf </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span></span></code></pre></div><p>Checks if there is a GeoRegion, that exists in the custom lists defined in <code>path</code>, with the ID <code>geoID</code>.</p><p><strong>Arguments</strong></p><ul><li><code>geoID</code> : The keyword ID that will be used to identify the GeoRegion. If the ID is not valid (i.e. not being used), then an error will be thrown.</li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the current directory <code>pwd()</code></p></li><li><p><code>throw</code> : If <code>true</code>, then throws an error if <code>geoID</code> is not a valid <code>GeoRegion</code> identifier instead of returning the Boolean <code>tf</code></p></li></ul><p><strong>Returns</strong></p><ul><li><code>tf</code> : True / False</li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0b9d4563722d961a02a66af737dc72ac038a8910/src/georegions/is.jl#L39-L62" target="_blank" rel="noreferrer">source</a></p>`,9))]),i("details",u,[i("summary",null,[s[15]||(s[15]=i("a",{id:"GeoRegions.rmID",href:"#GeoRegions.rmID"},[i("span",{class:"jlbinding"},"GeoRegions.rmID")],-1)),s[16]||(s[16]=e()),t(a,{type:"info",class:"jlObjectType jlFunction",text:"Function"})]),s[17]||(s[17]=n(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">rmID</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geoID </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    path  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> AbstractString</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geodir</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><p>Removes any GeoRegion associated with the ID <code>geoID</code>. ID must be exact.</p><p><strong>Arguments</strong></p><ul><li><code>geoID</code> : The keyword ID that will be used to identify the GeoRegion. If the ID is not valid (i.e. not being used), then an error will be thrown.</li></ul><p><strong>Keyword Arguments</strong></p><ul><li><code>path</code> : The path where the list of custom GeoRegions will be retrieved from. Defaults to the home directory <code>homedir()</code></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/0b9d4563722d961a02a66af737dc72ac038a8910/src/georegions/remove.jl#L25-L42" target="_blank" rel="noreferrer">source</a></p>`,7))])])}const v=o(r,[["render",y]]);export{D as __pageData,v as default};