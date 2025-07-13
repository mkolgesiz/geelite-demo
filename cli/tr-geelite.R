# This script executes the geeLite analysis and processes the results

library(geeLite)
library(dplyr)
library(DBI)
library(RSQLite)
library(reticulate)
library(rgee)

# Load config file 
source("cli/config.R")

# Build database
run_geelite(path = path)

# Load and aggregate data to monthly frequency using read_db
db <- read_db(path = "data/tr-geelite", freq = "month")

# Access the grid (spatial metadata) containing hexagonal grid cells for Turkey
grid_data <- db$grid

# Access NDVI mean data if available in the database
if("MODIS/061/MOD13A2/NDVI/mean" %in% names(db)) {
  ndvi_mean <- db$`MODIS/061/MOD13A2/NDVI/mean`
  
  turkey_forest_df <- merge(grid_data, ndvi_mean, by = "id")
  
  # Save the merged dataframe to CSV for use in visualization
  write.csv(turkey_forest_df, "data/turkey_forest_analysis.csv", row.names = FALSE)
  
  # Extract date range information for temporal analysis
  if(ncol(ndvi_mean) > 1) {
    date_cols <- colnames(ndvi_mean)[colnames(ndvi_mean) != "id"]
  }
}