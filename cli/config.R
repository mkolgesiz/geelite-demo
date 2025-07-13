# Simple geeLite Configuration for Turkey Deforestation Demo
library(geeLite)

# Define configuration parameters
path = "data/tr-geelite"
regions <- "TR"
source <- list(
  "MODIS/061/MOD13A2" = list(
    "NDVI" = c("mean", "sd")
  )
)
start <- "2020-01-01"
resol <- 3

# Set up configuration for Turkey forest analysis
set_config(
  path = path,
  regions = regions,
  source = source,
  start = start,
  resol = resol
)