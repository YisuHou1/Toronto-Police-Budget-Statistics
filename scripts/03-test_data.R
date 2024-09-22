#### Preamble ####
# Purpose: Sanity check of the data
# Author: Yisu Hou
# Date: 21 September 2024
# Contact: yisu.hou@mail.utoronto.ca
# License: None
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)


#### Test data ####
data_bud <- read_csv("data/raw_data/simulated_budget.csv")
data_cri <- read_csv("data/raw_data/simulated_crime.csv")
raw_bud <- read_csv("data/raw_data/raw_budget_data.csv")
raw_cri <- read_csv("data/raw_data/raw_crime_data.csv")

# Test for negative numbers
data_bud$budget |> min() <= 0
data_cri$crime |> min() <= 0
raw_bud$Amount |> min() <= 0
raw_cri$COUNT_ |> min() <= 0
# the raw dataset for budget contains negative numbers because 
# the police department makes revenue sometimes

# Test for NAs
all(is.na(data_bud$budget))
all(is.na(data_cri$crime))
all(is.na(raw_bud$Amount))
all(is.na(raw_cri$COUNT_))






