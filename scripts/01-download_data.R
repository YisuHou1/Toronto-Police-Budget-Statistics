#### Preamble ####
# Purpose: Downloads and saves the data from Open Data Toronto
# Author: Yisu Hou
# Date: 21 September 2024
# Contact: yisu.hou@mail.utoronto.ca
# License: None
# Pre-requisites: None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
library(dplyr)


# police budget data
# get package
package_bud <- show_package("668434ee-9541-40a8-adb6-0ad805fcc9b6")

# get all resources for this package
resources_bud <- list_package_resources("668434ee-9541-40a8-adb6-0ad805fcc9b6")

# identify datastore resources; by default, Toronto Open Data sets datastore
# resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources_bud <-
  filter(resources_bud, tolower(format) %in% c("csv", "geojson"))

# load all datasets for 2020 to 2024
data_bud0 <- filter(datastore_resources_bud, row_number() == 1) %>% get_resource()
data_bud1 <- filter(datastore_resources_bud, row_number() == 2) %>% get_resource()
data_bud2 <- filter(datastore_resources_bud, row_number() == 7) %>% get_resource()
data_bud3 <- filter(datastore_resources_bud, row_number() == 5) %>% get_resource()
data_bud4 <- filter(datastore_resources_bud, row_number() == 6) %>% get_resource()

# edit column names of older datasets for binding consistency
names(data_bud0)[names(data_bud0) == "_id"] <- "X_id"
names(data_bud1)[names(data_bud1) == "_id"] <- "X_id"

# combine yearly datasets into aggregate raw dataset, store as csv
raw_budget_data <- rbind(
  data_bud0, data_bud1, data_bud2, data_bud3,
  data_bud4
)
write_csv(raw_budget_data, "data/raw_data/raw_budget_data.csv")


# now retrieve reported crimes dataset
# get package
package_cri <- show_package("police-annual-statistical-report-reported-crimes")

# get all resources for this package
resources_cri <-
  list_package_resources("police-annual-statistical-report-reported-crimes")

# identify datastore resources; by default, Toronto Open Data sets datastore
# resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources_cri <-
  filter(resources_cri, tolower(format) %in% c("csv", "geojson"))

# load the crime dataset
data_cri <- filter(datastore_resources_cri, row_number() == 2) %>% get_resource()

#### Save data ####
write_csv(data_cri, "data/raw_data/raw_crime_data.csv")
