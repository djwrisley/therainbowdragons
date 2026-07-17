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
  "<b>Round-Top:</b> ", df$`round-top`, "<br>",
  "<b>Contributor:</b> ", df$contributor, "<br>",
  "<b>DateTime:</b> ", df$datetime, "<br><br>",
  df$refer, "<br><br>",
  df$popup_image
)

# Separate data by round-top value
df_roundtop_yes <- df[df$`round-top` == "Yes", ]
df_roundtop_no <- df[df$`round-top` == "No", ]

# Mapbox token and configuration
mapbox_token <- "pk.eyJ1IjoiZmVyYWxhcmNoaXZpc3QiLCJhIjoiY21yZXNsMHRjMHF4NzJ3cXoxaDRrZWphNyJ9.U483oVsn7kwMVVMo5oIyLQ"

# Calculate the extent (bounding box) of the data
lat_min <- min(df$latitude, na.rm = TRUE)
lat_max <- max(df$latitude, na.rm = TRUE)
lng_min <- min(df$longitude, na.rm = TRUE)
lng_max <- max(df$longitude, na.rm = TRUE)

# Accessible colors: Blue for Yes, Orange for No (colorblind-friendly contrast)
color_yes <- "#0173B2"      # Blue
color_no <- "#DE8F05"       # Orange
fillcolor_yes <- "#56B4E9"  # Light blue
fillcolor_no <- "#F8B195"   # Light orange

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
  
  # Layer 1: Round-top = Yes (Blue)
  addCircleMarkers(
    data = df_roundtop_yes,
    ~longitude, 
    ~latitude,
    radius = 5,
    color = color_yes,
    fillColor = fillcolor_yes,
    fillOpacity = 0.7,
    weight = 3,
    popup = ~popup_content,
    label = ~filename,
    group = "Round-Top: Yes"
  ) %>%
  
  # Layer 2: Round-top = No (Orange)
  addCircleMarkers(
    data = df_roundtop_no,
    ~longitude, 
    ~latitude,
    radius = 5,
    color = color_no,
    fillColor = fillcolor_no,
    fillOpacity = 0.7,
    weight = 3,
    popup = ~popup_content,
    label = ~filename,
    group = "Round-Top: No"
  ) %>%
  
  # Add custom legend with colored circles
  addLegend(
    position = "topright",
    colors = c(color_yes, color_no),
    labels = c("Round-Top: Yes", "Round-Top: No"),
    title = "Door Features",
    opacity = 0.7
  ) %>%
  
  # Add layer control to toggle layers
  addLayersControl(
    overlayGroups = c("Round-Top: Yes", "Round-Top: No"),
    options = layersControlOptions(collapsed = FALSE)
  )

# Save the map as an HTML file
saveWidget(map, file = "doors_Besancon_M1.html")

print("Map created successfully: doors_Besancon_M1.html")
print(paste("Round-Top Yes points:", nrow(df_roundtop_yes)))
print(paste("Round-Top No points:", nrow(df_roundtop_no)))
