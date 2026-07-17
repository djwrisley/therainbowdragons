---
title: "Project Description"
layout: single
permalink: /project-description/
author_profile: false
---

Welcome to our project! As fellow Rainbow Dragons in Besançon, we set out to explore spatial narratives by combining critical geography with digital tools. We learned that a map is not just a coordinate plot — it is a communication medium that bridges technical workflows with conceptual
choices.

A previous collection of Doors of Besançon, France exists in [Wikimedia Commons](https://commons.wikimedia.org/wiki/Category:Doors_in_Besan%C3%A7on). As of July 2026, it contained 19 doors. We documented more than 800! 

## Our toolkit

- **Kepler.gl** — our spatial visualization dashboard, used to render geotagged fieldwork photos and migration/trajectory data as an interactive map.
- **QGIS** — desktop GIS work, coordinate reference systems, and point styling/labeling.
- **Posit.cloud / RStudio** — a shared R environment for compiling and cleaning spatial datasets from fieldwork.
- **OpenStreetMap** — hands-on edits to contribute points of interest to the open map database.
- **Overpass Turbo** — custom queries to pull specific feature data from OpenStreetMap.
- **GitHub & GitHub Pages** — version control and hosting for this site.
- **various LLMs** - for brainstorming, forming queries and distant coding. 

## Our Workflow

1. **Camera Configuration**
   Cameras were configured to capture geolocation data for each photograph.

2. **Data Collection**
   Photographs were captured with geotagging enabled, in the streets of Besançon, in accordance with agreed technical and ethical protocols. See [Selection Workflow](#selection-workflow) for more information.

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

## Selection Workflow

During data collection we ensured to:

* **Consider the context**

* **Avoid photographing people** (standing next to doors, sitting behind a glass door, reflecting in the glass)
   * Knowing that this dataset would eventually be published to a larger audience, we avoided including images of people who did not consent to having their likeness published.
   * The photographers themselves were also instructed to avoid photographing others.
   
* **Avoid PII (personally identifiable information)** 
    * We decided not to take pictures of doors with personal information, phone numbers, or notice orders, to avoid amplifying personal information of residents on the web. We included photos of doors on commercial buildings, considering that information is already available to the public.

* **Avoid military and police locations.**
   * Many police stations and military areas prohibit photography of the building and its employees/visitors for security purposes. Our team decided to avoid taking photos of those buildings, and also used their discretion to avoid photography when police or military personnel were present, to prevent unnecessary interaction with armed forces.
   * The aim of this exercise was exploratory.

* **Remember that the photo has to be easily visible in thumbnail form.**

* **Consider lighting and shadow** when taking a picture.

* **Be careful for your own safety** — vehicles are present.
   * In certain contexts, the full door couldn't be photographed from the sidewalk. Ahead of collection, we agreed to never put ourselves in a dangerous situation, and to ensure a clear line of sight of oncoming traffic (cars, bikes, scooters, the tram, etc.) when taking a snapshot.






