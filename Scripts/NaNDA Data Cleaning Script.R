library(httr)
library(jsonlite)
library(dplyr)
library(glue)
library(tidyverse)
library(haven)

# This R script file is used to clean data obtained from 
# NaNDA (National Neighborhood Data Archiv - https://nanda.isr.umich.edu/)



################################################################################
########################### Healthcare Facilities ##############################
################################################################################

nanda_healthcare_Tract20_1990_2021_01P <- read_dta("NanDA - Health Care Services/nanda_healthcare_Tract20_1990-2021_01P.dta")

# Filter for relevant years
healthcare <- filter(nanda_healthcare_Tract20_1990_2021_01P, year >= 2018)

#### Variables of Interest ####
# den_allphysicians:   All offices or clinics of physicians per 1000 people
# den_mentalhealthphys:   Offices or clinics of mental health physicians per 1000
# people
# den_outpatientclinics:   All outpatient medical clinics including Urgent Care centers
# and HMO per 1000 pp
# den_pharmacies: Retail pharmacies and drug stores per 1000 people

# Keep necessary columns 
healthcare <-  healthcare[,c("tract_fips20","year","den_allphysicians", "den_mentalhealthphys", 
      "den_outpatientclinics", "den_pharmacies")] 

healthcare <- healthcare %>% 
  rename("GEOID" = "tract_fips20")

# Save File
write.csv(healthcare,
          "NanDA - Health Care Services/health-services_nanda_tract_2018-2021.csv", row.names = FALSE)

# Citation: National Neighborhood Data Archive (NaNDA) Health Care Services by Census Tract and ZCTA, United States, 1990-2021

################################################################################
########################## Community Organizations #############################
################################################################################

nanda_relcivsoc_tract20_1990_2021_01P <- 
  read_dta("NaNDA - Community Orgs/nanda_relcivsoc_tract20_1990-2021_01P.dta")

# Filter for relevant years
organizations <- filter(nanda_relcivsoc_tract20_1990_2021_01P, year >= 2018)

#### Variables of Interest ####

# den_civ_soc: Civic and Social Associations per 1000 people
# den_religiousorgs: Religious Organizations per 1000 people
# den_youthorgs: Youth Organizations per 1000 people

organizations <-  organizations[,c("tract_fips20","year","den_civsoc", "den_religiousorgs", 
                             "den_youthorgs")] 

organizations <- organizations %>% 
  rename("GEOID" = "tract_fips20")

# Save File
write.csv(organizations,
          "NanDA - Community Orgs/civic-engagement_nanda_tract_2018-2021.csv", row.names = FALSE)

# Citation: National Neighborhood Data Archive (NaNDA) Civic, Social, Youth, Veterans’, and Religious Organizations by Census Tract and ZCTA, United
# States, 1990-2020

################################################################################
################################ Groceries #####################################
################################################################################

nanda_grocery_Tract20_1990_2021_01P <- 
  read_dta("NaNDA -  Groceries/nanda_grocery_Tract20_1990-2021_01P.dta")

groceries <- filter(nanda_grocery_Tract20_1990_2021_01P, year >= 2018)

#### Variables of Interest ####

# den_grocery: Grocery stores per 1000 people
# den_totalfoodstores: Total Food Stores per 1000 people

groceries <-  groceries[,c("tract_fips20","year","den_grocery", "den_totalfoodstores")] 

groceries <- groceries %>% 
  rename("GEOID" = "tract_fips20")

# Save File
write.csv(groceries,
          "NaNDA -  Groceries/food-insecurity_nanda_tract_2018-2021.csv", row.names = FALSE)

# Citation: National Neighborhood Data Archive (NaNDA) Grocery and Food Stores by Census Tract and ZCTA, United States, 1990-2021


################################################################################
########################## Public Transit Stops ################################
################################################################################


transit <-
  read_dta("NaNDA - Pubic Transit Stops/nanda_transit_tract_2016-2018_05P.dta")

transit <- transit %>% 
  rename("GEOID" = "tract_fips")


transit <-  transit[,c("GEOID","count_ntm_stops","stops_per_capita")] 

write.csv(transit,
          "NaNDA - Pubic Transit Stops/neighborhood_nanda_tract_2018-2021.csv", row.names = FALSE)





