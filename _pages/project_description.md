---
title: "Project Description"
layout: single
permalink: /project-description/
author_profile: false
---

Welcome to our project! As fellow Rainbow Dragons in Besançon, we set out to
explore spatial narratives by combining critical geography with digital
tools. We learned that a map is not just a coordinate plot — it is a
communication medium that bridges technical workflows with conceptual
choices.

## Our toolkit

- **Kepler.gl** — our spatial visualization dashboard, used to render geotagged fieldwork photos and migration/trajectory data as an interactive map.
- **QGIS** — desktop GIS work, coordinate reference systems, and point styling/labeling.
- **Posit.cloud / RStudio** — a shared R environment for compiling and cleaning spatial datasets from fieldwork.
- **OpenStreetMap** — hands-on edits to contribute points of interest to the open map database.
- **Overpass Turbo** — custom queries to pull specific feature data from OpenStreetMap.
- **GitHub & GitHub Pages** — version control and hosting for this site.

## Our Workflow

1. **Camera Configuration**
   Cameras were configured to capture geolocation data for each photograph.

2. **Data Collection**
   Photographs were captured with geotagging enabled, in the streets of Besançon, in accordance with agreed technical and ethical protocols. See Selection Workflow for more information.

3. **Data Storage**
   All images were uploaded to a shared Google Drive folder for the workshop.

4. **Image Processing**
   Photographs were resized into thumbnails using Copilot within Visual Studio.

5. **Metadata Extraction**
   A script executed in Posit Cloud extracted key metadata from each image, including file name, device manufacturer, device model, timestamp, and geographic coordinates (latitude/longitude). This output was compiled into a structured CSV file.

6. **Manual Annotation**
   Each image was individually reviewed and annotated across the following categories: door status (open/closed), architectural feature (round-top or not), presence of graffiti, presence of stickers or signage, and door color.

7. **Data Integration**
   The annotation dataset and the metadata dataset were merged using VLOOKUP functions, producing a single consolidated spreadsheet containing complete image-level data which were then mapped.
   



