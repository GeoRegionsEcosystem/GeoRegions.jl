---
layout: page
---

<script setup>
import { VPTeamPage, VPTeamPageTitle, VPTeamMembers, VPTeamPageSection } from 'vitepress/theme'

const georegions = [
  {
    avatar: 'https://github.com/GeoRegionsEcosystem.png',
    name: 'GeoRegions.jl',
    desc: 'Defining Geographic Regions of Interest for Geospatial Data in Geoscience and Climate.',
    links: [
      { icon: 'github', link: 'https://github.com/SciML/DiffEqFlux.jl' }
    ]
  }
];

const extends_geo = [
  {
    avatar: 'https://github.com/GeoRegionsEcosystem.png',
    name: 'RegionGrids.jl',
    desc: 'Extracting Gridded Data for a given GeoRegion',
    links: [
      { icon: 'github', link: 'https://github.com/GeoRegionsEcosystem/RegionGrids.jl' }
    ]
  },
  {
    avatar: 'https://github.com/GeoRegionsEcosystem.png',
    name: 'LandSea.jl',
    desc: 'Extensible Land-Sea Mask Datasets',
    links: [
      { icon: 'github', link: 'https://github.com/GeoRegionsEcosystem/LandSea.jl' }
    ]
  }
];

const ecosystempkgs = [
  {
    avatar: 'https://raw.githubusercontent.com/natgeo-wong/NASAPrecipitation.jl/main/src/logosmall.png',
    name: 'NASAPrecipitation.jl',
    desc: 'Downloading, Extracting and Analyzing NASA Satellite Precipitation Data',
    links: [
      { icon: 'github', link: 'https://github.com/GeoRegionsEcosystem/NASAPrecipitation.jl' }
    ]
  },
  {
    avatar: 'https://raw.githubusercontent.com/natgeo-wong/NASAPrecipitation.jl/main/src/logosmall.png',
    name: 'ERA5Reanalysis.jl',
    desc: 'Downloading, Extracting and Analyzing ERA5 Reanalysis Data',
    links: [
      { icon: 'github', link: 'https://github.com/GeoRegionsEcosystem/ERA5Reanalysis.jl' }
    ]
  },
  {
    avatar: 'https://raw.githubusercontent.com/natgeo-wong/NASAPrecipitation.jl/main/src/logosmall.png',
    name: 'NASABrightnessTemperature.jl',
    desc: 'Downloading, Extracting and Analyzing NASA Brightness Temperature Data',
    links: [
      { icon: 'github', link: 'https://github.com/GeoRegionsEcosystem/NASABrightnessTemperature.jl' }
    ]
  }
];
</script>

<VPTeamPage>
  <VPTeamPageTitle>
    <template #title>Ecosystem</template>
  </VPTeamPageTitle>

  <VPTeamPageSection>
    <template #title>GeoRegions.jl</template>
    <template #members>
      <VPTeamMembers size="small" :members="georegions" />
    </template>
  </VPTeamPageSection>

  <VPTeamPageSection>
    <template #title>Frameworks Extending GeoRegions.jl</template>
    <template #members>
      <VPTeamMembers size="small" :members="extends_geo" />
    </template>
  </VPTeamPageSection>

  <VPTeamPageSection>
    <template #title>The GeoRegions Ecosystem</template>
    <template #members>
      <VPTeamMembers size="small" :members="ecosystempkgs" />
    </template>
  </VPTeamPageSection>
</VPTeamPage>
