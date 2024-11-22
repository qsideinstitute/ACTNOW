# ProcessedData Folder

This folder holds all processed data files that comply with the project’s metadata standard, as described in the [Documentation Guide](https://docs.google.com/document/d/1uMYR-6qjvn25AVKHAnkWwiLuI0IAvWdsienCy5dFiDc/edit?usp=sharing). Data here has been cleaned, structured, and prepared for visualization in a Tableau dashboard, and will be stored locally until the transition to a cloud environment is complete.

Each processed dataset includes:
- A **CSV file** containing the cleaned data, formatted according to the guide.
- A corresponding **JSON metadata file** that documents the dataset’s contents, source, structure, and other essential details.

## Metadata Template

The `metadata_template.json` file provides a standardized format for documenting each dataset. To create metadata for a new dataset:

- Copy `metadata_template.json` to a new file and rename it according to the naming conventions in the [Documentation Guide](https://docs.google.com/document/d/1uMYR-6qjvn25AVKHAnkWwiLuI0IAvWdsienCy5dFiDc/edit?usp=sharing)—i.e., `[data-topic]_[data-source]_[geographic-level]_[time-period].json`.
- Complete all relevant sections in the copied file to fully describe the dataset.

Please avoid editing the original template directly; instead, create a new metadata file for each dataset following the established naming conventions.

## Shapefile Folder

The **Shapefiles** subfolder contains census tract shapefiles.
