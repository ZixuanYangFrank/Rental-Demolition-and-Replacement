#### Preamble ####
# Purpose: Data Testing and Evaluation
# Author: Zixuan Yang
# Date: 25 January 2024
# Contact:
# License: MIT
# Pre-requisites: R, tidyverse, lubridate, caret

#### Workspace setup ####
library(tidyverse)   # For data manipulation and visualization
library(lubridate)   # For handling dates
library(caret)       # For model training and evaluation

# Load your cleaned dataset (replace 'outputs/data/analysis_data.csv' with your actual dataset file path)
data <- read_csv("outputs/data/analysis_data.csv")

# Data Preprocessing
#Split the data into training and testing sets
set.seed(123)  # For reproducibility
train_indices <- sample(1:nrow(data), 0.8 * nrow(data)) # Randomly select 80% of data for training
train_data <- data[train_indices, ]
test_data <- data[-train_indices, ]

# Data Exploration
# Summary statistics
summary(data)
head(data)

# Data Quality Checks
# Check for missing values
missing_values <- colSums(is.na(data))
print("Missing Values:")
print(missing_values)

# Data Testing and Evaluation
# Hypothesis Testing
#  T-test
group1 <- subset(train_data, group_variable == "Group 1")$target_variable
group2 <- subset(train_data, group_variable == "Group 2")$target_variable
t_test_result <- t.test(group1, group2)
print("T-Test Result:")
print(t_test_result)

# Regression Analysis
# Example: Linear Regression
model <- lm(target_variable ~ predictor_variable, data = train_data)
summary(model)

# Model Evaluation (For regression models, you can use appropriate metrics like RMSE, MAE, R-squared)
predictions <- predict(model, newdata = test_data)
rmse <- sqrt(mean((predictions - test_data$target_variable)^2))
mae <- mean(abs(predictions - test_data$target_variable))
r_squared <- 1 - sum((predictions - test_data$target_variable)^2) / sum((mean(test_data$target_variable) - test_data$target_variable)^2)

# Print model evaluation metrics
cat("Model Evaluation:\n")
cat("RMSE:", rmse, "\n")
cat("MAE:", mae, "\n")
cat("R-squared:", r_squared, "\n")

# You can customize and expand this script further based on your specific analysis requirements and research questions.
