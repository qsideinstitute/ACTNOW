# Community Safety & Thriving Data Project

This repository contains code and data for a project focused on community safety and well-being. The data and code in this repository support the development of a public-facing Tableau dashboard in collaboration with **ACT NOW** and its local community sites.

## Directory Structure

- **Scripts**: Contains R scripts used to acquire and process data, ensuring consistency with project standards. These scripts follow a standardized workflow outlined in the [Documentation Guide](https://docs.google.com/document/d/1uMYR-6qjvn25AVKHAnkWwiLuI0IAvWdsienCy5dFiDc/edit?usp=sharing).
- **InputData**: A temporary holding area for raw data. Data here is stored as acquired and is not yet processed.
- **ProcessedData**: Contains processed data files that adhere to the metadata standard. This folder is a local repository until the data transitions to cloud storage.
- **Methodology**: Contains any methodology and data information files from the original data sources.

## Documentation Guide

Our [Documentation Guide](https://docs.google.com/document/d/1uMYR-6qjvn25AVKHAnkWwiLuI0IAvWdsienCy5dFiDc/edit?usp=sharing) provides detailed instructions on how to structure, document, and manage data in this repository. The guide covers:

1. **Setting Up Your Data Files**: Instructions for structuring CSV data files and JSON metadata files, including naming conventions and file organization.
2. **Structure of the Primary Data File (CSV)**: Guidelines on structuring the CSV data files, including required columns such as GEOID, year, and data variables.
3. **Structure of the Metadata File (JSON)**: Specifications for creating the metadata JSON files, which include descriptions of the dataset, data sources, geographic details, and variables.
4. **Example Workflow**: Step-by-step instructions for collecting, processing, documenting, and validating data.

## Example Script and Template

The `Scripts` folder includes an example script, `get_census_data.R`, which demonstrates the data acquisition and processing workflow according to the documentation guide. This script downloads census data, prepares it for analysis, and structures it to meet the format and metadata standards. 

- Processed data from `get_census_data.R`, along with its associated metadata, is available in the `ProcessedData` folder.
- A `metadata_template.json` file is also available in the `ProcessedData` folder. Users should copy this template and fill in the relevant sections for each dataset to ensure metadata consistency.
