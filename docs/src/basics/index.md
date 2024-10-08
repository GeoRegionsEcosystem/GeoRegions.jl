```@raw html
<script setup lang="ts">
import Gallery from "../components/Gallery.vue";

const beginner = [
  {
    href: "read",
    src: "images/read.png",
    caption: "Read / Load",
    desc: "How to read/load a GeoRegion into the workspace."
  },
  {
    href: "create",
    src: "images/create.png",
    caption: "Create",
    desc: "How to create a user-defined GeoRegion."
  },
  {
    href: "shape",
    src: "images/shape.png",
    caption: "Shape Properties",
    desc: "Retrieving the Shape of a GeoRegion"
  },
  {
    href: "tables",
    src: "images/list.png",
    caption: "Tables",
    desc: "Listing existing GeoRegions in Table Format"
  }
];

const predefined = [
  {
    href: "predefined/sets",
    src: "images/sets.png",
    caption: "Available Datasets",
    desc: "Different Predefined Datasets in GeoRegions.jl"
  },
  {
    href: "predefined/listall",
    src: "images/listall.png",
    caption: "All Predefined GeoRegions",
    desc: "Listing out all predefined GeoRegions in GeoRegions.jl"
  }
];
</script>

# The Basics

<Gallery :images="beginner" />

## Predefined GeoRegions

<Gallery :images="predefined" />
```