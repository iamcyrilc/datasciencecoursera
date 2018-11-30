# Getting and Cleaning Data - Data Science Assignment 


This is a peer reviewed assignment for Getting and Cleaning Data Coursera project. Following files are included in this repo.

1. run_Analysis.R - contains R source code for the project.
2. CodeBook.md - contains detailed information about all tables and variables.
3. tidy_data.txt - Contains final output of the project. This is a tidy dataset.

## Work Flow
1. Download the data if it does not exist in the workspace.
2. Extract the data if it is not already extracted.
3. Read all data files into memory.
4. Join all training set data. Join by column bind.
5. Join all test data. Join by column bound.
6. Join training and test data.
7. Assign column names to the joined data.
8. Clean column names that are not very descriptive.
9. Convert activity column to `factor` column.
10. Group by subject and activity column and then find mean of each category.
11. Write output to `tidy_data.txt`

## How to run the script.
1.Set the workspace in RStudio. 
2. Load the script into RStudio.
3. Run the script.
4. After successfully executing the script `tidy_data.txt` will be created in the workspace.

