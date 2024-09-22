#### Preamble ####
# Purpose: Analyze Toronto Police Budget and Crime Rates Over Time
# Author: Yisu Hou
# Date: 21 September 2024
# Contact: yisu.hou@mail.utoronto.ca
# License: None
# Pre-requisites: None


#### Workspace setup ####
library(tidyverse)
library(knitr)
library(kableExtra)

#### Read data ####
data_bud <- read_csv("data/analysis_data/analysis_budget_data.csv")
data_cri <- read_csv("data/analysis_data/analysis_crime_data.csv")

### Model data ####
# table of yearly police budget over time
summary_table_bud <- data.frame(
  Year = c(2020, 2021, 2022, 2023),
  
  Yearly_Budget = c(sum(data_bud %>% filter(Fiscal_Year == 2020) %>%
                          select(Amount)),
                    sum(data_bud %>% filter(Fiscal_Year == 2021) %>%
                          select(Amount)),
                    sum(data_bud %>% filter(Fiscal_Year == 2022) %>%
                          select(Amount)),
                    sum(data_bud %>% filter(Fiscal_Year == 2023) %>%
                          select(Amount)))
)

summary_table_bud = summary_table_bud %>% mutate(
  Change_From_Last = case_when(
    Year == 2020 ~ NA,
    TRUE ~ Yearly_Budget - lag(Yearly_Budget)
  ),
  
  Percent_Change = case_when(
    Year == 2020 ~ NA,
    TRUE ~ round(100* ((Yearly_Budget - lag(Yearly_Budget))/
                                 lag(Yearly_Budget)), 2)
  )
)

# present the table using knitr
summary_table_bud %>%
  kable("html", col.names = c("Year", "Yearly Budget", 
                              "Change From Last", "Percent Change")) %>%
  kable_styling(bootstrap_options = c("striped",
                                      "hover", "condensed", "responsive"))

# table of number of crimes over time
summary_table_cri <- data.frame(
  Year = c(2020, 2021, 2022, 2023),
  
  Yearly_Crimes = c(sum(data_cri %>% filter(REPORT_YEAR == 2020) %>%
                          select(COUNT_)),
                    sum(data_cri %>% filter(REPORT_YEAR == 2021) %>%
                          select(COUNT_)),
                    sum(data_cri %>% filter(REPORT_YEAR == 2022) %>%
                          select(COUNT_)),
                    sum(data_cri %>% filter(REPORT_YEAR == 2023) %>%
                          select(COUNT_))),
  
  Cleared_Crimes = c(sum(data_cri %>% filter(REPORT_YEAR == 2020) %>%
                           select(COUNT_CLEARED)),
                     sum(data_cri %>% filter(REPORT_YEAR == 2021) %>%
                           select(COUNT_CLEARED)),
                     sum(data_cri %>% filter(REPORT_YEAR == 2022) %>%
                           select(COUNT_CLEARED)),
                     sum(data_cri %>% filter(REPORT_YEAR == 2023) %>%
                           select(COUNT_CLEARED)))
)

summary_table_cri <- summary_table_cri %>% mutate(
  Percentage_Cleared =  round(100*(Cleared_Crimes/Yearly_Crimes), 2)
)

# present the table using knitr
summary_table_cri %>%
  kable("html", col.names = c("Year", "Yearly Crimes", 
                              "Cleared Crimes", "Percent Cleared")) %>%
  kable_styling(bootstrap_options = c("striped",
                                      "hover", "condensed", "responsive"))


# graphs to show change in police budget and crime rates over time
ggplot(data = summary_table_bud, aes(x = Year, y = Yearly_Budget)) + 
  geom_bar(stat = "identity", fill = "skyblue") + 
  labs(
    title = "Figure 1: Total Police Budget Over Time",
    x = "Year",
    y = "Yearly Budget ($)"
  )

