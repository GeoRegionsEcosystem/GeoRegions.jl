import{_ as n,c as a,a5 as e,o as i}from"./chunks/framework.D0cFjeDR.js";const h=JSON.parse('{"title":"Default List of Predefined GeoRegions","description":"","frontmatter":{},"headers":[],"relativePath":"lists/default.md","filePath":"lists/default.md","lastUpdated":null}'),t={name:"lists/default.md"};function p(l,s,o,r,c,g){return i(),a("div",null,s[0]||(s[0]=[e(`<h1 id="Default-List-of-Predefined-GeoRegions" tabindex="-1">Default List of Predefined GeoRegions <a class="header-anchor" href="#Default-List-of-Predefined-GeoRegions" aria-label="Permalink to &quot;Default List of Predefined GeoRegions {#Default-List-of-Predefined-GeoRegions}&quot;">​</a></h1><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">using</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;"> GeoRegions</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">resetGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(all</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">);</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span>[ Info: 2024-09-07T04:58:42.826 - GeoRegions.jl - Resetting the custom lists of GeoRegions back to the default</span></span>
<span class="line"><span>┌ Warning: 2024-09-07T04:58:42.904 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/rectlist.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/rectlist.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:250</span></span>
<span class="line"><span>┌ Warning: 2024-09-07T04:58:42.912 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/polylist.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/polylist.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:250</span></span>
<span class="line"><span>┌ Warning: 2024-09-07T04:58:42.912 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/tiltlist.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/tiltlist.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:250</span></span>
<span class="line"><span>[ Info: 2024-09-07T04:58:42.912 - GeoRegions.jl - Resetting the predefined lists of GeoRegions back to the default</span></span>
<span class="line"><span>┌ Warning: 2024-09-07T04:58:42.915 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/giorgi.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/giorgi.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:250</span></span>
<span class="line"><span>┌ Warning: 2024-09-07T04:58:42.915 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/srex.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/srex.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:250</span></span>
<span class="line"><span>┌ Warning: 2024-09-07T04:58:42.915 - GeoRegions.jl - Overwriting /home/runner/.julia/files/GeoRegions/ar6.txt with original file in /home/runner/work/GeoRegions.jl/GeoRegions.jl/src/georegions/../../extra/ar6.txt ...</span></span>
<span class="line"><span>└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/read.jl:250</span></span></code></pre></div><h2 id="GeoRegions.jl&#39;s-default-region-is-the-Globe" tabindex="-1">GeoRegions.jl&#39;s default region is the Globe <a class="header-anchor" href="#GeoRegions.jl&#39;s-default-region-is-the-Globe" aria-label="Permalink to &quot;GeoRegions.jl&amp;#39;s default region is the Globe {#GeoRegions.jl&#39;s-default-region-is-the-Globe}&quot;">​</a></h2><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(predefined</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> ----- ------------ ------- -------- --------------</span></span>
<span class="line"><span>  ID       Type      Name    Parent       File</span></span>
<span class="line"><span> ----- ------------ ------- -------- --------------</span></span>
<span class="line"><span>  GLB   RectRegion   Globe    GLB     rectlist.txt</span></span>
<span class="line"><span> ----- ------------ ------- -------- --------------</span></span></code></pre></div><h2 id="Giorgi-and-Francisco-[2000]" tabindex="-1">Giorgi &amp; Francisco [2000] <a class="header-anchor" href="#Giorgi-and-Francisco-[2000]" aria-label="Permalink to &quot;Giorgi &amp;amp; Francisco [2000] {#Giorgi-and-Francisco-[2000]}&quot;">​</a></h2><p>Add the <code>GF_</code> prefix to the 3-letter IDs given in Giorgi &amp; Francisco [2000] to call GeoRegions adapted from this paper. All GeoRegions are defined as the <code>RectRegion</code> type.</p><div class="tip custom-block"><p class="custom-block-title">Defined in GeoRegions &gt; 1.1</p><p>All <code>GF_*</code> domains are defined only in versions ≥1.1</p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableRectRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(giorgi</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> -------- ------------ ------------------------ -------- --------------</span></span>
<span class="line"><span>    ID        Type      Name                     Parent       File</span></span>
<span class="line"><span> -------- ------------ ------------------------ -------- --------------</span></span>
<span class="line"><span>   GLB     RectRegion   Globe                     GLB     rectlist.txt</span></span>
<span class="line"><span>  GF_AUS   RectRegion   Australia                 GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_AMZ   RectRegion   Amazon Basin              GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_SSA   RectRegion   Southern South America    GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_CAM   RectRegion   Central America           GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_WNA   RectRegion   Western North America     GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_CNA   RectRegion   Central North America     GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_ENA   RectRegion   Eastern North America     GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_ALA   RectRegion   Alaska                    GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_GRL   RectRegion   Greenland                 GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_MED   RectRegion   Mediterranean Basin       GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_NEU   RectRegion   Northern Europe           GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_WAF   RectRegion   Western Africa            GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_EAF   RectRegion   Eastern Africa            GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_SAF   RectRegion   Southern Africa           GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_SAH   RectRegion   Sahara                    GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_SEA   RectRegion   Southeast Asia            GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_EAS   RectRegion   East Asia                 GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_SAS   RectRegion   South Asia                GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_CAS   RectRegion   Central Asia              GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_TIB   RectRegion   Tibet                     GLB      giorgi.txt</span></span>
<span class="line"><span>  GF_NAS   RectRegion   North Asia                GLB      giorgi.txt</span></span>
<span class="line"><span> -------- ------------ ------------------------ -------- --------------</span></span></code></pre></div><h2 id="SREX-Regions-from-Seneviratne-et-al.-[2012]" tabindex="-1">SREX Regions from Seneviratne et al. [2012] <a class="header-anchor" href="#SREX-Regions-from-Seneviratne-et-al.-[2012]" aria-label="Permalink to &quot;SREX Regions from Seneviratne et al. [2012] {#SREX-Regions-from-Seneviratne-et-al.-[2012]}&quot;">​</a></h2><p>Add the <code>SRX_</code> prefix to the 3-letter IDs given in Seneviratne et al. [2012] to call GeoRegions adapted from this paper. All GeoRegions are defined as the <code>PolyRegion</code> type, even though many of them are rectilinear.</p><div class="tip custom-block"><p class="custom-block-title">Defined in GeoRegions ≧ 2</p><p>All <code>SRX_*</code> domains are defined only in versions ≥2</p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tablePolyRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(srex</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> --------- ------------ ---------------------------- -------- ----------</span></span>
<span class="line"><span>    ID         Type      Name                         Parent     File</span></span>
<span class="line"><span> --------- ------------ ---------------------------- -------- ----------</span></span>
<span class="line"><span>  SRX_ALA   PolyRegion   Alaska/N.W. Canada            GLB     srex.txt</span></span>
<span class="line"><span>  SRX_AMZ   PolyRegion   Amazon                        GLB     srex.txt</span></span>
<span class="line"><span>  SRX_CAM   PolyRegion   Central America/Mexico        GLB     srex.txt</span></span>
<span class="line"><span>  SRX_CAR   PolyRegion   Caribbean                     GLB     srex.txt</span></span>
<span class="line"><span>  SRX_CAS   PolyRegion   Central Asia                  GLB     srex.txt</span></span>
<span class="line"><span>  SRX_CEU   PolyRegion   Central Europe                GLB     srex.txt</span></span>
<span class="line"><span>  SRX_CGI   PolyRegion   Canada/Greenland/Iceland      GLB     srex.txt</span></span>
<span class="line"><span>  SRX_CNA   PolyRegion   Central North America         GLB     srex.txt</span></span>
<span class="line"><span>  SRX_EAF   PolyRegion   East Africa                   GLB     srex.txt</span></span>
<span class="line"><span>  SRX_EAS   PolyRegion   East Asia                     GLB     srex.txt</span></span>
<span class="line"><span>  SRX_ENA   PolyRegion   East North America            GLB     srex.txt</span></span>
<span class="line"><span>  SRX_MED   PolyRegion   South Europe/Mediterranean    GLB     srex.txt</span></span>
<span class="line"><span>  SRX_NAS   PolyRegion   North Asia                    GLB     srex.txt</span></span>
<span class="line"><span>  SRX_NAU   PolyRegion   North Australia               GLB     srex.txt</span></span>
<span class="line"><span>  SRX_NEB   PolyRegion   Northeast Brazil              GLB     srex.txt</span></span>
<span class="line"><span>  SRX_NEU   PolyRegion   North Europe                  GLB     srex.txt</span></span>
<span class="line"><span>  SRX_SAF   PolyRegion   Southern Africa               GLB     srex.txt</span></span>
<span class="line"><span>  SRX_SAH   PolyRegion   Sahara                        GLB     srex.txt</span></span>
<span class="line"><span>  SRX_SAS   PolyRegion   South Asia                    GLB     srex.txt</span></span>
<span class="line"><span>  SRX_SAU   PolyRegion   South Australia/NewZealand    GLB     srex.txt</span></span>
<span class="line"><span>  SRX_SEA   PolyRegion   Southeast Asia                GLB     srex.txt</span></span>
<span class="line"><span>  SRX_SSA   PolyRegion   Southeastern South America    GLB     srex.txt</span></span>
<span class="line"><span>  SRX_TIB   PolyRegion   Tibetan Plateau               GLB     srex.txt</span></span>
<span class="line"><span>  SRX_WAF   PolyRegion   West Africa                   GLB     srex.txt</span></span>
<span class="line"><span>  SRX_WAS   PolyRegion   West Asia                     GLB     srex.txt</span></span>
<span class="line"><span>  SRX_WNA   PolyRegion   Northwest America             GLB     srex.txt</span></span>
<span class="line"><span>  SRX_WSA   PolyRegion   West Coast South America      GLB     srex.txt</span></span>
<span class="line"><span>  SRX_ANT   PolyRegion   Antarctica                    GLB     srex.txt</span></span>
<span class="line"><span>  SRX_ARC   PolyRegion   Arctic                        GLB     srex.txt</span></span>
<span class="line"><span>  SRX_NTP   PolyRegion   Pacific Islands               GLB     srex.txt</span></span>
<span class="line"><span>  SRX_STP   PolyRegion   Southern Tropical Pacific     GLB     srex.txt</span></span>
<span class="line"><span>  SRX_ETP   PolyRegion   Eastern Tropical Pacific      GLB     srex.txt</span></span>
<span class="line"><span>  SRX_WIO   PolyRegion   West Indian Ocean             GLB     srex.txt</span></span>
<span class="line"><span> --------- ------------ ---------------------------- -------- ----------</span></span></code></pre></div><h2 id="IPCC-AR6-Regions-from-Iturbide-et-al.,-[2020]" tabindex="-1">IPCC AR6 Regions from Iturbide et al., [2020] <a class="header-anchor" href="#IPCC-AR6-Regions-from-Iturbide-et-al.,-[2020]" aria-label="Permalink to &quot;IPCC AR6 Regions from Iturbide et al., [2020] {#IPCC-AR6-Regions-from-Iturbide-et-al.,-[2020]}&quot;">​</a></h2><p>Add the <code>AR6_</code> prefix to the 3-letter IDs given in Iturbide et al., [2020] to call GeoRegions adapted from this paper. All GeoRegions are defined as the <code>PolyRegion</code> type.</p><div class="tip custom-block"><p class="custom-block-title">Defined in GeoRegions ≧ 2</p><p>All <code>AR6_*</code> domains are defined only in versions ≥2</p></div><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tablePolyRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(ar6</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">true</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="language- vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang"></span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span> ---------- ------------ --------------------------- -------- ---------</span></span>
<span class="line"><span>     ID         Type      Name                        Parent    File</span></span>
<span class="line"><span> ---------- ------------ --------------------------- -------- ---------</span></span>
<span class="line"><span>  AR6_GIC    PolyRegion   Greenland/Iceland            GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NWN    PolyRegion   Northwest North America      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NEN    PolyRegion   Northeast North America      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_WNA    PolyRegion   Western North America        GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_CNA    PolyRegion   Central North America        GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_ENA    PolyRegion   Eastern North America        GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NCA    PolyRegion   Northern Central America     GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SCA    PolyRegion   Southern Central America     GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_CAR    PolyRegion   Caribbean                    GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NWS    PolyRegion   Northwest South America      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NSA    PolyRegion   Northern South America       GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NES    PolyRegion   Northeast South America      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SAM    PolyRegion   South American Monsoon       GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SWS    PolyRegion   Southwest South America      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SES    PolyRegion   Southeast South America      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SSA    PolyRegion   Southern South America       GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NEU    PolyRegion   Northern Europe              GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_WCE    PolyRegion   West and Central Europe      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_EEU    PolyRegion   Eastern Europe               GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_MED    PolyRegion   Mediterranean                GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SAH    PolyRegion   Sahara                       GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_WAF    PolyRegion   Western Africa               GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_CAF    PolyRegion   Central Africa               GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NEAF   PolyRegion   Northern East Africa         GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SEAF   PolyRegion   Southern East Africa         GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_WSAF   PolyRegion   Western South Africa         GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_ESAF   PolyRegion   Eastern South Africa         GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_MDG    PolyRegion   Madagascar                   GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_RAR    PolyRegion   Arctic Russia                GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_WSB    PolyRegion   Western Siberia              GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_ESB    PolyRegion   Eastern Siberia              GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_RFE    PolyRegion   Far East Russia              GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_WCA    PolyRegion   Western Central Asia         GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_ECA    PolyRegion   Eastern Central Asia         GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_TIB    PolyRegion   Tibetian Plateau             GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_EAS    PolyRegion   East Asia                    GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_ARP    PolyRegion   Arabian Peninsular           GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SAS    PolyRegion   South Asia                   GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SEA    PolyRegion   Southeast Asia               GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NAU    PolyRegion   Northern Australia           GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_CAU    PolyRegion   Central Australia            GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_EAU    PolyRegion   Eastern Australia            GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SAU    PolyRegion   Southern Australia           GLB     ar6.txt</span></span>
<span class="line"><span>   AR6_NZ    PolyRegion   New Zealand                  GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_EAN    PolyRegion   East Antarctica              GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_WAN    PolyRegion   West Antarctica              GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_ARO    PolyRegion   Arctic Ocean                 GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NPO    PolyRegion   Northern Pacific Ocean       GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_EPO    PolyRegion   Equatorial Pacific Ocean     GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SPO    PolyRegion   Southern Pacific Ocean       GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_NAO    PolyRegion   Northern Atlantic Ocean      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_EAO    PolyRegion   Equatorial Atlantic Ocean    GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SAO    PolyRegion   Southern Atlantic Ocean      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_ARS    PolyRegion   Arabian Sea                  GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_BOB    PolyRegion   Bay of Bengal                GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_EIO    PolyRegion   Equatorial Indian Ocean      GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SIO    PolyRegion   Southern Indian Ocean        GLB     ar6.txt</span></span>
<span class="line"><span>  AR6_SOO    PolyRegion   Southern Ocean               GLB     ar6.txt</span></span>
<span class="line"><span> ---------- ------------ --------------------------- -------- ---------</span></span></code></pre></div>`,21)]))}const d=n(t,[["render",p]]);export{h as __pageData,d as default};