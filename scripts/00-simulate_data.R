#### Preamble ####
# Purpose: Simulates data
# Author: Yisu Hou
# Date: 21 September 2024
# Contact: yisu.hou@mail.utoronto.ca
# License: None
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)


#### Simulate data ####
set.seed(114514)

# Define the start and end date
start_date <- 2020
end_date <- 2024

# Set the number of random dates you want to generate
number_of_cases <- 100

data_sim_budget <-
  tibble(
    year = round(
      runif(
        n = number_of_cases,
        min = start_date,
        max = end_date
      )),
    budget = rpois(n = number_of_cases, lambda = 2000)
  )

data_sim_crime <- tibble(year = c(2020, 2021, 2022, 2023, 2024),
      crime = rpois(n = 5, lambda = 20))


#### Write_csv
write_csv(data_sim_budget, file = "data/raw_data/simulated_budget.csv")
write_csv(data_sim_crime, file = "data/raw_data/simulated_crime.csv")

