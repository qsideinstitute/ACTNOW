library(httr)
library(jsonlite)
library(dplyr)
library(glue)
library(tidyverse)
library(haven)
library(fipio)
library(dplyr)
library(readr)
library(ggplot2)

path <- ""

county_aqi <- list.files(path, full.names = TRUE) %>% 
  lapply(read_csv) %>% 
  bind_rows 

# Relevant Columns 
# Days that are not Good or Moderate 
county_aqi$rate_notgood_aqi <- 
  (county_aqi$`Days with AQI`-county_aqi$`Good Days`-county_aqi$`Moderate Days`)/county_aqi$`Days with AQI`

county_aqi <- county_aqi[,c("State", "County", "Year", "Median AQI", "rate_notgood_aqi")] 


#Concat file apply fipio 
county_aqi$GEOID <- as_fips(county_aqi$State, 
                            county_aqi$County)

county_aqi <- county_aqi[,c("GEOID", "Year", "Median AQI", "rate_notgood_aqi")] 

write.csv(county_aqi,
          "environment_aqs_county_2018-2022.csv", row.names = FALSE)

