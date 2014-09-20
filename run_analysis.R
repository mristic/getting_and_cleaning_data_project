# Load activity labels from activity_labels.txt
activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("activity code", "activity")

# Load features from features.txt
features <- read.table("features.txt")[, 2]

# Load training data from files in train subdirectory
subject_train <- read.table("train/subject_train.txt")
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")

# Load test data from files in test subdirectory
subject_test <- read.table("test/subject_test.txt")
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")

# Merge the training and the test sets
subject <- rbind(subject_train, subject_test)
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)

# Label the columns
names(subject) <- "subject"
names(x) <- features
names(y) <- "activity code"

# Extract only the features related to the mean or standard deviation for each measurement
# Find features of interest
features_mean_std <- grepl("mean\\(\\)|std\\(\\)", features)

# Limit x to columns with the mean or standard deviation for each measurement
x_mean_std <- x[, features_mean_std]

# Bind subject, y and feature measurements of interest (x_mean_std)
mean_std_data <- cbind(subject, y, x_mean_std)

# Add activity labels based on activity codes in y using merge
mean_std_data_activity <- merge(mean_std_data, activity_labels, by = "activity code")

# Exclude column with activity codes
mean_std_data_final <- mean_std_data_activity[names(mean_std_data_activity) != "activity code"]

# mean_std_data_final satisfies project requirements #1, #2, #3 and #4.
# It is merged from test and training data, has only the mean and standard deviation for each feature,
# uses descriptive labels for activities, as well as for all the variables (features).

# create tidy data set with the average of each variable for each activity and each subject
tidy_data <- aggregate(. ~ subject + activity, data = mean_std_data_final, FUN = mean)

# Create txt file with write.table() using row.name=FALSE
write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)
