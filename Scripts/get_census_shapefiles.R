# --------------------
# Import required libraries
# --------------------
library(tidyverse)
library(tidycensus)
library(tigris)
library(pbmcapply)
library(sf)

# --------------------
# Function to retrieve shape files
# --------------------
get_tract_shapes <- function(year) {
  # Retrieve tract shapes
  tractShapes <- tigris::tracts(year = year, cb = TRUE)
  
  # Retain GEOID and geometry
  tractShapes <- tractShapes %>%
    select(GEOID, geometry)
  
  # Shift Alaska and Hawaii
  tractShapesShifted <- tractShapes %>% shift_geometry(position = "outside")
  
  # Store the finalized data
  st_write(tractShapes, paste0("ProcessedData/Shapefiles/tract_shapes_", year, ".shp")) # shapefile for Tableau
  st_write(tractShapesShifted, paste0("ProcessedData/Shapefiles/tract_shapes_shifted_", year, ".shp")) # shapefile for Tableau
}

# --------------------
# Save files for 2019 and 2020
# --------------------
get_tract_shapes(2019)
get_tract_shapes(2020)
