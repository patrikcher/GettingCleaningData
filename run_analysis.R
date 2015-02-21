# This script downloads and prepares tidy UCI HAR data that can be used for later analysis

# Step 0 - Download and unzip UCI_HAR_data.zip.
# NOTE: This will only download data when UCI HAR Dataset folder doesnt exist.
# If download fails, retry after deleting UCI HAR Dataset folder.
if (!file.exists("UCI HAR Dataset")) {
  # download the data
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zipfile="UCI_HAR_data.zip"
  message("Downloading data")
  download.file(fileURL, destfile=zipfile, method="curl")
  unzip(zipfile)
}

# Step 1 - Merges the training and the test sets to create one data set.
tmp_x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
tmp_x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
tmp_s_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
tmp_s_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
tmp_y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
tmp_y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

X_data <- rbind(tmp_x_train, tmp_x_test)
S_data <- rbind(tmp_s_train, tmp_s_test)
Y_data <- rbind(tmp_y_train, tmp_y_test)

# 2 - Extracts only the measurements on the mean and 
# standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
feature_index <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X_data <- X_data[, feature_index]
names(X_data) <- features[feature_index, 2]
# data scrubbing - remove brackets and convert to lowercase for uniformity
names(X_data) <- gsub("\\(|\\)", "", names(X_data))
names(X_data) <- tolower(names(X_data))

# Step 3 - Uses descriptive activity names to name the activities in the data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
# data scrubbing - remove underscores and convert activity names to lowercase for uniformity
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y_data[, 1] = activities[Y_data[, 1], 2]
names(Y_data) <- "activity"

# Step 4 - Appropriately labels the data set with descriptive variable names. 
names(S_data) <- "subject"
cleaned <- cbind(S_data, Y_data, X_data)
write.table(cleaned, "merged_tidy_data.txt")

# Step 5 - From the data set in step 4, 
# creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject.
uniqueSubjects = unique(S_data)[, 1]
numOfSubjects = length(unique(S_data)[, 1])
numOfActivities = length(activities[, 1])
numOfCols = dim(cleaned)[2]
result = cleaned[1:(numOfSubjects*numOfActivities), ]

row = 1
for (sub in 1:numOfSubjects) {
  for (act in 1:numOfActivities) {
    result[row, 1] = uniqueSubjects[sub]
    result[row, 2] = activities[act, 2]
    tmp <- cleaned[cleaned$subject==sub & cleaned$activity==activities[act, 2], ]
    result[row, 3:numOfCols] <- colMeans(tmp[, 3:numOfCols])
    row = row+1
  }
}

write.table(result, "tidy_data_with_averages.txt")