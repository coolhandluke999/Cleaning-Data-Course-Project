#Data Cleaning Course Project
library(tidyverse)
library(dplyr)
library(reshape2)
#Download Dataset

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("./data")){
        dir.create("./data")
}

if(!file.exists("./data/wearable_date.csv")) {
        download.file(url,destfile="./data/wearable_data.zip",method="curl")
}

#Create test and train datasets
test_data = read.table("./data/X_test.txt")
train_data = read.table("./data/X_train.txt")

#Merge Subjects 
subject_test <- scan("./data/subject_test.txt")
subject_train <- scan("./data/subject_train.txt")
test_data <- cbind(test_data, subject_test)
train_data <- cbind(train_data, subject_train)
names(test_data)[names(test_data) == "subject_test"] <- "subject"
names(train_data)[names(train_data) == "subject_train"] <- "subject"
subjects <- rbind(test_data, train_data)
subjects <- subjects[562]

#Merge Activity labels 
activity_test <- scan("./data/y_test.txt")
activity_train <- scan("./data/y_train.txt")
test_data <- cbind(test_data, activity_test)
train_data <- cbind(train_data, activity_train)
names(test_data)[names(test_data) == "activity_test"] <- "activity"
names(train_data)[names(train_data) == "activity_train"] <- "activity"
activity <- rbind(test_data, train_data)
activity <- activity[563]

#(1)Merge test and train datasets
fulldata <- rbind(test_data, train_data)
backup <- fulldata

activity <- fulldata[563]
#Read in column names from features.txt
test <- scan("./data/features.txt", what = "character")
#create index vector identifying the elements not to include in the column names
numbers <- grep("^[0-9]", test)
#create vector of column names removing the line numbers(from numbers vector)
column_names <- test[-numbers]

#add column names to merged dataset
colnames(fulldata) <- column_names
names(fulldata)[562:563] <- c("subject", "activity")
#(2.)Extract the columns for mean and std deviation from the merged dataset
index <- grep("[Mm]ean|[Ss]td|subject|activity", names(fulldata))

fulldata <- fulldata[index] 
backup <- fulldata

#(3.) Turn activity numbers into descriptive activity names
test_factor <- fulldata$activity
test_factor <- as.character(test_factor)
test_factor <- gsub("1", "Walking", test_factor)
test_factor <- gsub("2", "Walking_Upstairs", test_factor)
test_factor <- gsub("3", "Walking_Downstairs", test_factor)
test_factor <- gsub("4", "Sitting", test_factor)
test_factor <- gsub("5", "Standing", test_factor)
test_factor <- gsub("6", "Laying", test_factor)

fulldata$activity <- test_factor
fulldata$activity <- factor(fulldata$activity, levels = c("Walking", "Walking_Upstairs", "Walking_Downstairs", "Sitting", "Standing", "Laying"), ordered = TRUE)

#(5.) create 2nd data set with the average of each variable for each activity and each subject
#Melt dataset to required information

dataMelt <- melt(fulldata, id=c("activity", "subject"), measure.vars=c(1:86))

#group by activity and subject while returning the mean to the value column
final_data <- fulldata %>% group_by(activity, subject) %>% summarize_all(list(mean))


write.table(dataMelt1, "./data/DateCleaningProjectDataset.txt", row.names = FALSE)





