# --------------------
# Import required libraries
# --------------------
library(tidycensus)
library(tigris)
library(dplyr)
library(sf)

# Load and save census tract data for 2020
tract_data_2020 <- tracts(year = 2020, cb = TRUE) %>%
  st_drop_geometry() %>%
  select(GEOID, NAMELSAD, NAMELSADCO, STUSPS) %>%
  rename(tract_name = NAMELSAD, county_name = NAMELSADCO, state_name = STUSPS)

# Save 2020 data to CSV
write.csv(tract_data_2020, "ProcessedData/Shapefiles/tract_names_2020.csv", row.names = FALSE)

# Load and save census tract data for 2019
tract_data_2019 <- tracts(year = 2019, cb = TRUE) %>%
  st_drop_geometry() %>%
  select(GEOID, NAME, COUNTYFP, STATEFP) %>%
  rename(tract_name = NAME, county_fips = COUNTYFP, state_fips = STATEFP)

# Match state and county FIPS to names
fips_lookup <- fips_codes %>%
  select(state_code, state, county_code, county) %>%
  mutate(state_code = as.character(state_code), county_code = as.character(county_code))

tract_data_2019 <- tract_data_2019 %>%
  left_join(fips_lookup, by = c("state_fips" = "state_code", "county_fips" = "county_code")) %>%
  rename(state_name = state, county_name = county) %>%
  mutate(tract_name = paste("Census Tract", tract_name)) %>%
  select(GEOID, tract_name, county_name, state_name)

# Save 2019 data to CSV
write.csv(tract_data_2019, "ProcessedData/Shapefiles/tract_names_2019.csv", row.names = FALSE)
