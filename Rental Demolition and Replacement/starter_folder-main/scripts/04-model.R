#### Preamble ####
# Purpose: Models 
# Author: Zixuan Yang 
# Date: 25 January 2024
# Contact: 
# License: MIT
# Pre-requisites: 
# Any other information needed? 


# Load required libraries
library(tidyverse)   # For data manipulation and visualization
library(lubridate)   # For handling dates
library(glmnet)      # For regularized linear regression (lasso or ridge)

# Load your cleaned dataset (replace 'outputs/data/analysis_data.csv' with your actual dataset file path)
data <- read_csv("outputs/data/analysis_data.csv")

# Data Preprocessing
# You can perform additional data preprocessing steps here, such as feature engineering and data splitting.

# Example: Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- createDataPartition(data$target_variable, p = 0.8, list = FALSE)
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Model Selection
# Choose the most appropriate model based on your research objectives

# Model 1: Regularized Linear Regression (Lasso or Ridge)
# Example using glmnet package
model <- glmnet(x = as.matrix(train_data[, -c("target_variable")]), 
                y = train_data$target_variable, alpha = 1)  # Lasso

# Model Evaluation (For regression models, you can use appropriate metrics like RMSE, MAE, R-squared)
# Example: Evaluate the selected model
predictions <- predict(model, s = 0.1, newx = as.matrix(test_data[, -c("target_variable")]))
rmse <- sqrt(mean((predictions - test_data$target_variable)^2))
mae <- mean(abs(predictions - test_data$target_variable))
r_squared <- 1 - sum((predictions - test_data$target_variable)^2) / sum((mean(test_data$target_variable) - test_data$target_variable)^2)

# Print model evaluation metrics
cat("Model Evaluation:\n")
cat("RMSE:", rmse, "\n")
cat("MAE:", mae, "\n")
cat("R-squared:", r_squared, "\n")

# Model Interpretation
# Interpret the selected model based on your research objectives

# Save the final model (optional)
saveRDS(model, file = "outputs/models/final_model.rds")

# Generate predictions using the final model (optional)
final_predictions <- predict(model, s = 0.1, newx = as.matrix(your_new_data))

