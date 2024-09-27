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
end_date <- 2023

# number of random cases to be generated
number_of_cases <- 1000

# simulate the raw budget dataset with individual instances of expenditure
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

# simulate crime count dataset with number of reports and number of cleared
# reports
data_sim_crime <-
  tibble(
    year = round(
      runif(
        n = number_of_cases,
        min = start_date,
        max = end_date
      )),
   crime = rpois(n = number_of_cases, lambda = 100)
  )

# number of cleared crimes is between 0 and reported crimes
data_sim_crime <- data_sim_crime %>%
  rowwise() %>%
    mutate(cleared = sample(0:crime, 1)) %>%
    ungroup()


#### Write_csv
write_csv(data_sim_budget, file = "data/raw_data/simulated_budget.csv")
write_csv(data_sim_crime, file = "data/raw_data/simulated_crime.csv")

