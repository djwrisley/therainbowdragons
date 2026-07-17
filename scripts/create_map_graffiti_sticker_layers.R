#!/usr/bin/env Rscript

# Install required packages if needed
if (!require("htmlwidgets")) install.packages("htmlwidgets")
if (!require("leaflet")) install.packages("leaflet")
if (!require("readr")) install.packages("readr")

# Load required libraries
library(htmlwidgets)
library(leaflet)
library(readr)

# Read the CSV file
df <- read_csv("/Users/djw12/Downloads/TheDoors/doors_final.csv")

# Create popup content with refer, contributor, datetime, popup_image
df$popup_content <- paste0(
  "<b>Graffiti:</b> ", df$graffiti, "<br>",
  "<b>Sticker-Signage:</b> ", df$`sticker-signage`, "<br>",
  "<b>Contributor:</b> ", df$contributor, "<br>",
  "<b>DateTime:</b> ", df$datetime, "<br><br>",
  df$refer, "<br><br>",
  df$popup_image
)

# Separate data by graffiti column
df_graffiti_yes <- df[df$graffiti == "Yes", ]
df_graffiti_no <- df[df$graffiti == "No", ]

# Separate data by sticker-signage column
df_sticker_yes <- df[df$`sticker-signage` == "Yes", ]
df_sticker_no <- df[df$`sticker-signage` == "No", ]

# Mapbox token and configuration
mapbox_token <- "pk.eyJ1IjoiZmVyYWxhcmNoaXZpc3QiLCJhIjoiY21yZXNsMHRjMHF4NzJ3cXoxaDRrZWphNyJ9.U483oVsn7kwMVVMo5oIyLQ"

# Calculate the extent (bounding box) of the data
lat_min <- min(df$latitude, na.rm = TRUE)
lat_max <- max(df$latitude, na.rm = TRUE)
lng_min <- min(df$longitude, na.rm = TRUE)
lng_max <- max(df$longitude, na.rm = TRUE)

# Accessible colors - shades of green for graffiti, shades of purple for sticker-signage
color_graffiti_yes <- "#2E7D32"      # Dark green
fillcolor_graffiti_yes <- "#81C784"  # Light green
color_graffiti_no <- "#558B2F"       # Medium green
fillcolor_graffiti_no <- "#C5E1A5"   # Pale green

color_sticker_yes <- "#7B1FA2"       # Dark purple
fillcolor_sticker_yes <- "#CE93D8"   # Light purple
color_sticker_no <- "#512DA8"        # Medium purple
fillcolor_sticker_no <- "#E1BEE7"    # Pale purple

# Create the map with bounds fitted to data extent
map <- leaflet(df) %>%
  addTiles(
    urlTemplate = paste0(
      "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=",
      mapbox_token
    ),
    attribution = "© Mapbox"
  ) %>%
  fitBounds(lng_min, lat_min, lng_max, lat_max) %>%
  
  # Layer 1: Graffiti = Yes (Dark Green)
  addCircleMarkers(
    data = df_graffiti_yes,
    ~longitude, 
    ~latitude,
    radius = 5,
    color = color_graffiti_yes,
    fillColor = fillcolor_graffiti_yes,
    fillOpacity = 0.7,
    weight = 3,
    popup = ~popup_content,
    label = ~filename,
    group = "Graffiti: Yes"
  ) %>%
  
  # Layer 2: Graffiti = No (Medium Green)
  addCircleMarkers(
    data = df_graffiti_no,
    ~longitude, 
    ~latitude,
    radius = 5,
    color = color_graffiti_no,
    fillColor = fillcolor_graffiti_no,
    fillOpacity = 0.7,
    weight = 3,
    popup = ~popup_content,
    label = ~filename,
    group = "Graffiti: No"
  ) %>%
  
  # Layer 3: Sticker-Signage = Yes (Dark Purple)
  addCircleMarkers(
    data = df_sticker_yes,
    ~longitude, 
    ~latitude,
    radius = 5,
    color = color_sticker_yes,
    fillColor = fillcolor_sticker_yes,
    fillOpacity = 0.7,
    weight = 3,
    popup = ~popup_content,
    label = ~filename,
    group = "Sticker-Signage: Yes"
  ) %>%
  
  # Layer 4: Sticker-Signage = No (Medium Purple)
  addCircleMarkers(
    data = df_sticker_no,
    ~longitude, 
    ~latitude,
    radius = 5,
    color = color_sticker_no,
    fillColor = fillcolor_sticker_no,
    fillOpacity = 0.7,
    weight = 3,
    popup = ~popup_content,
    label = ~filename,
    group = "Sticker-Signage: No"
  ) %>%
  
  # Add custom legend with colored circles
  addLegend(
    position = "topright",
    colors = c(color_graffiti_yes, color_graffiti_no, color_sticker_yes, color_sticker_no),
    labels = c("Graffiti: Yes", "Graffiti: No", "Sticker-Signage: Yes", "Sticker-Signage: No"),
    title = "Door Features",
    opacity = 0.7
  ) %>%
  
  # Add layer control to toggle layers
  addLayersControl(
    overlayGroups = c("Graffiti: Yes", "Graffiti: No", "Sticker-Signage: Yes", "Sticker-Signage: No"),
    options = layersControlOptions(collapsed = FALSE)
  )

# Save the map as an HTML file
saveWidget(map, file = "doors_Besancon_M2.html")

print("Map created successfully: doors_Besancon_M2.html")
print(paste("Graffiti Yes points:", nrow(df_graffiti_yes)))
print(paste("Graffiti No points:", nrow(df_graffiti_no)))
print(paste("Sticker-Signage Yes points:", nrow(df_sticker_yes)))
print(paste("Sticker-Signage No points:", nrow(df_sticker_no)))
