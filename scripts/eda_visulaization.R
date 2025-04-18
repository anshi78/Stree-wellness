library(ggplot2)
data <- read.csv("data/clean_stress_data.csv")

# Stress level distribution
ggplot(data, aes(x = stress_level)) +
  geom_bar(fill = "tomato") +
  theme_minimal() +
  ggtitle("Stress Level Distribution")

# Sleep vs Stress
ggplot(data, aes(x = sleep_hours, fill = stress_level)) +
  geom_density(alpha = 0.6) +
  theme_minimal() +
  ggtitle("Sleep Hours vs Stress Level")
