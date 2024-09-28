import{_ as p,c as r,a4 as c,G as l,w as e,B as t,o as R,j as n,a as s}from"./chunks/framework.CEeYBNx8.js";const y=JSON.parse('{"title":"Tabular Listings of GeoRegions","description":"","frontmatter":{},"headers":[],"relativePath":"basics/read/tables.md","filePath":"basics/read/tables.md","lastUpdated":null}'),g={name:"basics/read/tables.md"};function u(A,a,h,G,x,d){const i=t("PluginTabsTab"),o=t("PluginTabs");return R(),r("div",null,[a[4]||(a[4]=c(`<h1 id="Tabular-Listings-of-GeoRegions" tabindex="-1">Tabular Listings of GeoRegions <a class="header-anchor" href="#Tabular-Listings-of-GeoRegions" aria-label="Permalink to &quot;Tabular Listings of GeoRegions {#Tabular-Listings-of-GeoRegions}&quot;">​</a></h1><p>A list of GeoRegions and their basic properties can be called using the function <code>tableGeoRegions()</code>, which lists all available GeoRegions, both predefined and <a href="/GeoRegions.jl/dev/basics/create">user-defined</a>. You can also choose to list only predefined or user-customized GeoRegions by setting their respective keywords arguments to <code>true/false</code>.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableGeoRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(predefined </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">/</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, custom </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">/</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="tip custom-block"><p class="custom-block-title">Additional Functionality for <code>tableGeoRegions()</code></p><p>It is possible to use <code>tableGeoRegions()</code> to list user-defined <code>GeoRegion</code>s in specific paths/directories. By default, it will list user-defined <code>GeoRegion</code>s saved into the path <code>joinpath(DEPOT_PATH[1],&quot;files&quot;,&quot;GeoRegions&quot;)</code>. For more on user-defined GeoRegions and saving them as part of a larger project, refer to how to <a href="/GeoRegions.jl/dev/tutorials/projects">setup</a> GeoRegions.jl for a project. Full API documentation for <code>tableGeoRegions()</code> is given <a href="/GeoRegions.jl/dev/api/tables">here</a>.</p></div><h2 id="More-specific-lists-of-GeoRegions" tabindex="-1">More specific lists of GeoRegions <a class="header-anchor" href="#More-specific-lists-of-GeoRegions" aria-label="Permalink to &quot;More specific lists of GeoRegions {#More-specific-lists-of-GeoRegions}&quot;">​</a></h2><p>Besides listing all available GeoRegions, it is also possible to list a variety of different subtypes of GeoRegions with the <code>tableRectRegions()</code>, <code>tableTiltRegions()</code> and <code>tablePolyRegions()</code>.</p><div class="language-julia vp-adaptive-theme"><button title="Copy Code" class="copy"></button><span class="lang">julia</span><pre class="shiki shiki-themes github-light github-dark vp-code" tabindex="0"><code><span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableRectRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(giorgi </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">/</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, custom </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">/</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tableTiltRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">()</span></span>
<span class="line"><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">tablePolyRegions</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">(srex </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">/</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, ar6 </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">/</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">, custom </span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">=</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;"> true</span><span style="--shiki-light:#D73A49;--shiki-dark:#F97583;">/</span><span style="--shiki-light:#005CC5;--shiki-dark:#79B8FF;">false</span><span style="--shiki-light:#24292E;--shiki-dark:#E1E4E8;">)</span></span></code></pre></div><div class="tip custom-block"><p class="custom-block-title"><code>GLB</code> Region will always appear</p><p>The <code>GLB</code> GeoRegion will always appear in the table, because it is the ultimate parent GeoRegion. All other <code>GeoRegion</code>s will always in some manner be a subset of the <code>GLB</code> GeoRegion.</p></div><h2 id="Use-Case-Examples" tabindex="-1">Use Case Examples <a class="header-anchor" href="#Use-Case-Examples" aria-label="Permalink to &quot;Use Case Examples {#Use-Case-Examples}&quot;">​</a></h2>`,9)),l(o,null,{default:e(()=>[l(i,{label:"tableGeoRegions()"},{default:e(()=>a[0]||(a[0]=[n("div",{class:"language-julia vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"},"julia"),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"using"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}}," GeoRegions")]),s(`
`),n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"tableGeoRegions"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"(warn"),n("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"="),n("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"false"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},")")])])])],-1),n("div",{class:"language- vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"}),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",null," ---------- ------------ ---------------------------- -------- ------------------------------- ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"     ID         Type      Name                         Parent         Bounds [N,S,E,W]             File")]),s(`
`),n("span",{class:"line"},[n("span",null," ---------- ------------ ---------------------------- -------- ------------------------------- ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"    GLB      RectRegion   Globe                         GLB       [90.0, -90.0, 360.0, 0.0]     global.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_AUS    RectRegion   Australia                     GLB     [-10.0, -45.0, 155.0, 110.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_AMZ    RectRegion   Amazon Basin                  GLB      [15.0, -20.0, 330.0, 275.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_SSA    RectRegion   Southern South America        GLB     [-20.0, -60.0, 320.0, 280.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_CAM    RectRegion   Central America               GLB      [30.0, 10.0, 280.0, 240.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_WNA    RectRegion   Western North America         GLB      [60.0, 30.0, 255.0, 230.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_CNA    RectRegion   Central North America         GLB      [50.0, 30.0, 275.0, 255.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_ENA    RectRegion   Eastern North America         GLB      [50.0, 25.0, 300.0, 275.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_ALA    RectRegion   Alaska                        GLB      [75.0, 50.0, 255.0, 180.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_GRL    RectRegion   Greenland                     GLB      [85.0, 50.0, 350.0, 255.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_MED    RectRegion   Mediterranean Basin           GLB       [50.0, 30.0, 40.0, -10.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_NEU    RectRegion   Northern Europe               GLB       [75.0, 50.0, 40.0, -10.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_WAF    RectRegion   Western Africa                GLB      [20.0, -15.0, 25.0, -20.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_EAF    RectRegion   Eastern Africa                GLB       [20.0, -15.0, 55.0, 20.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_SAF    RectRegion   Southern Africa               GLB      [-10.0, -35.0, 55.0, -10.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_SAH    RectRegion   Sahara                        GLB       [30.0, 15.0, 65.0, -20.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_SEA    RectRegion   Southeast Asia                GLB      [20.0, -15.0, 165.0, 90.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_EAS    RectRegion   East Asia                     GLB      [50.0, 20.0, 145.0, 100.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_SAS    RectRegion   South Asia                    GLB       [30.0, 5.0, 100.0, 65.0]      giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_CAS    RectRegion   Central Asia                  GLB       [50.0, 30.0, 75.0, 40.0]      giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_TIB    RectRegion   Tibet                         GLB       [50.0, 30.0, 100.0, 75.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GF_NAS    RectRegion   North Asia                    GLB       [85.0, 50.0, 180.0, 40.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ALA    PolyRegion   Alaska/N.W. Canada            GLB     [72.6, 60.0, -105.0, -168.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_AMZ    PolyRegion   Amazon                        GLB      [11.4, -20.0, -50.0, -79.7]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CAM    PolyRegion   Central America/Mexico        GLB      [28.6, -1.2, -68.8, -118.3]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CAR    PolyRegion   Caribbean                     GLB      [25.0, 11.4, -60.0, -85.8]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CAS    PolyRegion   Central Asia                  GLB       [50.0, 30.0, 75.0, 60.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CEU    PolyRegion   Central Europe                GLB       [61.3, 45.0, 40.0, -10.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CGI    PolyRegion   Canada/Greenland/Iceland      GLB      [85.0, 50.0, -10.0, -105.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CNA    PolyRegion   Central North America         GLB      [50.0, 28.6, -85.0, -105.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_EAF    PolyRegion   East Africa                   GLB       [15.0, -11.4, 52.0, 25.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_EAS    PolyRegion   East Asia                     GLB      [50.0, 20.0, 145.0, 100.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ENA    PolyRegion   East North America            GLB      [50.0, 25.0, -60.0, -85.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_MED    PolyRegion   South Europe/Mediterranean    GLB       [45.0, 30.0, 40.0, -10.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NAS    PolyRegion   North Asia                    GLB       [70.0, 50.0, 180.0, 40.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NAU    PolyRegion   North Australia               GLB     [-10.0, -30.0, 155.0, 110.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NEB    PolyRegion   Northeast Brazil              GLB      [0.0, -20.0, -34.0, -50.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NEU    PolyRegion   North Europe                  GLB       [75.0, 48.0, 40.0, -10.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAF    PolyRegion   Southern Africa               GLB      [-11.4, -35.0, 52.0, -10.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAH    PolyRegion   Sahara                        GLB       [30.0, 15.0, 40.0, -20.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAS    PolyRegion   South Asia                    GLB       [30.0, 5.0, 100.0, 60.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAU    PolyRegion   South Australia/NewZealand    GLB     [-30.0, -50.0, 180.0, 110.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SEA    PolyRegion   Southeast Asia                GLB      [20.0, -10.0, 155.0, 95.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SSA    PolyRegion   Southeastern South America    GLB     [-20.0, -56.7, -39.4, -72.1]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_TIB    PolyRegion   Tibetan Plateau               GLB       [50.0, 30.0, 100.0, 75.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WAF    PolyRegion   West Africa                   GLB      [15.0, -11.4, 25.0, -20.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WAS    PolyRegion   West Asia                     GLB       [50.0, 15.0, 60.0, 40.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WNA    PolyRegion   Northwest America             GLB     [60.0, 28.6, -105.0, -130.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WSA    PolyRegion   West Coast South America      GLB      [0.5, -56.7, -66.4, -82.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ANT    PolyRegion   Antarctica                    GLB     [-50.0, -90.0, 180.0, -180.0]    srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ARC    PolyRegion   Arctic                        GLB      [90.0, 67.5, 180.0, -180.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NTP    PolyRegion   Pacific Islands               GLB       [25.0, 5.0, 210.0, 155.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_STP    PolyRegion   Southern Tropical Pacific     GLB      [-5.0, -25.0, 230.0, 155.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ETP    PolyRegion   Eastern Tropical Pacific      GLB       [5.0, -5.0, 210.0, 155.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WIO    PolyRegion   West Indian Ocean             GLB       [5.0, -25.0, 75.0, 52.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_GIC    PolyRegion   Greenland/Iceland             GLB      [85.0, 58.0, -10.0, -82.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NWN    PolyRegion   Northwest North America       GLB     [81.0, 50.0, -105.0, -168.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NEN    PolyRegion   Northeast North America       GLB      [85.0, 50.0, -50.0, -105.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WNA    PolyRegion   Western North America         GLB     [50.0, 33.8, -105.0, -130.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CNA    PolyRegion   Central North America         GLB      [50.0, 25.0, -90.0, -105.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ENA    PolyRegion   Eastern North America         GLB      [50.0, 25.0, -50.0, -90.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NCA    PolyRegion   Northern Central America      GLB      [33.8, 16.0, -90.0, -122.5]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SCA    PolyRegion   Southern Central America      GLB      [25.0, 2.2, -75.0, -104.5]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CAR    PolyRegion   Caribbean                     GLB      [25.0, 12.0, -55.0, -90.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NWS    PolyRegion   Northwest South America       GLB      [12.0, -15.0, -72.0, -83.4]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NSA    PolyRegion   Northern South America        GLB      [12.0, -8.0, -50.0, -72.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NES    PolyRegion   Northeast South America       GLB      [0.0, -20.0, -34.0, -50.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAM    PolyRegion   South American Monsoon        GLB      [-8.0, -20.0, -50.0, -72.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SWS    PolyRegion   Southwest South America       GLB     [-15.0, -47.0, -66.4, -79.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SES    PolyRegion   Southeast South America       GLB     [-20.0, -40.0, -34.0, -70.2]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SSA    PolyRegion   Southern South America        GLB     [-40.0, -56.0, -56.0, -79.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NEU    PolyRegion   Northern Europe               GLB       [72.6, 48.0, 40.0, -10.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WCE    PolyRegion   West and Central Europe       GLB       [61.3, 45.0, 40.0, -10.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EEU    PolyRegion   Eastern Europe                GLB       [65.0, 45.0, 60.0, 40.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_MED    PolyRegion   Mediterranean                 GLB       [45.0, 30.0, 40.0, -10.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAH    PolyRegion   Sahara                        GLB       [30.0, 14.7, 42.1, -20.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WAF    PolyRegion   Western Africa                GLB       [14.7, 0.0, 15.0, -20.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CAF    PolyRegion   Central Africa                GLB       [14.7, -10.0, 27.0, 8.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NEAF   PolyRegion   Northern East Africa          GLB        [15.0, 2.3, 53.0, 27.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SEAF   PolyRegion   Southern East Africa          GLB       [2.3, -10.0, 46.5, 27.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WSAF   PolyRegion   Western South Africa          GLB       [-10.0, -36.0, 25.0, 8.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ESAF   PolyRegion   Eastern South Africa          GLB      [-10.0, -36.0, 46.5, 25.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_MDG    PolyRegion   Madagascar                    GLB      [-10.0, -27.0, 53.0, 36.2]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_RAR    PolyRegion   Arctic Russia                 GLB       [82.0, 65.0, 192.0, 40.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WSB    PolyRegion   Western Siberia               GLB       [65.0, 45.0, 90.0, 60.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ESB    PolyRegion   Eastern Siberia               GLB       [65.0, 45.0, 130.0, 90.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_RFE    PolyRegion   Far East Russia               GLB      [65.0, 45.0, 180.0, 130.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WCA    PolyRegion   Western Central Asia          GLB       [45.0, 23.5, 75.0, 40.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ECA    PolyRegion   Eastern Central Asia          GLB       [45.0, 37.0, 117.0, 75.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_TIB    PolyRegion   Tibetian Plateau              GLB       [37.0, 26.0, 100.0, 75.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAS    PolyRegion   East Asia                     GLB      [45.0, 19.5, 152.0, 100.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ARP    PolyRegion   Arabian Peninsular            GLB       [30.0, 12.0, 60.0, 33.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAS    PolyRegion   South Asia                    GLB       [30.0, 7.0, 100.0, 60.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SEA    PolyRegion   Southeast Asia                GLB      [19.5, -10.0, 155.0, 93.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NAU    PolyRegion   Northern Australia            GLB     [-10.0, -20.0, 155.0, 110.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CAU    PolyRegion   Central Australia             GLB     [-20.0, -32.9, 145.5, 110.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAU    PolyRegion   Eastern Australia             GLB     [-20.0, -38.0, 155.0, 145.5]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAU    PolyRegion   Southern Australia            GLB     [-30.0, -50.0, 155.0, 110.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   AR6_NZ    PolyRegion   New Zealand                   GLB     [-30.0, -50.0, 180.0, 155.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAN    PolyRegion   East Antarctica               GLB     [-64.0, -90.0, 180.0, -180.0]    ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WAN    PolyRegion   West Antarctica               GLB     [-62.0, -83.0, -56.0, -180.0]    ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ARO    PolyRegion   Arctic Ocean                  GLB      [90.0, 72.6, 180.0, -180.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NPO    PolyRegion   Northern Pacific Ocean        GLB       [65.0, 7.6, 268.3, 132.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EPO    PolyRegion   Equatorial Pacific Ocean      GLB      [7.6, -10.0, 276.6, 132.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SPO    PolyRegion   Southern Pacific Ocean        GLB     [-10.0, -56.0, 285.4, 155.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NAO    PolyRegion   Northern Atlantic Ocean       GLB       [62.0, 7.6, -10.0, -77.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAO    PolyRegion   Equatorial Atlantic Ocean     GLB       [7.6, -10.0, 8.0, -50.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAO    PolyRegion   Southern Atlantic Ocean       GLB      [-10.0, -56.0, 8.0, -56.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ARS    PolyRegion   Arabian Sea                   GLB        [23.5, 7.0, 76.0, 53.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_BOB    PolyRegion   Bay of Bengal                 GLB        [19.5, 7.0, 93.0, 79.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EIO    PolyRegion   Equatorial Indian Ocean       GLB       [7.0, -10.0, 93.0, 46.5]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SIO    PolyRegion   Southern Indian Ocean         GLB      [-10.0, -36.0, 110.0, 31.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SOO    PolyRegion   Southern Ocean                GLB     [-36.0, -75.0, 180.0, -180.0]    ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null," ---------- ------------ ---------------------------- -------- ------------------------------- ------------")])])])],-1),n("p",null,[s("See the API "),n("a",{href:"/GeoRegions.jl/dev/api/addreadrm#GeoRegions.GeoRegion-Tuple{AbstractString}"},"here")],-1)])),_:1}),l(i,{label:"tableRectRegions()"},{default:e(()=>a[1]||(a[1]=[n("div",{class:"language-julia vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"},"julia"),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"using"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}}," GeoRegions")]),s(`
`),n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"tableRectRegions"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"()")])])])],-1),n("div",{class:"language- vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"}),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",null,'┌ Warning: modulelog - The custom file "rectlist.txt" does not exist in /home/runner, use `setupGeoRegions()` to copy templates and empty custom lists to /home/runner')]),s(`
`),n("span",{class:"line"},[n("span",null,"└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/tables.jl:166")]),s(`
`),n("span",{class:"line"},[n("span",null," -------- ------------ ------------------------ -------- ------------------------------ ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"    ID        Type      Name                     Parent         Bounds [N,S,E,W]            File")]),s(`
`),n("span",{class:"line"},[n("span",null," -------- ------------ ------------------------ -------- ------------------------------ ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"   GLB     RectRegion   Globe                     GLB      [90.0, -90.0, 360.0, 0.0]     global.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_AUS   RectRegion   Australia                 GLB     [-10.0, -45.0, 155.0, 110.0]   giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_AMZ   RectRegion   Amazon Basin              GLB     [15.0, -20.0, 330.0, 275.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_SSA   RectRegion   Southern South America    GLB     [-20.0, -60.0, 320.0, 280.0]   giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_CAM   RectRegion   Central America           GLB      [30.0, 10.0, 280.0, 240.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_WNA   RectRegion   Western North America     GLB      [60.0, 30.0, 255.0, 230.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_CNA   RectRegion   Central North America     GLB      [50.0, 30.0, 275.0, 255.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_ENA   RectRegion   Eastern North America     GLB      [50.0, 25.0, 300.0, 275.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_ALA   RectRegion   Alaska                    GLB      [75.0, 50.0, 255.0, 180.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_GRL   RectRegion   Greenland                 GLB      [85.0, 50.0, 350.0, 255.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_MED   RectRegion   Mediterranean Basin       GLB      [50.0, 30.0, 40.0, -10.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_NEU   RectRegion   Northern Europe           GLB      [75.0, 50.0, 40.0, -10.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_WAF   RectRegion   Western Africa            GLB      [20.0, -15.0, 25.0, -20.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_EAF   RectRegion   Eastern Africa            GLB      [20.0, -15.0, 55.0, 20.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_SAF   RectRegion   Southern Africa           GLB     [-10.0, -35.0, 55.0, -10.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_SAH   RectRegion   Sahara                    GLB      [30.0, 15.0, 65.0, -20.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_SEA   RectRegion   Southeast Asia            GLB      [20.0, -15.0, 165.0, 90.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_EAS   RectRegion   East Asia                 GLB      [50.0, 20.0, 145.0, 100.0]    giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_SAS   RectRegion   South Asia                GLB       [30.0, 5.0, 100.0, 65.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_CAS   RectRegion   Central Asia              GLB       [50.0, 30.0, 75.0, 40.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_TIB   RectRegion   Tibet                     GLB      [50.0, 30.0, 100.0, 75.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GF_NAS   RectRegion   North Asia                GLB      [85.0, 50.0, 180.0, 40.0]     giorgi.txt")]),s(`
`),n("span",{class:"line"},[n("span",null," -------- ------------ ------------------------ -------- ------------------------------ ------------")])])])],-1),n("p",null,[s("See the API "),n("a",{href:"/GeoRegions.jl/dev/api/tables#GeoRegions.tableRectRegions"},"here")],-1)])),_:1}),l(i,{label:"tablePolyRegions()"},{default:e(()=>a[2]||(a[2]=[n("div",{class:"language-julia vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"},"julia"),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"using"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}}," GeoRegions")]),s(`
`),n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"tablePolyRegions"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"()")])])])],-1),n("div",{class:"language- vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"}),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",null,'┌ Warning: modulelog - The custom file "polylist.txt" does not exist in /home/runner, use `setupGeoRegions()` to copy templates and empty custom lists to /home/runner')]),s(`
`),n("span",{class:"line"},[n("span",null,"└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/tables.jl:291")]),s(`
`),n("span",{class:"line"},[n("span",null," ---------- ------------ ---------------------------- -------- ------------------------------- ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"     ID         Type      Name                         Parent         Bounds [N,S,E,W]             File")]),s(`
`),n("span",{class:"line"},[n("span",null," ---------- ------------ ---------------------------- -------- ------------------------------- ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"    GLB      RectRegion   Globe                         GLB       [90.0, -90.0, 360.0, 0.0]     global.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ALA    PolyRegion   Alaska/N.W. Canada            GLB     [72.6, 60.0, -105.0, -168.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_AMZ    PolyRegion   Amazon                        GLB      [11.4, -20.0, -50.0, -79.7]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CAM    PolyRegion   Central America/Mexico        GLB      [28.6, -1.2, -68.8, -118.3]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CAR    PolyRegion   Caribbean                     GLB      [25.0, 11.4, -60.0, -85.8]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CAS    PolyRegion   Central Asia                  GLB       [50.0, 30.0, 75.0, 60.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CEU    PolyRegion   Central Europe                GLB       [61.3, 45.0, 40.0, -10.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CGI    PolyRegion   Canada/Greenland/Iceland      GLB      [85.0, 50.0, -10.0, -105.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_CNA    PolyRegion   Central North America         GLB      [50.0, 28.6, -85.0, -105.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_EAF    PolyRegion   East Africa                   GLB       [15.0, -11.4, 52.0, 25.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_EAS    PolyRegion   East Asia                     GLB      [50.0, 20.0, 145.0, 100.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ENA    PolyRegion   East North America            GLB      [50.0, 25.0, -60.0, -85.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_MED    PolyRegion   South Europe/Mediterranean    GLB       [45.0, 30.0, 40.0, -10.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NAS    PolyRegion   North Asia                    GLB       [70.0, 50.0, 180.0, 40.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NAU    PolyRegion   North Australia               GLB     [-10.0, -30.0, 155.0, 110.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NEB    PolyRegion   Northeast Brazil              GLB      [0.0, -20.0, -34.0, -50.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NEU    PolyRegion   North Europe                  GLB       [75.0, 48.0, 40.0, -10.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAF    PolyRegion   Southern Africa               GLB      [-11.4, -35.0, 52.0, -10.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAH    PolyRegion   Sahara                        GLB       [30.0, 15.0, 40.0, -20.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAS    PolyRegion   South Asia                    GLB       [30.0, 5.0, 100.0, 60.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SAU    PolyRegion   South Australia/NewZealand    GLB     [-30.0, -50.0, 180.0, 110.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SEA    PolyRegion   Southeast Asia                GLB      [20.0, -10.0, 155.0, 95.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_SSA    PolyRegion   Southeastern South America    GLB     [-20.0, -56.7, -39.4, -72.1]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_TIB    PolyRegion   Tibetan Plateau               GLB       [50.0, 30.0, 100.0, 75.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WAF    PolyRegion   West Africa                   GLB      [15.0, -11.4, 25.0, -20.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WAS    PolyRegion   West Asia                     GLB       [50.0, 15.0, 60.0, 40.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WNA    PolyRegion   Northwest America             GLB     [60.0, 28.6, -105.0, -130.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WSA    PolyRegion   West Coast South America      GLB      [0.5, -56.7, -66.4, -82.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ANT    PolyRegion   Antarctica                    GLB     [-50.0, -90.0, 180.0, -180.0]    srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ARC    PolyRegion   Arctic                        GLB      [90.0, 67.5, 180.0, -180.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_NTP    PolyRegion   Pacific Islands               GLB       [25.0, 5.0, 210.0, 155.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_STP    PolyRegion   Southern Tropical Pacific     GLB      [-5.0, -25.0, 230.0, 155.0]     srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_ETP    PolyRegion   Eastern Tropical Pacific      GLB       [5.0, -5.0, 210.0, 155.0]      srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  SRX_WIO    PolyRegion   West Indian Ocean             GLB       [5.0, -25.0, 75.0, 52.0]       srex.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_GIC    PolyRegion   Greenland/Iceland             GLB      [85.0, 58.0, -10.0, -82.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NWN    PolyRegion   Northwest North America       GLB     [81.0, 50.0, -105.0, -168.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NEN    PolyRegion   Northeast North America       GLB      [85.0, 50.0, -50.0, -105.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WNA    PolyRegion   Western North America         GLB     [50.0, 33.8, -105.0, -130.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CNA    PolyRegion   Central North America         GLB      [50.0, 25.0, -90.0, -105.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ENA    PolyRegion   Eastern North America         GLB      [50.0, 25.0, -50.0, -90.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NCA    PolyRegion   Northern Central America      GLB      [33.8, 16.0, -90.0, -122.5]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SCA    PolyRegion   Southern Central America      GLB      [25.0, 2.2, -75.0, -104.5]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CAR    PolyRegion   Caribbean                     GLB      [25.0, 12.0, -55.0, -90.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NWS    PolyRegion   Northwest South America       GLB      [12.0, -15.0, -72.0, -83.4]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NSA    PolyRegion   Northern South America        GLB      [12.0, -8.0, -50.0, -72.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NES    PolyRegion   Northeast South America       GLB      [0.0, -20.0, -34.0, -50.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAM    PolyRegion   South American Monsoon        GLB      [-8.0, -20.0, -50.0, -72.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SWS    PolyRegion   Southwest South America       GLB     [-15.0, -47.0, -66.4, -79.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SES    PolyRegion   Southeast South America       GLB     [-20.0, -40.0, -34.0, -70.2]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SSA    PolyRegion   Southern South America        GLB     [-40.0, -56.0, -56.0, -79.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NEU    PolyRegion   Northern Europe               GLB       [72.6, 48.0, 40.0, -10.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WCE    PolyRegion   West and Central Europe       GLB       [61.3, 45.0, 40.0, -10.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EEU    PolyRegion   Eastern Europe                GLB       [65.0, 45.0, 60.0, 40.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_MED    PolyRegion   Mediterranean                 GLB       [45.0, 30.0, 40.0, -10.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAH    PolyRegion   Sahara                        GLB       [30.0, 14.7, 42.1, -20.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WAF    PolyRegion   Western Africa                GLB       [14.7, 0.0, 15.0, -20.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CAF    PolyRegion   Central Africa                GLB       [14.7, -10.0, 27.0, 8.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NEAF   PolyRegion   Northern East Africa          GLB        [15.0, 2.3, 53.0, 27.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SEAF   PolyRegion   Southern East Africa          GLB       [2.3, -10.0, 46.5, 27.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WSAF   PolyRegion   Western South Africa          GLB       [-10.0, -36.0, 25.0, 8.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ESAF   PolyRegion   Eastern South Africa          GLB      [-10.0, -36.0, 46.5, 25.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_MDG    PolyRegion   Madagascar                    GLB      [-10.0, -27.0, 53.0, 36.2]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_RAR    PolyRegion   Arctic Russia                 GLB       [82.0, 65.0, 192.0, 40.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WSB    PolyRegion   Western Siberia               GLB       [65.0, 45.0, 90.0, 60.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ESB    PolyRegion   Eastern Siberia               GLB       [65.0, 45.0, 130.0, 90.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_RFE    PolyRegion   Far East Russia               GLB      [65.0, 45.0, 180.0, 130.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WCA    PolyRegion   Western Central Asia          GLB       [45.0, 23.5, 75.0, 40.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ECA    PolyRegion   Eastern Central Asia          GLB       [45.0, 37.0, 117.0, 75.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_TIB    PolyRegion   Tibetian Plateau              GLB       [37.0, 26.0, 100.0, 75.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAS    PolyRegion   East Asia                     GLB      [45.0, 19.5, 152.0, 100.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ARP    PolyRegion   Arabian Peninsular            GLB       [30.0, 12.0, 60.0, 33.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAS    PolyRegion   South Asia                    GLB       [30.0, 7.0, 100.0, 60.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SEA    PolyRegion   Southeast Asia                GLB      [19.5, -10.0, 155.0, 93.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NAU    PolyRegion   Northern Australia            GLB     [-10.0, -20.0, 155.0, 110.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_CAU    PolyRegion   Central Australia             GLB     [-20.0, -32.9, 145.5, 110.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAU    PolyRegion   Eastern Australia             GLB     [-20.0, -38.0, 155.0, 145.5]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAU    PolyRegion   Southern Australia            GLB     [-30.0, -50.0, 155.0, 110.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"   AR6_NZ    PolyRegion   New Zealand                   GLB     [-30.0, -50.0, 180.0, 155.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAN    PolyRegion   East Antarctica               GLB     [-64.0, -90.0, 180.0, -180.0]    ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_WAN    PolyRegion   West Antarctica               GLB     [-62.0, -83.0, -56.0, -180.0]    ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ARO    PolyRegion   Arctic Ocean                  GLB      [90.0, 72.6, 180.0, -180.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NPO    PolyRegion   Northern Pacific Ocean        GLB       [65.0, 7.6, 268.3, 132.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EPO    PolyRegion   Equatorial Pacific Ocean      GLB      [7.6, -10.0, 276.6, 132.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SPO    PolyRegion   Southern Pacific Ocean        GLB     [-10.0, -56.0, 285.4, 155.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_NAO    PolyRegion   Northern Atlantic Ocean       GLB       [62.0, 7.6, -10.0, -77.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EAO    PolyRegion   Equatorial Atlantic Ocean     GLB       [7.6, -10.0, 8.0, -50.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SAO    PolyRegion   Southern Atlantic Ocean       GLB      [-10.0, -56.0, 8.0, -56.0]      ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_ARS    PolyRegion   Arabian Sea                   GLB        [23.5, 7.0, 76.0, 53.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_BOB    PolyRegion   Bay of Bengal                 GLB        [19.5, 7.0, 93.0, 79.0]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_EIO    PolyRegion   Equatorial Indian Ocean       GLB       [7.0, -10.0, 93.0, 46.5]       ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SIO    PolyRegion   Southern Indian Ocean         GLB      [-10.0, -36.0, 110.0, 31.0]     ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null,"  AR6_SOO    PolyRegion   Southern Ocean                GLB     [-36.0, -75.0, 180.0, -180.0]    ar6.txt")]),s(`
`),n("span",{class:"line"},[n("span",null," ---------- ------------ ---------------------------- -------- ------------------------------- ------------")])])])],-1),n("p",null,[s("See the API "),n("a",{href:"/GeoRegions.jl/dev/api/tables#GeoRegions.tablePolyRegions"},"here")],-1)])),_:1}),l(i,{label:"tableTiltRegions()"},{default:e(()=>a[3]||(a[3]=[n("div",{class:"info custom-block"},[n("p",{class:"custom-block-title"},[s('"No predefined '),n("code",null,"TiltRegion"),s('s"')]),n("p",null,[s("There are no predefined "),n("code",null,"TiltRegion"),s("s in GeoRegions.jl, so calling "),n("code",null,"tableTiltRegions()"),s(" will only return the "),n("code",null,"GLB"),s(" GeoRegion.")])],-1),n("div",{class:"language-julia vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"},"julia"),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#D73A49","--shiki-dark":"#F97583"}},"using"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}}," GeoRegions")]),s(`
`),n("span",{class:"line"},[n("span",{style:{"--shiki-light":"#005CC5","--shiki-dark":"#79B8FF"}},"tableTiltRegions"),n("span",{style:{"--shiki-light":"#24292E","--shiki-dark":"#E1E4E8"}},"()")])])])],-1),n("div",{class:"language- vp-adaptive-theme"},[n("button",{title:"Copy Code",class:"copy"}),n("span",{class:"lang"}),n("pre",{class:"shiki shiki-themes github-light github-dark vp-code",tabindex:"0"},[n("code",null,[n("span",{class:"line"},[n("span",null,'┌ Warning: modulelog - The custom file "tiltlist.txt" does not exist in /home/runner, use `setupGeoRegions()` to copy templates and empty custom lists to /home/runner')]),s(`
`),n("span",{class:"line"},[n("span",null,"└ @ GeoRegions ~/work/GeoRegions.jl/GeoRegions.jl/src/georegions/tables.jl:226")]),s(`
`),n("span",{class:"line"},[n("span",null," ----- ------------ ------- -------- --------------------------- ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"  ID       Type      Name    Parent       Bounds [N,S,E,W]           File")]),s(`
`),n("span",{class:"line"},[n("span",null," ----- ------------ ------- -------- --------------------------- ------------")]),s(`
`),n("span",{class:"line"},[n("span",null,"  GLB   RectRegion   Globe    GLB     [90.0, -90.0, 360.0, 0.0]   global.txt")]),s(`
`),n("span",{class:"line"},[n("span",null," ----- ------------ ------- -------- --------------------------- ------------")])])])],-1),n("p",null,[s("See the API "),n("a",{href:"/GeoRegions.jl/dev/api/tables#GeoRegions.tableTiltRegions"},"here")],-1)])),_:1})]),_:1})])}const S=p(g,[["render",u]]);export{y as __pageData,S as default};
