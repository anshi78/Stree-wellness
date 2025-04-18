library(dplyr)

# Load raw data
data <- read.csv("./data/enhanced_anxiety.csv")


# Clean column names (remove special characters and spaces)
names(data) <- make.names(names(data))

# OPTIONAL: View column names
print(names(data))

# Save cleaned version
write.csv(data, "data\stress_data_clean.csv", row.names = FALSE)
