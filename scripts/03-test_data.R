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

# Test for negative numbers
data_bud$budget |> min() <= 0
data_cri$crime |> min() <= 0

# Test for NAs
all(is.na(data_bud$budget))
all(is.na(data_cri$crime))






