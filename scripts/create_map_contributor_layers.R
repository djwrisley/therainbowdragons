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
  "<b>Contributor:</b> ", df$contributor, "<br>",
  "<b>DateTime:</b> ", df$datetime, "<br><br>",
  df$refer, "<br><br>",
  df$popup_image
)

# Define extended rainbow color ramp for contributors (8 colors)
color_mapping <- list(
  "A" = list(dark = "#E41A1C", light = "#FB9A99"),  # Red
  "B" = list(dark = "#FF7F00", light = "#FFD580"),  # Orange
  "C" = list(dark = "#FFD700", light = "#FFEB99"),  # Yellow/Gold
  "E" = list(dark = "#4DAF4A", light = "#B3DE69"),  # Green
  "F" = list(dark = "#1F78B4", light = "#80C1E8"),  # Cyan/Light Blue
  "H" = list(dark = "#377EB8", light = "#A6CEE3"),  # Blue
  "I" = list(dark = "#984EA3", light = "#CABEE9"),  # Purple
  "J" = list(dark = "#E51B8C", light = "#FB89D2")   # Magenta/Pink
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

# Add layers for each unique contributor
unique_contributors <- names(color_mapping)
overlay_groups <- c()

for (contributor_name in unique_contributors) {
  df_contributor <- df[df$contributor == contributor_name, ]
  
  if (nrow(df_contributor) > 0) {
    color_hex <- color_mapping[[contributor_name]]
    
    map <- map %>%
      addCircleMarkers(
        data = df_contributor,
        ~longitude, 
        ~latitude,
        radius = 5,
        color = color_hex$dark,
        fillColor = color_hex$light,
        fillOpacity = 0.7,
        weight = 3,
        popup = ~popup_content,
        label = ~filename,
        group = contributor_name
      )
    
    overlay_groups <- c(overlay_groups, contributor_name)
  }
}

# Add custom legend with colored circles
legend_colors <- sapply(unique_contributors, function(x) color_mapping[[x]]$dark)
legend_labels <- unique_contributors

map <- map %>%
  addLegend(
    position = "topright",
    colors = legend_colors,
    labels = legend_labels,
    title = "Contributor",
    opacity = 0.7
  ) %>%
  
  # Add layer control to toggle layers
  addLayersControl(
    overlayGroups = overlay_groups,
    options = layersControlOptions(collapsed = FALSE)
  )

# Save the map as an HTML file
saveWidget(map, file = "doors_besancon_M4.html")

print("Map created successfully: doors_besancon_M4.html")

# Print summary statistics
for (contributor_name in unique_contributors) {
  count <- nrow(df[df$contributor == contributor_name, ])
  print(paste("Contributor", contributor_name, "points:", count))
}
