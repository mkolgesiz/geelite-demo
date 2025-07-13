# Turkey NDVI Analysis with geeLite

A demonstration project analyzing vegetation patterns across Turkey (2020-2025) using MODIS NDVI data accessed through the geeLite R package and Google Earth Engine.

## Overview

This project showcases the [World Bank's geeLite methodology](https://blogs.worldbank.org/en/opendata/geelite--an-r-package-for-tracking-remote-sensing-datalocally-) for local processing of satellite data. It creates an interactive analysis report with time-sliced maps, trend visualizations, and statistical summaries of vegetation health across Turkey.

## Quick Start

1. **Setup**: Follow the complete setup instructions in **[SETUP.md](SETUP.md)**
2. **Run**: Execute the analysis workflow 
3. **View**: Open the generated interactive report

**Prerequisites:** R, Quarto, Google Earth Engine account, Miniconda

See **[SETUP.md](SETUP.md)** for detailed installation, authentication, and execution instructions.

## Output

- **Interactive Maps**: Time-sliced vegetation patterns with tabbed interface
- **Time Series Analysis**: NDVI trends and variability (2020-2025)
- **Summary Statistics**: Vegetation change assessment and key metrics
- **Data Export**: Processed spatial data in CSV format

## Technical Details

- **Data Source**: MODIS/061/MOD13A2 NDVI (16-day, 1km resolution)
- **Spatial Coverage**: Turkey with hexagonal grid aggregation
- **Temporal Range**: Monthly data from 2020-2025
- **Storage**: Local SQLite database via geeLite
- **Output**: Self-contained HTML report with embedded resources

## References

1. **World Bank Data Team.** (2024). *geeLite – an R package for tracking remote sensing data locally*. World Bank Blogs. https://blogs.worldbank.org/en/opendata/geelite--an-r-package-for-tracking-remote-sensing-datalocally-

2. **Braaten, J., Bullock, E., & Gorelick, N.** (2024). *geeLite: Client for Accessing and Processing Google Earth Engine Data*. GitHub Repository. https://github.com/gee-community/geeLite