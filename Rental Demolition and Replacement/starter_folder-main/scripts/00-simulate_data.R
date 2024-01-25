#### Preamble ####
# Purpose: Simulates the "Rental Demolition and Replacement" dataset for analysis
# Author: Zixuan Yang
# Date: 25 January 2024
# Contact: 
# License: MIT
# Pre-requisites: R environment with 'tidyverse' package installed, knowledge of R scripting
# Additional Notes: This script generates simulated data based on the structure and summary statistics of the original dataset from Open Data Toronto. It is designed to assist in the development of data analysis workflows and the testing of statistical methods.


#### Workspace setup ####
library(tidyverse)
library(lubridate)

# Set seed for reproducibility
set.seed(123)

# Define the number of rows for the simulated dataset
n <- 83

# Simulate numeric data with possibility of NA values
simulate_numeric <- function(n, min, max, na_prob = 0.05) {
  sample(c(NA, min:max), n, replace = TRUE, prob = c(na_prob, rep((1 - na_prob) / (max - min + 1), max - min + 1)))
}

# Simulate categorical data with possibility of NA values
simulate_categorical <- function(categories, n, na_prob = 0.05) {
  sample(c(NA, categories), n, replace = TRUE, prob = c(na_prob, rep((1 - na_prob) / length(categories), length(categories))))
}

# Simulate date data
simulate_date <- function(n, start_date, end_date) {
  seq.Date(as.Date(start_date), as.Date(end_date), length.out = n) |>
    sample(size = n, replace = TRUE)
}

# Define vectors for categorical simulation based on the provided data examples
types <- c("Demolition - 6 Rental Units or More", "Conversion", "Severance")
report_link <- "Final Staff Report"

# Simulate the data
simulated_data <- tibble(
  id = 1:n,
  IBMS_Address = str_c(sample(100:999, n, replace = TRUE), " ", sample(LETTERS, n, replace = TRUE), sample(1:99, n, replace = TRUE), " ", sample(c("ST", "AVE", "RD", "DR"), n, replace = TRUE)),
  Address_of_Existing_Rental_Building = str_c(sample(100:999, n, replace = TRUE), " ", sample(LETTERS, n, replace = TRUE), sample(1:99, n, replace = TRUE), " ", sample(c("ST", "AVE", "RD", "DR"), n, replace = TRUE)),
  RH_File_Number = str_c(sample(10:20, n, replace = TRUE), " ", sample(100000:999999, n, replace = TRUE), " ", sample(c("STE", "NNY", "ESC"), n, replace = TRUE), " ", sample(1:30, n, replace = TRUE), " RH"),
  Post_2018_Ward = sample(1:25, n, replace = TRUE),
  City_Council_Approval_Date = simulate_date(n, '2018-01-01', '2023-12-31'),
  Link_to_Staff_Report = report_link,
  Type = simulate_categorical(types, n),
  Total_Rental_Homes_for_Demolition = simulate_numeric(n, 1, 200),
  Affordable_Rental_Homes_for_Demolition = simulate_numeric(n, 0, 200),
  Mid_Range_Rental_Homes_for_Demolition = simulate_numeric(n, 0, 200),
  High_End_Rental_Homes_for_Demolition = simulate_numeric(n, 0, 200),
  Total_Rental_Homes_Replaced = simulate_numeric(n, 1, 200),
  Affordable_Rental_Homes_Replaced = simulate_numeric(n, 0, 200),
  Mid_Range_Rental_Homes_Replaced = simulate_numeric(n, 0, 200),
  High_End_Rental_Homes_Replaced = simulate_numeric(n, 0, 200)
)

# Check if the simulated data frame has the correct number of rows and columns
stopifnot(nrow(simulated_data) == n)
stopifnot(ncol(simulated_data) == length(names(simulated_data)))

# Check if the City Council Approval Dates are within the expected range
stopifnot(all(simulated_data$City_Council_Approval_Date >= as.Date('2018-01-01')))
stopifnot(all(simulated_data$City_Council_Approval_Date <= as.Date('2023-12-31')))

# Save the simulated data to the specified directory
write_csv(simulated_data, "inputs/data/simulated_rental_demolition_and_replacement.csv")

