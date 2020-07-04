# Cleaning-Data-Course-Project
Cleaning Data Course Project Files

This project used data from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full description of data here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

RUN_ANALYSIS.R SCRIPT

1. Downloads the data into a "data" directory off of the user's working directory
2. Assumes user has unzipped the files in the data directory
3. Create test and train datasets from X_test.txt and X_train.txt
4. Create subject datasets for both test and train from subject_test.txt and subject_train.txt
5. Create activity datasets for both test and train from y_test.txt and y_train.txt
6. Applied column name renaming to 4 and 5.
7. Combined test andt train datasets using rbind().
8. Create a column names vector from features.txt and add these column names to the dataset.  
9. Identified columns with mean and(or) std deviation in their name and kept these columns, discarding the rest minus subject and activity.
10. Renamed activity column records as descriptive "Activity" variables (Walking, Walking Upstairs, Walking Downstairs,Sitting, Standing, Laying), as per the activity_labels.txt file, and set these values as factors.
11. Created a second dataset from the first that lists the mean of each variable per activity and subject.
12. This second data set is a "tidy" dataset consisting of one variable measure per column, and one observation of that variable in each row(summarized as the mean). 



