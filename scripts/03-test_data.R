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
# simulated and raw datasets
data_bud <- read_csv("data/raw_data/simulated_budget.csv")
data_cri <- read_csv("data/raw_data/simulated_crime.csv")
raw_bud <- read_csv("data/raw_data/raw_budget_data.csv")
raw_cri <- read_csv("data/raw_data/raw_crime_data.csv")
# cleaned datasets
cleaned_bud <- read_csv("data/analysis_data/analysis_budget_data.csv")
cleaned_cri <- read_csv("data/analysis_data/analysis_crime_data.csv")

# Test for negative numbers: simulated and raw data
# Does not test for values equal to 0 because there can be 0 reported crimes
# and 0 budget
data_bud$budget |> min() < 0
data_cri$crime |> min() < 0
data_cri$cleared |> min() < 0
raw_bud$Amount |> min() < 0
raw_cri$COUNT_ |> min() < 0
raw_cri$COUNT_CLEARED |> min() < 0
# only the raw dataset for budget contains negative numbers because
# the police department makes revenue sometimes

# Test for NAs: simulated and raw data
all(is.na(data_bud$budget))
all(is.na(data_cri$crime))
all(is.na(data_cri$cleared))
all(is.na(raw_bud$Amount))
all(is.na(raw_cri$COUNT_))
all(is.na(raw_cri$COUNT_CLEARED))
# there are no NAs in all datasets

# Test raw dataset for repeated sampling
# Identify duplicates based on instance id and year
duplicate_bud <- duplicated(raw_bud[, c("X_id", "Fiscal_Year")])

# Extract duplicate-only rows
duplicate_rows_bud <- raw_bud[duplicate_bud, ]

# repeat for crime dataset
duplicate_cri <- duplicated(raw_cri[, c("X_id", "REPORT_YEAR")])

# Extract duplicate-only rows
duplicate_rows_cri <- raw_cri[duplicate_cri, ]

# Both duplicates dataframes are empty, meaning that there are no duplicates


#### Complete set of tests for cleaned data ####
# negative numbers
cleaned_bud$Amount |> min() < 0
cleaned_cri$COUNT_ |> min() < 0
cleaned_cri$COUNT_CLEARED |> min() < 0
# again, police budget contains negative numbers due to revenues

# NAs
all(is.na(cleaned_bud))
all(is.na(cleaned_cri))

# Check if the range of time is correct
cleaned_bud$Fiscal_Year |> min() == 2020
cleaned_bud$Fiscal_Year |> max() == 2023
cleaned_cri$REPORT_YEAR |> min() == 2020
cleaned_cri$REPORT_YEAR |> max() == 2023

# Check if variables of interest are numbers and not other data types
is.double(cleaned_bud$Amount)
is.double(cleaned_cri$COUNT_)
is.double(cleaned_cri$COUNT_CLEARED)
