# GeoLite Demo Setup Guide

This guide provides step-by-step instructions to set up and run the GeoLite NDVI Analysis project using MODIS data.

## Prerequisites

- R (version 4.0 or higher)
- Miniconda or Anaconda
- Google Cloud Platform account with Earth Engine access
- Git
- Quarto (for rendering analysis reports)

## 1. Clone the Repository

```bash
git clone <repository-url>
cd geelite-demo
```

## 2. Google Cloud Platform Setup

### 2.1 Create a Google Cloud Project

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project

### 2.3 Configure Google Earth Engine

1. Go to [Google Earth Engine](https://console.cloud.google.com/earth-engine/)
2. Register your project to use Google Earth Engine
3. Enable Google Earth Engine API

## 3. Python Environment Setup

### 3.1 Install Miniconda (if not already installed)

```bash
# Download and install Miniconda
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
```

### 3.2 Create Conda Environment for rgee

The R script will automatically create the conda environment, but you can also create it manually:

```bash
conda create -n rgee python=3.9
conda activate rgee
pip install earthengine-api
```

### 3.3 Fix OpenSSL Compatibility (if needed)

If you encounter OpenSSL version conflicts:

```bash
conda install -n rgee -c conda-forge openssl=3.3.0 -y
```

### 3.4 Set your Python Interpreter

After installing miniconda, check 

```bash
Sys.getenv('EARTHENGINE_PYTHON')

```
then set project Python interpreter to Conda rgee environment;

Click Tools -> Project Options ->  Python -> Conda Environments

Detailed GitHub issue is below.

https://github.com/r-spatial/rgee/issues/99

## 5. R Environment Setup

### 5.1 Install Required R Packages

Run the following in R console or create an R script:

```r
# Install required packages
install.packages(c(
  "geeLite",
  "dplyr", 
  "sf",
  "leaflet",
  "DT",
  "tidyr",
  "htmlwidgets",
  "ggplot2",
  "reticulate",
  "rgee"
))
```

### 5.2 Configure R Project

If using RStudio, the `.Rproj` file should automatically configure:
- Python type: conda
- Python version: 3.9.x
- Python path: `~/.local/share/r-miniconda/envs/rgee/bin/python3.9`

## 6. Directory Structure

Your project should have the following structure:

```
geelite-demo/
├── cli/
│   ├── config.R                   # Configuration setup
│   ├── tr-geelite.R               # Main data collection and processing
│   └── visualize-geelite.qmd      # Quarto analysis report
├── config/                        # Configuration files (auto-created)
├── data/
│   ├── output/                    # Final analysis outputs
│   │   ├── turkey_forest_analysis.csv
│   │   └── visualize-geelite.html
│   └── tr-geelite/               # geeLite database (auto-created)
│       ├── data/
│       │   └── geelite.db
│       ├── config/
│       ├── log/
│       └── state/
├── geelite-demo.Rproj
├── SETUP.md                       # This file
└── README.md
```

The directories `data/`, `config/`, `log/`, and `state/` will be created automatically when you run the analysis.

## 7. Running the Data Collection

### 7.1 Run Configuration and Data Collection

```bash
# Configure the analysis parameters for Turkey NDVI analysis
Rscript cli/config.R

# Run the main data collection and processing
Rscript cli/tr-geelite.R
```

**Note:** The data collection may take 10-30 minutes depending on:
- Data volume (2020-2025 MODIS NDVI data)
- Network speed
- Earth Engine server load
- Number of hexagonal grid cells

### 7.2 Set Up Google Earth Engine Authentication

Set up your Google Earth Engine API authentication following these steps:

   - Authentication window appears autmatically
   - Choose Google Earth Engine API enabled Google Cloud project
   - Generate Token
   - Paste the output to console

## 8. Verification

### 8.1 Check Output Files

After successful execution, you should have:

```
data/
├── output/
│   ├── turkey_forest_analysis.csv     # Processed spatial NDVI data
│   └── visualize-geelite.html         # Complete analysis report
└── tr-geelite/
    ├── data/
    │   └── geelite.db                 # SQLite database with raw data
    ├── config/
    │   └── config.json
    ├── log/
    │   └── log.txt
    └── state/
        └── state.json
```

### 8.2 Verify geeLite Database Content

```r
library(geeLite)

# Load the geeLite database
db <- read_db(path = "data/tr-geelite", freq = "month")

# Check available datasets
names(db)

# Examine grid structure
head(db$grid)

# Check NDVI data
head(db$`MODIS/061/MOD13A2/NDVI/mean`)
```

## 8.3 Generate Analysis Report

Once data collection is verified, generate the interactive visualization report:

```bash
# Render the Quarto analysis report
quarto render cli/visualize-geelite.qmd --output-dir data/output
```

Alternatively, you can render from within R/RStudio:

```r
quarto::quarto_render("cli/visualize-geelite.qmd", output_dir = "data/output")
```

### 8.4 View Analysis Report

Open `data/output/visualize-geelite.html` in your web browser to view:
- Interactive maps with time slicing
- Time series analysis plots
- Summary statistics
- Interactive data tables

## 9. Troubleshooting

### Common Issues

1. **Conda environment not found**
   - Ensure Miniconda is installed
   - Check conda path in R project settings

2. **Authentication failed**
   - Ensure Earth Engine API is enabled
   - Ensure there will be no other OAuth configuration on Google Cloued project. 

3. **OpenSSL errors**
   - Install compatible OpenSSL version in conda environment

4. **Python module import errors**
   - Verify earthengine-api is installed in conda environment
   - Check Python path configuration

## 10. Performance Tips

1. **Reduce analysis scope** for testing:
   - Modify date range in configuration
   - Use smaller geographic area
   - Lower spatial resolution

2. **Monitor resources**:
   - Check available disk space
   - Monitor memory usage during analysis

3. **Earth Engine quotas**:
   - Be aware of Earth Engine usage limits
   - Consider breaking large analyses into smaller chunks

## Support

For additional support:
- Check geeLite package GitHub documentation
- Review Earth Engine documentation
