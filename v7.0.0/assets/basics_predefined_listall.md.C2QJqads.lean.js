import{_ as a,c as n,a4 as e,o as i}from"./chunks/framework.C_-3PYrn.js";const R=JSON.parse('{"title":"Default List of Predefined GeoRegions","description":"","frontmatter":{},"headers":[],"relativePath":"basics/predefined/listall.md","filePath":"basics/predefined/listall.md","lastUpdated":null}'),t={name:"basics/predefined/listall.md"};function p(l,s,o,r,c,g){return i(),n("div",null,s[0]||(s[0]=[e(`<h1 id="Default-List-of-Predefined-GeoRegions" tabindex="-1">Default List of Predefined GeoRegions <a class="header-anchor" href="#Default-List-of-Predefined-GeoRegions" aria-label="Permalink to &quot;Default List of Predefined GeoRegions {#Default-List-of-Predefined-GeoRegions}&quot;">​</a></h1><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> GeoRegions</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">setupGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(overwrite</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">);</span></span></code></pre></div><h2 id="GeoRegions.jl&#39;s-default-region-is-the-Globe" tabindex="-1">GeoRegions.jl&#39;s default region is the Globe <a class="header-anchor" href="#GeoRegions.jl&#39;s-default-region-is-the-Globe" aria-label="Permalink to &quot;GeoRegions.jl&amp;#39;s default region is the Globe {#GeoRegions.jl&#39;s-default-region-is-the-Globe}&quot;">​</a></h2><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(predefined</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,custom</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> ----- ------------ ------- -------- --------------------------- ------------</span></span>
<span class="line"><span>  ID       Type      Name    Parent       Bounds [N,S,E,W]           File</span></span>
<span class="line"><span> ----- ------------ ------- -------- --------------------------- ------------</span></span>
<span class="line"><span>  GLB   RectRegion   Globe    GLB     [90.0, -90.0, 360.0, 0.0]   global.txt</span></span>
<span class="line"><span> ----- ------------ ------- -------- --------------------------- ------------</span></span></code></pre></div><h2 id="Giorgi-and-Francisco-[2000]" tabindex="-1">Giorgi &amp; Francisco [2000] <a class="header-anchor" href="#Giorgi-and-Francisco-[2000]" aria-label="Permalink to &quot;Giorgi &amp;amp; Francisco [2000] {#Giorgi-and-Francisco-[2000]}&quot;">​</a></h2><p>Add the <code>GF_</code> prefix to the 3-letter IDs given in Giorgi &amp; Francisco [2000] to call GeoRegions adapted from this paper. All GeoRegions are defined as the <code>RectRegion</code> type.</p><div class="tip custom-block"><p class="custom-block-title">Defined in GeoRegions &gt; 1.1</p><p>All <code>GF_*</code> domains are defined only in versions ≥1.1</p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableRectRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(giorgi</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,custom</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> -------- ------------ ------------------------ -------- ------------------------------ ------------</span></span>
<span class="line"><span>    ID        Type      Name                     Parent         Bounds [N,S,E,W]            File</span></span>
<span class="line"><span> -------- ------------ ------------------------ -------- ------------------------------ ------------</span></span>
<span class="line"><span>   GLB     RectRegion   Globe                     GLB      [90.0, -90.0, 360.0, 0.0]     global.txt</span></span>
<span class="line"><span>  GF_AUS   RectRegion   Australia                 GLB     [-10.0, -45.0, 155.0, 110.0]   giorgi.txt</span></span>
<span class="line"><span>  GF_AMZ   RectRegion   Amazon Basin              GLB     [15.0, -20.0, 330.0, 275.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_SSA   RectRegion   Southern South America    GLB     [-20.0, -60.0, 320.0, 280.0]   giorgi.txt</span></span>
<span class="line"><span>  GF_CAM   RectRegion   Central America           GLB      [30.0, 10.0, 280.0, 240.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_WNA   RectRegion   Western North America     GLB      [60.0, 30.0, 255.0, 230.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_CNA   RectRegion   Central North America     GLB      [50.0, 30.0, 275.0, 255.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_ENA   RectRegion   Eastern North America     GLB      [50.0, 25.0, 300.0, 275.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_ALA   RectRegion   Alaska                    GLB      [75.0, 50.0, 255.0, 180.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_GRL   RectRegion   Greenland                 GLB      [85.0, 50.0, 350.0, 255.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_MED   RectRegion   Mediterranean Basin       GLB      [50.0, 30.0, 40.0, -10.0]     giorgi.txt</span></span>
<span class="line"><span>  GF_NEU   RectRegion   Northern Europe           GLB      [75.0, 50.0, 40.0, -10.0]     giorgi.txt</span></span>
<span class="line"><span>  GF_WAF   RectRegion   Western Africa            GLB      [20.0, -15.0, 25.0, -20.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_EAF   RectRegion   Eastern Africa            GLB      [20.0, -15.0, 55.0, 20.0]     giorgi.txt</span></span>
<span class="line"><span>  GF_SAF   RectRegion   Southern Africa           GLB     [-10.0, -35.0, 55.0, -10.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_SAH   RectRegion   Sahara                    GLB      [30.0, 15.0, 65.0, -20.0]     giorgi.txt</span></span>
<span class="line"><span>  GF_SEA   RectRegion   Southeast Asia            GLB      [20.0, -15.0, 165.0, 90.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_EAS   RectRegion   East Asia                 GLB      [50.0, 20.0, 145.0, 100.0]    giorgi.txt</span></span>
<span class="line"><span>  GF_SAS   RectRegion   South Asia                GLB       [30.0, 5.0, 100.0, 65.0]     giorgi.txt</span></span>
<span class="line"><span>  GF_CAS   RectRegion   Central Asia              GLB       [50.0, 30.0, 75.0, 40.0]     giorgi.txt</span></span>
<span class="line"><span>  GF_TIB   RectRegion   Tibet                     GLB      [50.0, 30.0, 100.0, 75.0]     giorgi.txt</span></span>
<span class="line"><span>  GF_NAS   RectRegion   North Asia                GLB      [85.0, 50.0, 180.0, 40.0]     giorgi.txt</span></span>
<span class="line"><span> -------- ------------ ------------------------ -------- ------------------------------ ------------</span></span></code></pre></div><h2 id="SREX-Regions-from-Seneviratne-et-al.-[2012]" tabindex="-1">SREX Regions from Seneviratne et al. [2012] <a class="header-anchor" href="#SREX-Regions-from-Seneviratne-et-al.-[2012]" aria-label="Permalink to &quot;SREX Regions from Seneviratne et al. [2012] {#SREX-Regions-from-Seneviratne-et-al.-[2012]}&quot;">​</a></h2><p>Add the <code>SRX_</code> prefix to the 3-letter IDs given in Seneviratne et al. [2012] to call GeoRegions adapted from this paper. All GeoRegions are defined as the <code>PolyRegion</code> type, even though many of them are rectilinear.</p><div class="tip custom-block"><p class="custom-block-title">Defined in GeoRegions ≧ 2</p><p>All <code>SRX_*</code> domains are defined only in versions ≥2</p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tablePolyRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(srex</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,ar6</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,custom</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> --------- ------------ ---------------------------- -------- ------------------------------- ------------</span></span>
<span class="line"><span>    ID         Type      Name                         Parent         Bounds [N,S,E,W]             File</span></span>
<span class="line"><span> --------- ------------ ---------------------------- -------- ------------------------------- ------------</span></span>
<span class="line"><span>    GLB     RectRegion   Globe                         GLB       [90.0, -90.0, 360.0, 0.0]     global.txt</span></span>
<span class="line"><span>  SRX_ALA   PolyRegion   Alaska/N.W. Canada            GLB     [72.6, 60.0, -105.0, -168.0]     srex.txt</span></span>
<span class="line"><span>  SRX_AMZ   PolyRegion   Amazon                        GLB      [11.4, -20.0, -50.0, -79.7]     srex.txt</span></span>
<span class="line"><span>  SRX_CAM   PolyRegion   Central America/Mexico        GLB      [28.6, -1.2, -68.8, -118.3]     srex.txt</span></span>
<span class="line"><span>  SRX_CAR   PolyRegion   Caribbean                     GLB      [25.0, 11.4, -60.0, -85.8]      srex.txt</span></span>
<span class="line"><span>  SRX_CAS   PolyRegion   Central Asia                  GLB       [50.0, 30.0, 75.0, 60.0]       srex.txt</span></span>
<span class="line"><span>  SRX_CEU   PolyRegion   Central Europe                GLB       [61.3, 45.0, 40.0, -10.0]      srex.txt</span></span>
<span class="line"><span>  SRX_CGI   PolyRegion   Canada/Greenland/Iceland      GLB      [85.0, 50.0, -10.0, -105.0]     srex.txt</span></span>
<span class="line"><span>  SRX_CNA   PolyRegion   Central North America         GLB      [50.0, 28.6, -85.0, -105.0]     srex.txt</span></span>
<span class="line"><span>  SRX_EAF   PolyRegion   East Africa                   GLB       [15.0, -11.4, 52.0, 25.0]      srex.txt</span></span>
<span class="line"><span>  SRX_EAS   PolyRegion   East Asia                     GLB      [50.0, 20.0, 145.0, 100.0]      srex.txt</span></span>
<span class="line"><span>  SRX_ENA   PolyRegion   East North America            GLB      [50.0, 25.0, -60.0, -85.0]      srex.txt</span></span>
<span class="line"><span>  SRX_MED   PolyRegion   South Europe/Mediterranean    GLB       [45.0, 30.0, 40.0, -10.0]      srex.txt</span></span>
<span class="line"><span>  SRX_NAS   PolyRegion   North Asia                    GLB       [70.0, 50.0, 180.0, 40.0]      srex.txt</span></span>
<span class="line"><span>  SRX_NAU   PolyRegion   North Australia               GLB     [-10.0, -30.0, 155.0, 110.0]     srex.txt</span></span>
<span class="line"><span>  SRX_NEB   PolyRegion   Northeast Brazil              GLB      [0.0, -20.0, -34.0, -50.0]      srex.txt</span></span>
<span class="line"><span>  SRX_NEU   PolyRegion   North Europe                  GLB       [75.0, 48.0, 40.0, -10.0]      srex.txt</span></span>
<span class="line"><span>  SRX_SAF   PolyRegion   Southern Africa               GLB      [-11.4, -35.0, 52.0, -10.0]     srex.txt</span></span>
<span class="line"><span>  SRX_SAH   PolyRegion   Sahara                        GLB       [30.0, 15.0, 40.0, -20.0]      srex.txt</span></span>
<span class="line"><span>  SRX_SAS   PolyRegion   South Asia                    GLB       [30.0, 5.0, 100.0, 60.0]       srex.txt</span></span>
<span class="line"><span>  SRX_SAU   PolyRegion   South Australia/NewZealand    GLB     [-30.0, -50.0, 180.0, 110.0]     srex.txt</span></span>
<span class="line"><span>  SRX_SEA   PolyRegion   Southeast Asia                GLB      [20.0, -10.0, 155.0, 95.0]      srex.txt</span></span>
<span class="line"><span>  SRX_SSA   PolyRegion   Southeastern South America    GLB     [-20.0, -56.7, -39.4, -72.1]     srex.txt</span></span>
<span class="line"><span>  SRX_TIB   PolyRegion   Tibetan Plateau               GLB       [50.0, 30.0, 100.0, 75.0]      srex.txt</span></span>
<span class="line"><span>  SRX_WAF   PolyRegion   West Africa                   GLB      [15.0, -11.4, 25.0, -20.0]      srex.txt</span></span>
<span class="line"><span>  SRX_WAS   PolyRegion   West Asia                     GLB       [50.0, 15.0, 60.0, 40.0]       srex.txt</span></span>
<span class="line"><span>  SRX_WNA   PolyRegion   Northwest America             GLB     [60.0, 28.6, -105.0, -130.0]     srex.txt</span></span>
<span class="line"><span>  SRX_WSA   PolyRegion   West Coast South America      GLB      [0.5, -56.7, -66.4, -82.0]      srex.txt</span></span>
<span class="line"><span>  SRX_ANT   PolyRegion   Antarctica                    GLB     [-50.0, -90.0, 180.0, -180.0]    srex.txt</span></span>
<span class="line"><span>  SRX_ARC   PolyRegion   Arctic                        GLB      [90.0, 67.5, 180.0, -180.0]     srex.txt</span></span>
<span class="line"><span>  SRX_NTP   PolyRegion   Pacific Islands               GLB       [25.0, 5.0, 210.0, 155.0]      srex.txt</span></span>
<span class="line"><span>  SRX_STP   PolyRegion   Southern Tropical Pacific     GLB      [-5.0, -25.0, 230.0, 155.0]     srex.txt</span></span>
<span class="line"><span>  SRX_ETP   PolyRegion   Eastern Tropical Pacific      GLB       [5.0, -5.0, 210.0, 155.0]      srex.txt</span></span>
<span class="line"><span>  SRX_WIO   PolyRegion   West Indian Ocean             GLB       [5.0, -25.0, 75.0, 52.0]       srex.txt</span></span>
<span class="line"><span> --------- ------------ ---------------------------- -------- ------------------------------- ------------</span></span></code></pre></div><h2 id="IPCC-AR6-Regions-from-Iturbide-et-al.,-[2020]" tabindex="-1">IPCC AR6 Regions from Iturbide et al., [2020] <a class="header-anchor" href="#IPCC-AR6-Regions-from-Iturbide-et-al.,-[2020]" aria-label="Permalink to &quot;IPCC AR6 Regions from Iturbide et al., [2020] {#IPCC-AR6-Regions-from-Iturbide-et-al.,-[2020]}&quot;">​</a></h2><p>Add the <code>AR6_</code> prefix to the 3-letter IDs given in Iturbide et al., [2020] to call GeoRegions adapted from this paper. All GeoRegions are defined as the <code>PolyRegion</code> type.</p><div class="tip custom-block"><p class="custom-block-title">Defined in GeoRegions ≧ 2</p><p>All <code>AR6_*</code> domains are defined only in versions ≥2</p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tablePolyRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(ar6</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,srex</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">,custom</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> ---------- ------------ --------------------------- -------- ------------------------------- ------------</span></span>
<span class="line"><span>     ID         Type      Name                        Parent         Bounds [N,S,E,W]             File</span></span>
<span class="line"><span> ---------- ------------ --------------------------- -------- ------------------------------- ------------</span></span>
<span class="line"><span>    GLB      RectRegion   Globe                        GLB       [90.0, -90.0, 360.0, 0.0]     global.txt</span></span>
<span class="line"><span>  AR6_GIC    PolyRegion   Greenland/Iceland            GLB      [85.0, 58.0, -10.0, -82.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_NWN    PolyRegion   Northwest North America      GLB     [81.0, 50.0, -105.0, -168.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_NEN    PolyRegion   Northeast North America      GLB      [85.0, 50.0, -50.0, -105.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_WNA    PolyRegion   Western North America        GLB     [50.0, 33.8, -105.0, -130.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_CNA    PolyRegion   Central North America        GLB      [50.0, 25.0, -90.0, -105.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_ENA    PolyRegion   Eastern North America        GLB      [50.0, 25.0, -50.0, -90.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_NCA    PolyRegion   Northern Central America     GLB      [33.8, 16.0, -90.0, -122.5]     ar6.txt</span></span>
<span class="line"><span>  AR6_SCA    PolyRegion   Southern Central America     GLB      [25.0, 2.2, -75.0, -104.5]      ar6.txt</span></span>
<span class="line"><span>  AR6_CAR    PolyRegion   Caribbean                    GLB      [25.0, 12.0, -55.0, -90.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_NWS    PolyRegion   Northwest South America      GLB      [12.0, -15.0, -72.0, -83.4]     ar6.txt</span></span>
<span class="line"><span>  AR6_NSA    PolyRegion   Northern South America       GLB      [12.0, -8.0, -50.0, -72.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_NES    PolyRegion   Northeast South America      GLB      [0.0, -20.0, -34.0, -50.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_SAM    PolyRegion   South American Monsoon       GLB      [-8.0, -20.0, -50.0, -72.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_SWS    PolyRegion   Southwest South America      GLB     [-15.0, -47.0, -66.4, -79.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_SES    PolyRegion   Southeast South America      GLB     [-20.0, -40.0, -34.0, -70.2]     ar6.txt</span></span>
<span class="line"><span>  AR6_SSA    PolyRegion   Southern South America       GLB     [-40.0, -56.0, -56.0, -79.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_NEU    PolyRegion   Northern Europe              GLB       [72.6, 48.0, 40.0, -10.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_WCE    PolyRegion   West and Central Europe      GLB       [61.3, 45.0, 40.0, -10.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_EEU    PolyRegion   Eastern Europe               GLB       [65.0, 45.0, 60.0, 40.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_MED    PolyRegion   Mediterranean                GLB       [45.0, 30.0, 40.0, -10.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_SAH    PolyRegion   Sahara                       GLB       [30.0, 14.7, 42.1, -20.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_WAF    PolyRegion   Western Africa               GLB       [14.7, 0.0, 15.0, -20.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_CAF    PolyRegion   Central Africa               GLB       [14.7, -10.0, 27.0, 8.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_NEAF   PolyRegion   Northern East Africa         GLB        [15.0, 2.3, 53.0, 27.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_SEAF   PolyRegion   Southern East Africa         GLB       [2.3, -10.0, 46.5, 27.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_WSAF   PolyRegion   Western South Africa         GLB       [-10.0, -36.0, 25.0, 8.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_ESAF   PolyRegion   Eastern South Africa         GLB      [-10.0, -36.0, 46.5, 25.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_MDG    PolyRegion   Madagascar                   GLB      [-10.0, -27.0, 53.0, 36.2]      ar6.txt</span></span>
<span class="line"><span>  AR6_RAR    PolyRegion   Arctic Russia                GLB       [82.0, 65.0, 192.0, 40.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_WSB    PolyRegion   Western Siberia              GLB       [65.0, 45.0, 90.0, 60.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_ESB    PolyRegion   Eastern Siberia              GLB       [65.0, 45.0, 130.0, 90.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_RFE    PolyRegion   Far East Russia              GLB      [65.0, 45.0, 180.0, 130.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_WCA    PolyRegion   Western Central Asia         GLB       [45.0, 23.5, 75.0, 40.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_ECA    PolyRegion   Eastern Central Asia         GLB       [45.0, 37.0, 117.0, 75.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_TIB    PolyRegion   Tibetian Plateau             GLB       [37.0, 26.0, 100.0, 75.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_EAS    PolyRegion   East Asia                    GLB      [45.0, 19.5, 152.0, 100.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_ARP    PolyRegion   Arabian Peninsular           GLB       [30.0, 12.0, 60.0, 33.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_SAS    PolyRegion   South Asia                   GLB       [30.0, 7.0, 100.0, 60.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_SEA    PolyRegion   Southeast Asia               GLB      [19.5, -10.0, 155.0, 93.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_NAU    PolyRegion   Northern Australia           GLB     [-10.0, -20.0, 155.0, 110.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_CAU    PolyRegion   Central Australia            GLB     [-20.0, -32.9, 145.5, 110.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_EAU    PolyRegion   Eastern Australia            GLB     [-20.0, -38.0, 155.0, 145.5]     ar6.txt</span></span>
<span class="line"><span>  AR6_SAU    PolyRegion   Southern Australia           GLB     [-30.0, -50.0, 155.0, 110.0]     ar6.txt</span></span>
<span class="line"><span>   AR6_NZ    PolyRegion   New Zealand                  GLB     [-30.0, -50.0, 180.0, 155.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_EAN    PolyRegion   East Antarctica              GLB     [-64.0, -90.0, 180.0, -180.0]    ar6.txt</span></span>
<span class="line"><span>  AR6_WAN    PolyRegion   West Antarctica              GLB     [-62.0, -83.0, -56.0, -180.0]    ar6.txt</span></span>
<span class="line"><span>  AR6_ARO    PolyRegion   Arctic Ocean                 GLB      [90.0, 72.6, 180.0, -180.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_NPO    PolyRegion   Northern Pacific Ocean       GLB       [65.0, 7.6, 268.3, 132.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_EPO    PolyRegion   Equatorial Pacific Ocean     GLB      [7.6, -10.0, 276.6, 132.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_SPO    PolyRegion   Southern Pacific Ocean       GLB     [-10.0, -56.0, 285.4, 155.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_NAO    PolyRegion   Northern Atlantic Ocean      GLB       [62.0, 7.6, -10.0, -77.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_EAO    PolyRegion   Equatorial Atlantic Ocean    GLB       [7.6, -10.0, 8.0, -50.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_SAO    PolyRegion   Southern Atlantic Ocean      GLB      [-10.0, -56.0, 8.0, -56.0]      ar6.txt</span></span>
<span class="line"><span>  AR6_ARS    PolyRegion   Arabian Sea                  GLB        [23.5, 7.0, 76.0, 53.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_BOB    PolyRegion   Bay of Bengal                GLB        [19.5, 7.0, 93.0, 79.0]       ar6.txt</span></span>
<span class="line"><span>  AR6_EIO    PolyRegion   Equatorial Indian Ocean      GLB       [7.0, -10.0, 93.0, 46.5]       ar6.txt</span></span>
<span class="line"><span>  AR6_SIO    PolyRegion   Southern Indian Ocean        GLB      [-10.0, -36.0, 110.0, 31.0]     ar6.txt</span></span>
<span class="line"><span>  AR6_SOO    PolyRegion   Southern Ocean               GLB     [-36.0, -75.0, 180.0, -180.0]    ar6.txt</span></span>
<span class="line"><span> ---------- ------------ --------------------------- -------- ------------------------------- ------------</span></span></code></pre></div>`,20)]))}const d=a(t,[["render",p]]);export{R as __pageData,d as default};
