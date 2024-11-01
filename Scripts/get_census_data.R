# Note: this file is unedited and does not comply with the metadata standard. 
# I am uploading this to github so that we have easy access to the previous work. 
# This file will need to be reworked once we establish a data architecture and
# metadata standard. -ZCS

library(tidycensus)
library(tidyverse)
library(dplyr)
library(stringr)
library(tigris)
library(sf)

census_api_key("4f5ef336926755cb3eaa12e037f887c4cdb1c984", install=TRUE)
readRenviron("~/.Renviron")

state_abbreviations <- c("AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
                         "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
                         "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
                         "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
                         "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY", "DC")

allvars <- c("B01003_001", "B01002_001", "B19013_001", "DP03_0009PE", "DP03_0128PE", 
               "DP03_0074PE", "DP02_0068PE", "DP02_0068E", "DP02_0067PE", "DP03_0099PE", 
               "DP02_0001E", "B08006_002E", "DP03_0025E")

ky <- get_acs(geography = "county",
              variables = "B19013_001",
              state = "KY",
              year = 2022)

#list of all variables
v22 <- load_variables(2022, "acs5", cache = TRUE)

# append the profile to the variables (smaller list of variables)
profile <- load_variables(2022, "acs5/profile", cache = TRUE)


# Total population: B01003_001

# Median age: B01002_001

# Median income: B19013_001

# Unemployment rate of the population 16 years and older: DP03_0009PE

# The poverty rate (amount of people whose income in the past
# twelve months was below the poverty level): DP03_0128PE

# Percent of households that received SNAP or food stamp benefits in 
# the last 12 months: DP03_0074PE

# Percent of people 25 and over with a bachelors degree or higher: DP02_0068PE

# Estimate number of people 25 and over with a bachelors degree or higher: DP02_0068E

# Percentage of 25 year olds that are a high school graduate or higher: DP02_0067PE

# Percentage of the civilian non-institutionalized population without health insurance: DP03_0099PE

# Total number of households: DP02_0001E

# Number of people who traveled to work by a car, truck, or van: B08006_002E

# Mean travel time for residents to get to work: DP03_0025E

data2022 <- get_acs(geography = "tract",
                        variables = allvars,
                        state = state_abbreviations,
                        year = 2022,
                        output = "wide")

data2021 <- get_acs(geography = "tract",
                    variables = allvars,
                    state = state_abbreviations,
                    year = 2021,
                    output = "wide")

data2020 <- get_acs(geography = "tract",
                    variables = allvars,
                    state = state_abbreviations,
                    year = 2020,
                    output = "wide")

data2019 <- get_acs(geography = "tract",
                    variables = allvars,
                    state = state_abbreviations,
                    year = 2019,
                    output = "wide")

data2018 <- get_acs(geography = "tract",
                    variables = allvars,
                    state = state_abbreviations,
                    year = 2018,
                    output = "wide")

data2022 <- data2022 %>% 
  mutate(Year = 2022)

data2021 <- data2021 %>% 
  mutate(Year = 2021)

data2020 <- data2020 %>% 
  mutate(Year = 2020)

data2019 <- data2019 %>% 
  mutate(Year = 2019)

data2018 <- data2018 %>% 
  mutate (Year = 2018)

dfcombined <- rbind(data2018, data2019, data2020, data2021, data2022)

# convert data frame into a character matrix
dfcombined_matrix <- as.matrix(dfcombined)

# Substitute semi colons for commas
dfcombined_matrix <- gsub(";", ",", dfcombined_matrix)

# convert matrix back to data frame 
dfcombined <- as.data.frame(dfcombined_matrix, stringsAsFactors = FALSE)

# separate NAME column into three columns
dfcombined_separated <- dfcombined %>% 
  separate(NAME, into = c("Tract", "County", "State"), sep = ", ")

#pull all tract numbers and geography
tractShapesNames <- do.call(rbind, lapply(state_abbreviations, function(state) {
  tigris::tracts(state = state, year = 2022, cb = TRUE)
}))

tractShapesNames <- tractShapesNames %>%
  rename(state_code = STATEFP, TRACT = TRACTCE)

tractShapesNames <- tractShapesNames %>% 
  shift_geometry(position = "outside")

#plot(tractShapesNames$geometry)

#may choose to want certain columns
##tractShapes <- tractShapesNames %>% select(state, PUMA, geometry)

head(dfcombined_separated)

arrange(dfcombined, desc(GEOID))

write.csv(dfcombined, file = "~/Documents/QSIDE/API Documentation/alldatasets.csv", row.names = TRUE)

write.csv(dfcombined_separated, file = "~/Documents/QSIDE/API Documentation/ACTNOWdata.csv", 
          row.names = TRUE)

#write the file for the tracts
st_write(tractShapesNames, "~/Documents/QSIDE/API Documentation/TRACT_Shapes_ShiftedOut.shp")
