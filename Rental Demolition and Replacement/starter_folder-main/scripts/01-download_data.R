#### Preamble ####
# Purpose: # Purpose: Downloads and saves the dataset on rental housing demolition and replacement from Open Data Toronto
# Author: Zixuan Yang 
# Date: 25 January 2024
# Contact: 
# License: MIT
# Pre-requisites: R environment with 'opendatatoronto' and 'dplyr' packages installed
# Any other information needed? 


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(readr)

# Define the dataset identifier for "demolition-and-replacement-of-rental-housing-units"
dataset_id <- "demolition-and-replacement-of-rental-housing-units"

# Use the opendatatoronto package to get information about the package
package_info <- show_package(dataset_id)
print(package_info)

# Get all resources for this package
resources <- list_package_resources(dataset_id)

# Identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# Assuming the dataset is the first resource, download the dataset
# If the actual dataset is not the first, you would need to adjust the filter condition to select the correct resource
data_resource <- datastore_resources %>% 
  filter(row_number() == 1) %>%
  pull("id")

# Download the resource by its ID
data <- get_resource(data_resource)

# Save the data to the specified folder
write_csv(data, "inputs/data/unedited_data.csv")

# Output a message indicating success
message("Data successfully downloaded and saved to inputs/data/unedited_data.csv")
