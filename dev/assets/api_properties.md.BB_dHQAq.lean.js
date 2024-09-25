import{_ as o,c as l,j as s,a as e,G as a,a5 as t,B as p,o as h}from"./chunks/framework.qq-wibn1.js";const C=JSON.parse('{"title":"API for Different GeoRegion Properties","description":"","frontmatter":{},"headers":[],"relativePath":"api/properties.md","filePath":"api/properties.md","lastUpdated":null}'),d={name:"api/properties.md"},r={class:"jldocstring custom-block",open:""},k={class:"jldocstring custom-block",open:""},g={class:"jldocstring custom-block",open:""};function c(E,i,y,u,f,b){const n=p("Badge");return h(),l("div",null,[i[9]||(i[9]=s("h1",{id:"API-for-Different-GeoRegion-Properties",tabindex:"-1"},[e("API for Different GeoRegion Properties "),s("a",{class:"header-anchor",href:"#API-for-Different-GeoRegion-Properties","aria-label":'Permalink to "API for Different GeoRegion Properties {#API-for-Different-GeoRegion-Properties}"'},"​")],-1)),s("details",r,[s("summary",null,[i[0]||(i[0]=s("a",{id:"Base.in-Tuple{Point2{<:Real}, GeoRegion}",href:"#Base.in-Tuple{Point2{<:Real}, GeoRegion}"},[s("span",{class:"jlbinding"},"Base.in")],-1)),i[1]||(i[1]=e()),a(n,{type:"info",class:"jlObjectType jlMethod",text:"Method"})]),i[2]||(i[2]=t(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    Point  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Point2{&lt;:Real}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo    </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    tlon   </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Real</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    tlat   </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Real</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 0</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    throw  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Bool</span></span></code></pre></div><p>Check if a geographical point <code>point</code> is within a GeoRegion defined by <code>geo</code>.</p><p><strong>Arguments</strong></p><ul><li><p><code>Point</code> : A geographical point of Type <code>Point2</code>. Pass <code>Point2(plon,plat)</code>, where <code>plon</code> and <code>plat</code> are the longitude and latitudes of the point.</p></li><li><p><code>geo</code> : The GeoRegion struct container</p></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>tlon</code> : Threshold for the longitude bound</p></li><li><p><code>tlat</code> : Threshold for the latitude bound</p></li><li><p><code>throw</code> : If <code>true</code>, then if <code>Point</code> is not within <code>geo</code>, an error is thrown and the program stops running.</p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/f985daeb71ceac6df01be747b823564d921247c6/src/isin/point.jl#L1-L22" target="_blank" rel="noreferrer">source</a></p>`,7))]),s("details",k,[s("summary",null,[i[3]||(i[3]=s("a",{id:"Base.in-Tuple{GeoRegion, RectRegion}",href:"#Base.in-Tuple{GeoRegion, RectRegion}"},[s("span",{class:"jlbinding"},"Base.in")],-1)),i[4]||(i[4]=e()),a(n,{type:"info",class:"jlObjectType jlMethod",text:"Method"})]),i[5]||(i[5]=t(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    cgeo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo   </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RectRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    throw </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Bool</span></span></code></pre></div><p>Check if a child GeoRegion defined by <code>cgeo</code> is within a RectRegion <code>geo</code>.</p><p><strong>Arguments</strong></p><ul><li><p><code>cgeo</code> : A GeoRegion that we postulate to be a &quot;child&quot;, or a subset of the GeoRegion defined by <code>polyG</code></p></li><li><p><code>geo</code> : A GeoRegion that we postulate to be a &quot;parent&quot;, or containing the GeoRegion defined by <code>Child</code></p></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><code>throw</code> : If <code>true</code>, then if <code>Child</code> is not within <code>polyG</code>, an error is thrown and the program stops running</li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/f985daeb71ceac6df01be747b823564d921247c6/src/isin/georegion.jl#L1-L18" target="_blank" rel="noreferrer">source</a></p>`,7))]),s("details",g,[s("summary",null,[i[6]||(i[6]=s("a",{id:"Base.in-Tuple{GeoRegion, Union{PolyRegion, TiltRegion}}",href:"#Base.in-Tuple{GeoRegion, Union{PolyRegion, TiltRegion}}"},[s("span",{class:"jlbinding"},"Base.in")],-1)),i[7]||(i[7]=e()),a(n,{type:"info",class:"jlObjectType jlMethod",text:"Method"})]),i[8]||(i[8]=t(`<div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">in</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    cgeo  </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    geo   </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Union{TiltRegion,PolyRegion}</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">;</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    n     </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Int</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> 100</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">    throw </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">::</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> Bool</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;"> =</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> false</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">-&gt;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> Bool</span></span></code></pre></div><p>Check if a child GeoRegion defined by <code>cgeo</code> is within a TiltRegion or PolyRegion <code>geo</code>.</p><p><strong>Arguments</strong></p><ul><li><p><code>cgeo</code> : A GeoRegion that we postulate to be a &quot;child&quot;, or a subset of the GeoRegion defined by <code>polyG</code></p></li><li><p><code>geo</code> : A TiltRegion or PolyRegion that we postulate to be a &quot;parent&quot;, or containing the GeoRegion defined by <code>Child</code></p></li></ul><p><strong>Keyword Arguments</strong></p><ul><li><p><code>n</code> : Number of points per polygon side to test</p></li><li><p><code>throw</code> : If <code>true</code>, then if <code>cgeo</code> is not within <code>geo</code>, an error is thrown and the program stops running</p></li></ul><p><a href="https://github.com/GeoRegionsEcosystem/GeoRegions.jl/blob/f985daeb71ceac6df01be747b823564d921247c6/src/isin/georegion.jl#L25-L44" target="_blank" rel="noreferrer">source</a></p>`,7))])])}const R=o(d,[["render",c]]);export{C as __pageData,R as default};
