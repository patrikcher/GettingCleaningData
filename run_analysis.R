## This script prepares tidy data that can be used for later analysis

## 1 - Merges the training and the test sets to create one data set.
tmp_x_train <- read.table("train/X_train.txt")
tmp_x_test <- read.table("test/X_test.txt")
X_data <- rbind(tmp_x_train, tmp_x_test)

tmp_s_train <- read.table("train/subject_train.txt")
tmp_s_test <- read.table("test/subject_test.txt")
S_data <- rbind(tmp_s_train, tmp_s_test)

tmp_y_train <- read.table("train/y_train.txt")
tmp_y_test <- read.table("test/y_test.txt")
Y_data <- rbind(tmp_y_train, tmp_y_test)

## 2 - Extracts only the measurements on the mean and 
## standard deviation for each measurement.
features <- read.table("features.txt")
indices_of_good_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X_data <- X_data[, indices_of_good_features]
names(X_data) <- features[indices_of_good_features, 2]
names(X_data) <- gsub("\\(|\\)", "", names(X_data))
names(X_data) <- tolower(names(X_data))

## 3 - Uses descriptive activity names to name the activities in the data set
activities <- read.table("activity_labels.txt")
activities[, 2] = gsub("_", "", tolower(as.character(activities[, 2])))
Y_data[,1] = activities[Y_data[,1], 2]
names(Y_data) <- "activity"

## 4 - Appropriately labels the data set with descriptive variable names. 
names(S_data) <- "subject"
cleaned <- cbind(S_data, Y_data, X_data)
write.table(cleaned, "merged_clean_data.txt")

## 5 - From the data set in step 4, 
## creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
uniqueSubjects = unique(S_data)[,1]
numSubjects = length(unique(S_data)[,1])
numActivities = length(activities[,1])
numCols = dim(cleaned)[2]
result = cleaned[1:(numSubjects*numActivities), ]

row = 1

for (s in 1:numSubjects) {
  for (a in 1:numActivities) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- cleaned[cleaned$subject==s & cleaned$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}

write.table(result, "data_with_averages.txt")