#### Preamble ####
# Purpose: Clean the "Rental Demolition and Replacement" dataset for further analysis
# Author: Zixuan Yang
# Date: 25 January 2024
# Contact: [Your Contact Information]
# License: MIT License
# Pre-requisites: dplyr, readr, lubridate packages installed

# Load necessary libraries
library(dplyr)
library(readr)
library(lubridate)

# Read the dataset
data <- read_csv("inputs/data/unedited_data.csv")

# Check if 'City Council Approval Date' column exists
if ("City Council Approval Date" %in% names(data)) {
  # Clean the data
  cleaned_data <- data %>%
    mutate(
      `City Council Approval Date` = ymd(`City Council Approval Date`), # Convert date format
      # Replace placeholders with NA and convert to numeric
      across(c(`Total Rental Homes for Demolition`, 
               `Affordable Rental Homes for Demolition`, 
               `Mid-Range Rental Homes for Demolition`, 
               `High-End Rental Homes for Demolition`, 
               `Total Rental Homes Replaced`, 
               `Affordable Rental Homes Replaced`, 
               `Mid-Range Rental Homes Replaced`, 
               `High-End Rental Homes Replaced`), 
             ~na_if(.x, "-") %>% as.numeric)
    ) %>%
    distinct()  # Removes duplicate rows
  
    # Save the cleaned data
    write_csv(cleaned_data, "outputs/data/analysis_data.csv")
  
  # Output a message indicating success
  message("Cleaned data successfully saved to 'outputs/data/analysis_data.csv'.")
} else {
  stop("The column 'City Council Approval Date' does not exist in the dataset.")
}

