library(caret)
library(randomForest)

# 1. Load the cleaned data
data <- read.csv("data\stress_data_clean.csvv")

# 2. Rename target column to Stress (convert from Stress.Level..1.10.)
data$Stress <- as.factor(data$Stress.Level..1.10.)

# 3. Select useful features
features <- c("Age", "Sleep.Hours", "Caffeine.Intake..mg.day.", 
              "Physical.Activity..hrs.week.", "Heart.Rate..bpm.", 
              "Breathing.Rate..breaths.min.")

# 4. Train/test split
set.seed(123)
idx <- createDataPartition(data$Stress, p = 0.8, list = FALSE)
train <- data[idx, ]
test  <- data[-idx, ]

# 5. Scale numeric predictors
X_train <- train[, features]
means <- apply(X_train, 2, mean)
sds   <- apply(X_train, 2, sd)
X_train_scaled <- as.data.frame(scale(X_train, center = means, scale = sds))

# Combine with target
train_scaled <- cbind(X_train_scaled, Stress = train$Stress)

# 6. Train model
model <- randomForest(Stress ~ ., data = train_scaled, ntree = 100)

# 7. Save model and scaling params
if (!dir.exists("models")) dir.create("models")
saveRDS(model, "models/stress_model.rds")
saveRDS(list(means = means, sds = sds), "models/scaling_params.rds")

# 8. Optional: Evaluate on test set
X_test <- test[, features]
X_test_scaled <- as.data.frame(scale(X_test, center = means, scale = sds))
pred <- predict(model, X_test_scaled)
print(confusionMatrix(pred, test$Stress))
