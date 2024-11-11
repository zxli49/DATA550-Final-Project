here::i_am(
  "code/02_make_table.R"
)

df_sleep <- readRDS(
  file = here::here("data/data_cleaned.rds")
)

# Table 1: Descriptive summary table of key variables stratified by Sleep Quality

#1. The table provides a descriptive summary of key variables stratified by Quality of Sleep (which has categories like "Poor-Moderate" and "Good").

#2. Continuous variables are summarized as mean (SD), giving insights into the distribution of variables such as *Age*, *Sleep Duration*, and *Physical Activity Level* across different levels of sleep quality.

#3. Categorical variables like *Gender*, *BMI Category*, and *Sleep Disorder*, the table reports counts and percentages as n(%).

#4. An additional overall column is included to show the summary for the entire dataset.

#5. P-values assess whether there are statistically significant differences between the different levels of sleep quality for each variable.

library(tidyverse)
library(labelled)
library(gtsummary)

table1 <- df_sleep |> 
  select("Gender", "Age", "Sleep.Duration", "Quality.of.Sleep", "Physical.Activity.Level", "Stress.Level", "BMI.Category","Heart.Rate", "Daily.Steps", "Sleep.Disorder") |>
  tbl_summary(by = "Quality.of.Sleep",
              statistic = list(all_continuous() ~ "{mean} ({sd})",
                               all_categorical() ~ "{n} ({p}%)"),
              digits = list(all_continuous() ~ c(2, 2),
                            all_categorical() ~ c(0, 1))) |>
  modify_spanning_header(c("stat_1", "stat_2") ~ "**Quality of Sleep**") |>
  add_overall() |>
  add_p() |>
  bold_labels()

saveRDS(
  table1,
  file = here::here("output/table1.rds")
)



