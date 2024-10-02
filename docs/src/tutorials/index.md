```@raw html
<script setup lang="ts">
import Gallery from "../components/Gallery.vue";

const using = [
  {
    href: "/tutorials/using/isin",
    src: "images/isin.png",
    caption: "Is it In a GeoRegion?",
    desc: "Check if a Point/GeoRegion is inside a GeoRegion"
  },
  {
    href: "/tutorials/using/ison",
    src: "images/ison.png",
    caption: "Is it On a GeoRegion",
    desc: "Check if GeoRegion Shapes are Equal"
  },
  {
    href: "/tutorials/isequal",
    src: "images/isequal.png",
    caption: "Equivalence in GeoRegions.jl",
    desc: "Retrieving the Shape of a GeoRegion"
  }
];

const projects = [
  {
    href: "/tutorials/projects/setup",
    src: "images/setup.png",
    caption: "Available Datasets",
    desc: "Different Predefined Datasets in GeoRegions.jl"
  },
  {
    href: "/tutorials/projects/addreadrm",
    src: "images/addreadrm.png",
    caption: "All Predefined GeoRegions",
    desc: "Listing out all predefined GeoRegions in GeoRegions.jl"
  },
  {
    href: "/tutorials/projects/files",
    src: "images/files.png",
    caption: "Tables",
    desc: "Listing existing GeoRegions in Table Format"
  }
];
</script>

# Tutorials

## Using GeoRegions.jl

<Gallery :images="using" />

## Predefined GeoRegions

<Gallery :images="projects" />
```