import{_ as i,c as e,a4 as a,o as t}from"./chunks/framework.C_-3PYrn.js";const g=JSON.parse('{"title":"Equivalence between GeoRegions and their Properties","description":"","frontmatter":{},"headers":[],"relativePath":"tutorials/isequal.md","filePath":"tutorials/isequal.md","lastUpdated":null}'),n={name:"tutorials/isequal.md"};function h(l,s,p,o,k,d){return t(),e("div",null,s[0]||(s[0]=[a(`<h1 id="Equivalence-between-GeoRegions-and-their-Properties" tabindex="-1">Equivalence between GeoRegions and their Properties <a class="header-anchor" href="#Equivalence-between-GeoRegions-and-their-Properties" aria-label="Permalink to &quot;Equivalence between GeoRegions and their Properties {#Equivalence-between-GeoRegions-and-their-Properties}&quot;">​</a></h1><p>Now, suppose we have two different GeoRegions, we have constructed several different ways of testing various forms of equivalence.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> GeoRegions</span></span></code></pre></div><h2 id="1.-Are-two-GeoRegions-Equivalent" tabindex="-1">1. Are two GeoRegions Equivalent <a class="header-anchor" href="#1.-Are-two-GeoRegions-Equivalent" aria-label="Permalink to &quot;1. Are two GeoRegions Equivalent {#1.-Are-two-GeoRegions-Equivalent}&quot;">​</a></h2><p>If you want to check that two GeoRegions are equivalent, we can use the <code>==</code> or <code>isequal()</code> functions.</p><h3 id="1.-Strict-Equivalence" tabindex="-1">1. Strict Equivalence <a class="header-anchor" href="#1.-Strict-Equivalence" aria-label="Permalink to &quot;1. Strict Equivalence {#1.-Strict-Equivalence}&quot;">​</a></h3><p>For <code>==</code> or <code>isequal(geo1,geo2,strict = true)</code> to return true, the following conditions must be satisfied:</p><ul><li><p>The <code>ID</code> and <code>pID</code> fields are the same</p></li><li><p>The <code>shape</code> fields define exactly the same geographic region as per the function <a href="/GeoRegions.jl/v7.0.0/basics/using/ison"><code>on()</code></a></p></li><li><p>The <code>GeoRegion</code> must be of the same <code>type</code> (i.e., a <code>RectRegion</code> will not considered to be equivalent to a <code>PolyRegion</code> even if they have the same shape)</p></li></ul><p>Let us consider the following example. First, we load a <code>RectRegion</code> and extract its <code>lon</code> and <code>lat</code> coordinates</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> GeoRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">lon,lat </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> coordinates</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">nothing</span></span></code></pre></div><p>We define <code>RectRegion</code>s that are of the same shape (note that because <code>save = false</code> that the same <code>ID</code> can be used to define these GeoRegions):</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo2 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RectRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GLB&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">bound)          </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Different name</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo3 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RectRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GLB&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">name,geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">bound)       </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Different ID</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo4 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> PolyRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GLB&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">name,lon,lat)      </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Different ID</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo5 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> PolyRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GLB&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,lon,lat)            </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Different ID</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo6 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> PolyRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GLB&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">name,lon</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.+</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">360</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,lat) </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Shifted by 360º</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>The Polygonal Region GF_SEA has the following properties:</span></span>
<span class="line"><span>    Region ID     (ID) : GF_SEA</span></span>
<span class="line"><span>    Parent ID    (pID) : GLB</span></span>
<span class="line"><span>    Name        (name) : Southeast Asia</span></span>
<span class="line"><span>    Bounds   (N,S,E,W) : [20.0, -15.0, 525.0, 450.0]</span></span>
<span class="line"><span>    Shape      (shape) : Point{2, Float64}[[450.0, 20.0], [525.0, 20.0], [525.0, -15.0], [450.0, -15.0], [450.0, 20.0]]</span></span></code></pre></div><p>And we perform the tests with <code>==</code>:</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">==</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geo2, </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># true,  name is not a factor in considering equivalence</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">==</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geo3, </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># false, different ID</span></span>
<span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">==</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> geo4  </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># false, different GeoRegion type</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(true, false, false)</span></span></code></pre></div><p>See the API <a href="/GeoRegions.jl/v7.0.0/api/isinonequal#Base.:==-Tuple{GeoRegion, GeoRegion}">here</a></p><p>And we perform the tests with <code>isequal()</code></p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isequal</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,geo2), </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># true,  name is not a factor in considering equivalence</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isequal</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,geo3), </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># false, different ID</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isequal</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,geo4)  </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># false, different GeoRegion type</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(true, false, false)</span></span></code></pre></div><p>See the API <a href="/GeoRegions.jl/v7.0.0/api/isinonequal#Base.isequal-Tuple{RectRegion, RectRegion}">here</a></p><h3 id="1.2-Non-Strict-Equivalence" tabindex="-1">1.2 Non-Strict Equivalence <a class="header-anchor" href="#1.2-Non-Strict-Equivalence" aria-label="Permalink to &quot;1.2 Non-Strict Equivalence {#1.2-Non-Strict-Equivalence}&quot;">​</a></h3><p><code>isequal()</code> also has a <code>strict = false</code> option, where we do not care if the <code>GeoRegion</code>s being compared are of the same <code>type</code> (i.e., a <code>RectRegion</code> can be equivalent to a <code>PolyRegion</code> as long as the <code>ID</code>, <code>pID</code> and <code>shape</code> fields are equivalent).</p><p>So, we can see that</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isequal</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,geo4,strict</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">), </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># true, the shape is the same even though the GeoRegions are of different types</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isequal</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,geo5,strict</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">), </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># false, the ID is different</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isequal</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo,geo6,strict</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">) </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># true, shape is same even tho shift is by 360º</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(true, true, true)</span></span></code></pre></div><h2 id="2.-Does-there-already-exist-a-GeoRegion?" tabindex="-1">2. Does there already exist a GeoRegion? <a class="header-anchor" href="#2.-Does-there-already-exist-a-GeoRegion?" aria-label="Permalink to &quot;2. Does there already exist a GeoRegion? {#2.-Does-there-already-exist-a-GeoRegion?}&quot;">​</a></h2><p>Sometimes, we want to figure out if there exists a <code>GeoRegion</code> <code>geo</code> in a project we have defined (for more information on how to use GeoRegions.jl in projects, see <a href="/GeoRegions.jl/v7.0.0/tutorials/projects">here</a>). We can use the function <code>isgeo()</code> to determine if this is the case. For <code>isgeo()</code> to be true, there must exist another <code>GeoRegion</code> <code>ogeo</code> such that <code>isequal(geo,ogeo) = true</code>.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo_SEA </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> RectRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GLB&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;New Southeast Asia&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,geo</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">.</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">bound)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isgeo</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo_SEA)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>true</span></span></code></pre></div><p>We see here that <code>isgeo(geo,geo_SEA) = true</code> because the <code>ID</code>, <code>pID</code> and <code>shape</code> of the newly defined <code>geo_SEA</code> is the same as <code>geo</code>.</p><p>See the API <a href="/GeoRegions.jl/v7.0.0/api/isinonequal#GeoRegions.isgeo-Tuple{GeoRegion}">here</a></p><h2 id="3.-Property-Checks-for-GeoRegions" tabindex="-1">3. Property Checks for GeoRegions <a class="header-anchor" href="#3.-Property-Checks-for-GeoRegions" aria-label="Permalink to &quot;3. Property Checks for GeoRegions {#3.-Property-Checks-for-GeoRegions}&quot;">​</a></h2><p>Sometimes, we don&#39;t want to check if a <code>GeoRegion</code> specifically exists. Sometimes, we just want to check if an <code>ID</code> or a <code>shape</code> already exists in the current project.</p><h3 id="3.1-Checking-if-an-ID-already-exists" tabindex="-1">3.1 Checking if an <code>ID</code> already exists <a class="header-anchor" href="#3.1-Checking-if-an-ID-already-exists" aria-label="Permalink to &quot;3.1 Checking if an \`ID\` already exists {#3.1-Checking-if-an-ID-already-exists}&quot;">​</a></h3><p>The function <code>isID()</code> allows us to check if an <code>ID</code> is already in use for a current project.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isID</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GF_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">), </span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isID</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;AR6_SEA&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(true, true)</span></span></code></pre></div><p>See the API <a href="/GeoRegions.jl/v7.0.0/api/isinonequal#GeoRegions.isID-Tuple{AbstractString}">here</a></p><h3 id="3.1-Checking-if-a-GeoRegion-has-an-equivalent-shape" tabindex="-1">3.1 Checking if a GeoRegion has an equivalent <code>shape</code> <a class="header-anchor" href="#3.1-Checking-if-a-GeoRegion-has-an-equivalent-shape" aria-label="Permalink to &quot;3.1 Checking if a GeoRegion has an equivalent \`shape\` {#3.1-Checking-if-a-GeoRegion-has-an-equivalent-shape}&quot;">​</a></h3><p>The function <code>isgeoshape()</code> allows us to check if another GeoRegion in the project has an equivalent <code>shape</code>.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">geo_tmp1 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> PolyRegion</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;TST&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;GLB&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#032F62;--shiki-dark:#9ECBFF;">&quot;&quot;</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,lon,lat) </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># lon,lat taken from above example</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isgeoshape</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(geo_tmp1,path</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">pwd</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">())</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>true</span></span></code></pre></div><p>See the API <a href="/GeoRegions.jl/v7.0.0/api/isinonequal#GeoRegions.isgeoshape-Tuple{GeoRegion}">here</a></p><h3 id="3.2-Checking-if-a-shape-defined-by-(lon,lat)-is-defined-in-an-existing-GeoRegion" tabindex="-1">3.2 Checking if a <code>shape</code> defined by (lon,lat) is defined in an existing GeoRegion <a class="header-anchor" href="#3.2-Checking-if-a-shape-defined-by-(lon,lat)-is-defined-in-an-existing-GeoRegion" aria-label="Permalink to &quot;3.2 Checking if a \`shape\` defined by (lon,lat) is defined in an existing GeoRegion {#3.2-Checking-if-a-shape-defined-by-(lon,lat)-is-defined-in-an-existing-GeoRegion}&quot;">​</a></h3><p>The function <code>isgeoshape()</code> also allows us to check if another GeoRegion in the project has an equivalent <code>shape</code> to that which would be defined by a set of <code>lon</code> and <code>lat</code> vectors.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isgeoshape</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(lon,lat,path</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">pwd</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()),                    </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># lon,lat taken from above example</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">isgeoshape</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">([</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">20</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">30</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">40</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">20</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],[</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">10</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">30</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">10</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">10</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">],path</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">pwd</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()) </span><span style="--shiki-light:#6A737D;--shiki-dark:#6A737D;"># Randomly defined lon,lat</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>(true, false)</span></span></code></pre></div><p>The first is true but the second is false.</p><p>See the API <a href="/GeoRegions.jl/v7.0.0/api/isinonequal#GeoRegions.isgeoshape-Tuple{Vector{&lt;:Real}, Vector{&lt;:Real}}">here</a></p>`,50)]))}const c=i(n,[["render",h]]);export{g as __pageData,c as default};
