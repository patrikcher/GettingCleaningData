Getting and Cleaning Data
=========================
## Course Project Cook Book

### Introduction
The script run_analysis.R does the following:

1. Merges the training and test sets to create one data set
2. Extracts only the measurements on the mean and standard deviation for each measurement
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Getting and cleaning data
Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### Transformation
The first step is to merge the training and test sets to create one data set, namely train/X_train.txt with test/X_test.txt, train/Y_train.text with test/Y_test and train/subject_train.txt with test/subject_test.txt

The second step is to read features.txt and extract only the measures on the mean and standard deviation for each measurement. All measurements appear to be floating point numbers in the range of (-1, 1).

The third step is to read activity_labels.txt and apply descriptive activity names to label the activities in the data set. E.g. walking, walkingupstairs, walkingdownstairs and etc.

The fourth step is to label the data set with descriptive names. All feature names and activity names are converted to lowercase with underscores and brackets removed. Then the data frame from step 2 is merged with the data frames containing activity labels and subject IDs. The result is then saved into merged_clean_data.txt.

The final step is to create an independent tidy data set with the average of each measurement for each activity and subject. The result is then saved into data_with_averages.txt.