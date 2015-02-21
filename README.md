Getting and Cleaning Data
=========================
## Course Project Read Me
* Download and unzip the dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your local drive. E.g. C:/Users/yourname/Documents/R/Course Project/

* Place run_analysis.R into C:/Users/yourname/Documents/R/Course Project/UCI HAR Dataset/

* In RStudio, enter the following commands into the console.
````
setwd("C:/Users/yourname/Documents/R/Course Project\UCI HAR Dataset/")
source("run_analysis.R")
````

* To read data, enter the following command into the console.
````
data <- read.table("tidy_data_with_averages.txt")
````