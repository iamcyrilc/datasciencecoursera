# Getting and cleaning data peer graded assignment.
#-------------------------------

#Step 1:
# Download and extract the following data
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Step2 
# Load features, train and test data using R and research its composition and come up with a plan to tidy the data.

#Step 3
# Once the content and purpose of data is undestood do the following
# Column bind train dataset to make one dataset
# Column Bind test dataset to make one dataset.

#Step 4
# Clean up column names
# Factor Activity column


# Step 5
# Group and calculate mean

#Step 6
# Save the new tidy data


# Load libraries
library(data.table)
library(dplyr)
library(reshape2)

# Step 1
# Download data
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFileName <- "UCI HAR Dataset.zip"

if(!file.exists(dataFileName))
{
        download.file(dataUrl,dataFileName, mode = "wb")
}

# Extract files
dataFolder = "UCI HAR Dataset"
# Just check for one file to verify if files are already extracted.
#Note: This can be elegantly modified in future to check for all files and if any is missing, then delete all files and extract again.

if(!file.exists(file.path(dataPath, "activity_labels.txt")))
{
        unzip(dataFileName)
}

# Step 2
# Read training set files
trainSubjects <- read.table(file.path(dataFolder,"train", "subject_train.txt"))
trainActivity <- read.table(file.path(dataFolder, "train", "y_train.txt"))
trainValues <- read.table(file.path(dataFolder, "train", "X_train.txt"))

# Read test  files

testSubjects <- read.table(file.path(dataFolder, "test", "subject_test.txt"))
testActivity <- read.table(file.path(dataFolder, "test", "y_test.txt"))
testValues <- read.table(file.path(dataFolder, "test", "X_test.txt"))

# Read features and labels
features <- read.table(file.path(dataFolder, "features.txt"), as.is = TRUE)
activities <- read.table(file.path(dataFolder, "activity_labels.txt"))

#Step 3
# Join all activites by column bind
allTrainActivities <- cbind(trainSubjects,trainActivity, trainValues)
allTestActivities <- cbind(testSubjects,testActivity,testValues)

# Combine train and test data sets
allActivities <- rbind(allTrainActivities, allTestActivities)

# Setp 4
# Add column names
colnames(allActivities) <- c("subjectId", "activity", features[,2])

# For tidyData make all column names descriptive
# 1. Replace all starting 't' with 'time'
# 2. Replace all starting 'f' with 'frequency'
# 3. Remove ()
# 4. Expand texts like Acc to Accelorometer etc.

columns <- colnames(allActivities)

columns <- gsub("^t", "time",columns)
columns <- gsub("^f", "frequency",columns)
columns <- gsub("Acc", "Accelorometer",columns)
columns <- gsub("Gyro", "Gyroscope",columns)
columns <- gsub("Mag", "Magnitude",columns)
columns <- gsub("Freq", "Frequency",columns)
columns <- gsub("mean", "Mean",columns)
columns <- gsub("-std", "Std",columns)
columns <- gsub("[()]", "",columns)

colnames(allActivities) <- columns

#Use factor for activities
allActivities$activity <- factor(allActivities$activity, levels = activities[,1], labels = activities[,2])

# Setp 5
allActivities.melted <- melt(allActivities, id = c("subjectId", "activity"))
allActivities.mean <- dcast(allActivities.melted, subjectId + activity ~ variable, mean)

# Setp 6
#Write table
write.table(allActivities.melted, "tidy_data.txt", row.names = FALSE, quote = FALSE)