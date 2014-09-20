# Course Project for Getting and Cleaning Data

## Data Set

Data set used in this project: Human Activity Recognition Using Smartphones

Original source of the data set: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Source of the data set for this course project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Analysis

Analysis is done using run_analysis.R script with the assumption that activity labels and features data is in the working directory, while training and test data are in train and test subdirectories of the working directory respectively.

### Loading Data

Activity labels are loaded from activity_labels.txt using read.table(). Columns are renamed to activity code and activity respectively.

Features are loaded from features.txt.

Training data is loaded into three data frames: subject_train from subject_train.txt, x_train from X_train.txt and y_train from y_train.txt.

Test data  is loaded into three data frames: subject_test from subject_test.txt, x_test from X_test.txt and y_test from y_test.txt.

### Merging Trainin and Test Data Set

Training and test data sets are merged using rbind() into three data frames: subject, x and y. Column in subject is labeled subject, columns in x are labeled using features and column in y is labeled activity code.

### Exracting Only Features of Interest

Only features that are related to mean and standard deviation (std) were extracted. Mean frequency features (meanFreq) were not included. Data frame x_mean_std has been produced from x with only those features that were of interest.

### Reshaping the data frame

Subject, x_mean_std and y data frames were combined into a single data frame mean_std_data. This was then modified into mean_std_data_activity data frame, to include activity labels ("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"), based on activity codes. Finally, activy codes were excluded as a column in the final data frame mean_std_data_final.

### Creating tidy data set with the average of each variable for each activity and each subject

