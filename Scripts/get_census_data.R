# Census Data Processing Script
#
# This script retrieves ACS (American Community Survey) data from the U.S. Census Bureau 
# for selected variables across different categories and years. 
# The data are processed and saved as CSV files.
#

# Load packages
library(tidycensus)
library(tidyverse)
library(dplyr)
library(stringr)
library(tigris)
library(sf)
library(purrr)

# Set census API key
census_api_key("d48d2c6fa999265383738be2b1f48aed4900866a", install=TRUE, overwrite=TRUE)

# Define years and states
years <- 2019:2022
state_abbreviations <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                         "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
                         "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
                         "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
                         "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC")

# Define variable codes and their short names in a list
# You can find variable codes by running the following commands and searching within the results:
# var_names <- load_variables(2022, "acs5", cache = TRUE)       # For detailed tables
# dp_var_names <- load_variables(2022, "acs5/profile", cache = TRUE) # For data profile tables
variable_list <- list(
  economic = list(
    vars = c("B19013_001", "DP03_0009P", "DP03_0128P", "DP03_0074P"),
    names = c("median_income", "unemployment_rate", "poverty_rate", "snap_benefits"),
    update = FALSE
  ),
  education = list(
    vars = c("DP02_0068P", "DP02_0067P"),
    names = c("bachelors_degree_or_higher", "high_school_or_higher"),
    update = FALSE
  ),
  health = list(
    vars = c("DP03_0099P"),
    names = c("without_health_insurance"),
    update = TRUE
  ),
  neighborhood = list(
    vars = c("B08006_002", "DP03_0025"),
    names = c("car_commute", "mean_travel_time"),
    update = FALSE
  )
)

# Function to get census data for a given year and list of variables, and rename columns
get_census_data <- function(years, variables, var_names) {
  data <- map_dfr(years, function(year) {
    get_acs(geography = "tract",
            variables = variables,
            state = state_abbreviations,
            year = year,
            output = "wide") %>%
      select(-ends_with("M"), -NAME) %>%  # Drop margin of error columns and NAME column
      mutate(Year = year)
  })
  names(data) <- names(data) %>% 
    purrr::map_chr(~ ifelse(str_remove(., "E") %in% variables, var_names[which(variables == str_remove(., "E"))], .))
  return(data)
}

# Iterate over the variable list to get and save data
for (topic in names(variable_list)) {
  if (variable_list[[topic]]$update) {
    variables <- variable_list[[topic]]$vars
    var_names <- variable_list[[topic]]$names
    
    data <- get_census_data(years, variables, var_names)
    write_csv(data, paste0("ProcessedData/", topic, "_acs_tract_", min(years), "-", max(years), ".csv"))
  }
}