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
  "<b>Color:</b> ", df$color, "<br>",
  "<b>Contributor:</b> ", df$contributor, "<br>",
  "<b>DateTime:</b> ", df$datetime, "<br><br>",
  df$refer, "<br><br>",
  df$popup_image
)

# Define color mapping for door colors to hex values
color_mapping <- list(
  "Blue" = list(dark = "#0701b2", light = "#56B4E9"),
  "Red" = list(dark = "#CC3311", light = "#EE6677"),
  "Green" = list(dark = "#4e8b22", light = "#66BB6A"),
  "Gray" = list(dark = "#797883", light = "#EEEEEE"),
  "Black" = list(dark = "#000000", light = "#666666"),
  "Brown" = list(dark = "#633310", light = "#D2691E"),
  "Other" = list(dark = "#7509a3", light = "#CE93D8")  # Purple for Other
)

# Mapbox token and configuration
mapbox_token <- "pk.eyJ1IjoiZmVyYWxhcmNoaXZpc3QiLCJhIjoiY21yZXNsMHRjMHF4NzJ3cXoxaDRrZWphNyJ9.U483oVsn7kwMVVMo5oIyLQ"

# Calculate the extent (bounding box) of the data
lat_min <- min(df$latitude, na.rm = TRUE)
lat_max <- max(df$latitude, na.rm = TRUE)
lng_min <- min(df$longitude, na.rm = TRUE)
lng_max <- max(df$longitude, na.rm = TRUE)

# Create the map with bounds fitted to data extent
map <- leaflet(df) %>%
  addTiles(
    urlTemplate = paste0(
      "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=",
      mapbox_token
    ),
    attribution = "© Mapbox"
  ) %>%
  fitBounds(lng_min, lat_min, lng_max, lat_max)

# Add layers for each unique color
unique_colors <- names(color_mapping)
overlay_groups <- c()

for (color_name in unique_colors) {
  df_color <- df[df$color == color_name, ]
  
  if (nrow(df_color) > 0) {
    color_hex <- color_mapping[[color_name]]
    
    map <- map %>%
      addCircleMarkers(
        data = df_color,
        ~longitude, 
        ~latitude,
        radius = 5,
        color = color_hex$dark,
        fillColor = color_hex$light,
        fillOpacity = 0.7,
        weight = 3,
        popup = ~popup_content,
        label = ~filename,
        group = color_name
      )
    
    overlay_groups <- c(overlay_groups, color_name)
  }
}

# Add custom legend with colored circles
legend_colors <- sapply(unique_colors, function(x) color_mapping[[x]]$dark)
legend_labels <- unique_colors

map <- map %>%
  addLegend(
    position = "topright",
    colors = legend_colors,
    labels = legend_labels,
    title = "Door Color",
    opacity = 0.7
  ) %>%
  
  # Add layer control to toggle layers
  addLayersControl(
    overlayGroups = overlay_groups,
    options = layersControlOptions(collapsed = FALSE)
  )

# Save the map as an HTML file
saveWidget(map, file = "doors_Besancon_M3.html")

print("Map created successfully: doors_Besancon_M3.html")

# Print summary statistics
for (color_name in unique_colors) {
  count <- nrow(df[df$color == color_name, ])
  print(paste(color_name, "points:", count))
}
