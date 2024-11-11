here::i_am(
  "code/01_data_processing.R"
)

absolute_path_to_data <- here::here("data", "Sleep_health_and_lifestyle_dataset.csv")
df_sleep <- read.csv(absolute_path_to_data, header = TRUE)

# View first few rows of the data
print(head(df_sleep,5))

# Initial Raw Data Information
summary(df_sleep)

# Transfer Quality of Sleep and Stress Level to Category Variables
'
Quality of Sleep: Assume
    0-6: Poor-Moderate sleep quality;
    7-9: Good sleep quality

Stress Level: Assume
    1-3: Low stress;
    4-6: Moderate stress;
    7-9: High stress
'

library(tidyverse)
df_sleep <- df_sleep |>
  mutate(Quality.of.Sleep = as.numeric(Quality.of.Sleep),
         Stress.Level = as.numeric(Stress.Level)) |>
  mutate(Quality.of.Sleep = cut(Quality.of.Sleep, 
                                breaks = c(0, 6, 9), 
                                labels = c("Poor-Moderate", "Good"), 
                                include.lowest = TRUE),
         Stress.Level = cut(Stress.Level, 
                            breaks = c(0, 3, 6, 9), 
                            labels = c("Low","Moderate", "High"), 
                            include.lowest = TRUE))

# Unify the BMI categories
df_sleep <- df_sleep %>%
  mutate(BMI.Category = recode(BMI.Category, 
                               `Normal Weight` = "Normal"))

saveRDS(
  df_sleep, 
  file = here::here("data/data_cleaned.rds")
)

