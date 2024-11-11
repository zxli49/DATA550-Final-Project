here::i_am(
  "code/03_make_figures.R"
)

df_sleep <- readRDS(
  file = here::here("data/data_cleaned.rds")
)

library(ggplot2)

# Figure 1: Distribution of Sleep Duration by Quality of Sleep

# This box plot depicts the distribution of Sleep Duration across different Quality of Sleep categories (Poor-Moderate and Good). The median sleep duration is represented by the line inside each box, with the boxes displaying the IQR.

# Create a boxplot showing the distribution of Sleep Duration stratified by Quality of Sleep
plot1 <- ggplot(df_sleep, aes(x = Quality.of.Sleep, y = Sleep.Duration, fill = Quality.of.Sleep)) +
  geom_boxplot() +
  labs(title = "Distribution of Sleep Duration by Quality of Sleep",
       x = "Quality of Sleep",
       y = "Sleep Duration (hours)") +
  theme_minimal() +
  scale_fill_manual(values = c("Poor-Moderate" = "red", "Good" = "blue")) +
  theme(legend.position = "none")

# Figure 2: Proportion of Sleep Disorder by Quality of Sleep

# This stacked bar plot illustrates the relationship between Sleep Disorder categories (None, Insomnia, Sleep Apnea) and Quality of Sleep (Poor-Moderate and Good). The height of each segment in the bars represents the proportion of individuals within each sleep disorder category for the respective quality of sleep level.

# Create a stacked bar plot showing the relationship between Sleep Disorder and Quality of Sleep
plot2 <- ggplot(df_sleep, aes(x = Quality.of.Sleep, fill = Sleep.Disorder)) +
  geom_bar(position = "fill", alpha = 0.7) +  # Use "fill" position to show proportions
  labs(title = "Proportion of Sleep Disorder by Quality of Sleep",
       x = "Quality of Sleep",
       y = "Proportion") +
  scale_fill_manual(values = c("None" = "blue", "Insomnia" = "orange", "Sleep Apnea" = "purple")) +
  theme_minimal() +
  theme(legend.title = element_blank())

# save the figures
ggsave(
  here::here("output/plot1_box.png"),
  plot = plot1,
  device = "png"
)

ggsave(
  here::here("output/plot2_bar.png"),
  plot = plot2,
  device = "png"
)

