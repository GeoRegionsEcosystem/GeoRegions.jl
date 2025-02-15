```@raw html
<script setup lang="ts">
import Gallery from "../components/Gallery.vue";

const using = [
  {
    href: "using/isin",
    src: "images/isin.png",
    caption: "Is it In a GeoRegion?",
    desc: "Check if a Point/GeoRegion is inside a GeoRegion"
  },
  {
    href: "using/ison",
    src: "images/ison.png",
    caption: "Is it On a GeoRegion",
    desc: "Check if GeoRegion Shapes are Equal"
  },
  {
    href: "using/isequal",
    src: "images/isequal.png",
    caption: "Equivalence in GeoRegions.jl",
    desc: "Retrieving the Shape of a GeoRegion"
  },
  {
    href: "using/derotate",
    src: "images/derotate.png",
    caption: "Derotation",
    desc: "Derotating shapes and coordinates around GeoRegions"
  }
];

const projects = [
  {
    href: "projects/setup",
    src: "images/setup.png",
    caption: "GeoRegions.jl and your Project",
    desc: "Setting up GeoRegions.jl for your project"
  },
  {
    href: "projects/addreadrm",
    src: "images/addreadrm.png",
    caption: "Custom GeoRegions",
    desc: "Adding, Reading, Removing custom GeoRegions for your project"
  },
  {
    href: "projects/backends",
    src: "images/files.png",
    caption: "Backends",
    desc: "What goes on behind the scenes?"
  }
];
</script>

# Tutorials

## Using the Properties of GeoRegions

<Gallery :images="using" />

## Using GeoRegions.jl for Projects

<Gallery :images="projects" />
```