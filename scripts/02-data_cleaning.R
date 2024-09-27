#### Preamble ####
# Purpose: Cleans the raw data into analysis data
# Author: Yisu Hou
# Date: 21 September 2024
# Contact: yisu.hou@mail.utoronto.ca
# License: None
# Pre-requisites: None

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_data_bud <- read_csv("data/raw_data/raw_budget_data.csv")
raw_data_cri <- read_csv("data/raw_data/raw_crime_data.csv")


# 2024 budget data was removed because crime rates data does not contain 2024
cleaned_bud <- raw_data_bud %>% select(Fiscal_Year, Amount) %>% 
  filter(Fiscal_Year <= 2023)

cleaned_cri <- raw_data_cri %>% filter(REPORT_YEAR >= 2020) %>%
  select(REPORT_YEAR, COUNT_, COUNT_CLEARED)
  

#### Save data ####
write_csv(cleaned_bud, "data/analysis_data/analysis_budget_data.csv")
write_csv(cleaned_cri, "data/analysis_data/analysis_crime_data.csv")
